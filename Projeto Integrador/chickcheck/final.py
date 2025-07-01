import cv2
import torch
import threading
import customtkinter as ctk
import serial
import time
from PIL import Image
from ultralytics import YOLO
from motor import move_dcmotor_serial
from inference import get_classes, get_classes_ids_from_parsed_results, get_parsed_results
from img_drawing import draw_masks_segmentation

class YoloCameraApp:
    def __init__(self, root):
        self.root = root
        self.root.title("ChickCheck")
        # self.root.attributes("-fullscreen", True)
        self.root.state("zoomed")  # For Windows and most Linux
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

        # Right side: live video (top), separator, photo preview (bottom), and status
        self.video_frame = ctk.CTkFrame(self.root)
        self.video_frame.grid(row=0, column=1, sticky="nsew", padx=10, pady=10)

        # Configure rows for 50/50 layout
        self.video_frame.grid_rowconfigure(0, weight=1)  # Top half (live video)
        self.video_frame.grid_rowconfigure(1, weight=0)  # Separator
        self.video_frame.grid_rowconfigure(2, weight=1)  # Bottom half (photo)
        self.video_frame.grid_rowconfigure(3, weight=0)  # Status label
        self.video_frame.grid_columnconfigure(0, weight=1)

        # Live video label
        self.video_label = ctk.CTkLabel(self.video_frame, text="")
        self.video_label.grid(row=0, column=0, sticky="nsew", padx=10, pady=(10, 0))

        # Visual border (separator)
        self.separator = ctk.CTkFrame(self.video_frame, height=2, fg_color="#444")
        self.separator.grid(row=1, column=0, sticky="ew", padx=20, pady=5)
        
        # Captured photo label
        self.photo_label = ctk.CTkLabel(self.video_frame, text="No photo yet")
        self.photo_label.grid(row=2, column=0, sticky="nsew", padx=10, pady=(0, 10))

        # Status label
        self.status_label = ctk.CTkLabel(self.video_frame, textvariable=self.status_text, height=30)
        self.status_label.grid(row=3, column=0, sticky="ew", padx=10, pady=(0, 10))

        # Camera and model
        self.cap = cv2.VideoCapture(0)
        self.device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
        self.model = self.load_yolov11_model()
        
        self.running = True
        self.inference_mode = False
        self.last_frame = None
        self.last_inference_result = None
        self.tk_image = None  # CTkImage
        self.update_frame()

        self.ser = serial.Serial("COM5", 9600)
        listener_thread = threading.Thread(target=self.listen_serial, daemon=True)
        listener_thread.start()

    def listen_serial(self):        
        while True:
            if self.ser.in_waiting:
                msg = self.ser.readline().decode().strip()
                print(f"Received: {msg}")

                # Change behavior based on message
                if msg == "Ovo chegou, parando motor":
                    if self.last_frame is not None:
                        self.status_text.set("Status: Inference running...")
                        time.sleep(5)
                        self.last_inference_result = self.run_inference(self.last_frame)
                        self.inference_mode = True
                        self.status_text.set("Status: Inferência concluída")
                elif msg == "Ovo não está na posicao inicial":
                    self.status_text.set("Status: Posicione corretamente!")
    
    def load_yolov11_model(self):
        model = YOLO("seg50epcvr2.pt")
        model.eval()
        return model

    def update_frame(self):
        screen_w = self.root.winfo_screenwidth()
        screen_h = self.root.winfo_screenheight()
        display_size = (int(screen_w * 2 / 3), int(screen_h - 100))
        ret, frame = self.cap.read()
        if ret:
            self.last_frame = frame.copy()
            frame = cv2.resize(frame, display_size)
            frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            img = Image.fromarray(frame)
            if self.tk_image is None:
                self.tk_image = ctk.CTkImage(light_image=img, dark_image=img, size=img.size)
                self.video_label.configure(image=self.tk_image)
            else:
                self.tk_image.configure(light_image=img, dark_image=img)

        elif self.running and self.inference_mode:
            annotated = cv2.resize(self.last_inference_result, display_size)
            annotated = cv2.cvtColor(annotated, cv2.COLOR_BGR2RGB)
            img = Image.fromarray(annotated)

            self.tk_image.configure(light_image=img, dark_image=img)

        # Schedule next update (every 30ms)
        self.root.after(30, self.update_frame)


    def run_inference(self, frame):
        # Save the captured frame as an image
        cv2.imwrite("captured_image.jpg", frame)
        print("Image captured and saved as captured_image.jpg")
        image = cv2.imread("captured_image.jpg")
        # Run inference
        results = self.model(image)[0]
        time.sleep(1)
        parsed_results = get_parsed_results(results)
        if parsed_results == "Nothing detected": 
            img = Image.open("captured_image.jpg")
            img_ctk = ctk.CTkImage(light_image=img, dark_image=img, size=(640, 640))
            self.photo_label.configure(image=img_ctk, text="")
            self.photo_label.image = img_ctk
            print("Consumo")
            move_dcmotor_serial(self.ser, "ovo para consumo")
        else:
            output_img = draw_masks_segmentation(image, parsed_results)
            cv2.imwrite("segmented_output.jpg", output_img)
            img = Image.open("segmented_output.jpg")
            img_ctk = ctk.CTkImage(light_image=img, dark_image=img, size=(640, 640))
            self.photo_label.configure(image=img_ctk, text="")
            self.photo_label.image = img_ctk
            ids_from_parsed_results = get_classes_ids_from_parsed_results(parsed_results)
            print(get_classes(self.model.names, results))
            if 0 or 2 or 4 in ids_from_parsed_results:
                print("Improprio")
                move_dcmotor_serial(self.ser, "ovo improprio")
            elif 3 in ids_from_parsed_results:
                print("Proprio")
                move_dcmotor_serial(self.ser, "ovo para incubar")
            
                
    
    def handle_start(self):
        move_dcmotor_serial(self.ser, "start motor")
        self.status_text.set("Começo")

    def handle_stop(self):
        move_dcmotor_serial(self.ser, "stop motor")
        self.status_text.set("Status: Stopped")

    def handle_reset(self):
        move_dcmotor_serial(self.ser, "reset motor")
        self.inference_mode = False
        self.status_text.set("Status: Live Camera")

    def exit_app(self):
        self.running = False
        self.ser.close()
        self.cap.release()
        self.root.destroy()

if __name__ == "__main__":
    root = ctk.CTk()
    app = YoloCameraApp(root)

    # Delay maximize until window is fully initialized
    def maximize_window(event=None):
        root.state("zoomed")

    root.after(100, maximize_window)
    root.mainloop()