import cv2
import torch
import threading
import customtkinter as ctk
from PIL import Image, ImageTk
from ultralytics import YOLO
from motor import move_step_motor
from inference import get_classes, get_classes_ids_from_parsed_results, get_parsed_results
from img_drawing import draw_masks_segmentation

class YoloCameraApp:
    def __init__(self, root):
        self.root = root
        self.root.title("YOLOv11 Viewer")
        self.root.attributes("-fullscreen", True)
        self.root.bind("<Escape>", lambda e: self.exit_app())

        self.status_text = ctk.StringVar(value="Status: Live Camera")

        self.root.grid_columnconfigure(0, weight=1)
        self.root.grid_columnconfigure(1, weight=2)
        self.root.grid_rowconfigure(0, weight=1)

        # Control Panel
        self.control_frame = ctk.CTkFrame(self.root)
        self.control_frame.grid(row=0, column=0, sticky="nsew", padx=10, pady=10)

        self.start_button = ctk.CTkButton(self.control_frame, text="Start (Take Photo)", command=self.handle_start)
        self.stop_button = ctk.CTkButton(self.control_frame, text="Stop", command=self.handle_stop)
        self.reset_button = ctk.CTkButton(self.control_frame, text="Reset", command=self.handle_reset)

        self.start_button.pack(pady=20, fill="x", padx=20)
        self.stop_button.pack(pady=20, fill="x", padx=20)
        self.reset_button.pack(pady=20, fill="x", padx=20)

        # Video Panel
        self.video_frame = ctk.CTkFrame(self.root)
        self.video_frame.grid(row=0, column=1, sticky="nsew", padx=10, pady=10)

        self.video_label = ctk.CTkLabel(self.video_frame, text="")
        self.video_label.pack(expand=True, fill="both", padx=10, pady=10)

        self.status_label = ctk.CTkLabel(self.video_frame, textvariable=self.status_text, height=30)
        self.status_label.pack(fill="x", padx=10, pady=(0, 10))

        # Camera and model setup
        self.cap = cv2.VideoCapture(0)
        self.device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
        self.model = self.load_yolov11_model()

        self.running = True  # Controls frame update loop
        self.inference_mode = False  # Whether to show inference image instead of live feed
        self.last_inference_result = None  # Holds result frame temporarily
        self.tk_image = None

        self.frame_thread = threading.Thread(target=self.update_frame, daemon=True)
        self.frame_thread.start()

    def load_yolov11_model(self):
        model = YOLO("seg50epcvr2.pt")
        model.eval()
        return model

    def update_frame(self):
        screen_w = self.root.winfo_screenwidth()
        screen_h = self.root.winfo_screenheight()
        display_size = (int(screen_w * 2 / 3), int(screen_h - 100))

        while self.running:
            if not self.inference_mode:
                ret, frame = self.cap.read()
                if not ret:
                    continue

                resized = cv2.resize(frame, display_size)
                rgb = cv2.cvtColor(resized, cv2.COLOR_BGR2RGB)
                img = Image.fromarray(rgb)
                imgtk = ImageTk.PhotoImage(image=img)

                self.video_label.configure(image=imgtk)
                self.video_label.image = imgtk

                self.last_frame = frame.copy()  # Store the most recent frame for inference

            else:
                # Show last inference result
                annotated = cv2.resize(self.last_inference_result, display_size)
                rgb = cv2.cvtColor(annotated, cv2.COLOR_BGR2RGB)
                img = Image.fromarray(rgb)
                imgtk = ImageTk.PhotoImage(image=img)

                self.video_label.configure(image=imgtk)
                self.video_label.image = imgtk

    def run_inference(self, frame):
        # Save the captured frame as an image
        cv2.imwrite("captured_image.jpg", frame)

        print("Image captured and saved as captured_image.jpg")

        image = cv2.imread("captured_image.jpg")
        # Run inference
        results = self.model(image)[0]  # Assuming this returns one result
        parsed_results = get_parsed_results(results)
        ids_from_parsed_results = get_classes_ids_from_parsed_results(parsed_results)

        if 0 or 2 or 4 in ids_from_parsed_results:
            print("Improprio")
            move_step_motor(200)
        elif 3 in ids_from_parsed_results:
            print("Proprio")
            move_step_motor(300)
        else:
            print("Consumo")
            move_step_motor(400)
        # Draw and save output
        output_img = draw_masks_segmentation(image, parsed_results)
        cv2.imwrite("segmented_output.jpg", output_img)
        cv2.imshow('YOLO V11 Detection', output_img)
        cv2.waitKey(0)
        # return original
    
    def handle_start(self):
        if hasattr(self, "last_frame"):
            self.status_text.set("Status: Running Inference...")
            result = self.run_inference(self.last_frame)
            self.last_inference_result = result
            self.inference_mode = True
            self.status_text.set("Status: Inference Complete")

    def handle_stop(self):
        self.status_text.set("Status: Stopped")

    def handle_reset(self):
        self.inference_mode = False
        self.status_text.set("Status: Live Camera")

    def exit_app(self):
        self.running = False
        self.cap.release()
        self.root.destroy()


if __name__ == "__main__":
    root = ctk.CTk()
    app = YoloCameraApp(root)
    root.mainloop()
