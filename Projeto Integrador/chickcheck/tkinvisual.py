import cv2
import torch
import threading
import customtkinter as ctk
from PIL import Image, ImageTk
import numpy as np
from ultralytics import YOLO


class YoloCameraApp:
    def __init__(self, root):
        self.root = root
        self.root.title("YOLOv11 Real-Time Viewer")
        self.root.attributes("-fullscreen", True)
        self.root.bind("<Escape>", lambda e: self.exit_app())

        self.status_text = ctk.StringVar(value="Status: Running...")

        self.root.grid_columnconfigure(0, weight=1)
        self.root.grid_columnconfigure(1, weight=2)
        self.root.grid_rowconfigure(0, weight=1)

        # Left control panel
        self.control_frame = ctk.CTkFrame(self.root)
        self.control_frame.grid(row=0, column=0, sticky="nsew", padx=10, pady=10)

        self.start_button = ctk.CTkButton(self.control_frame, text="Start", command=self.handle_start)
        self.stop_button = ctk.CTkButton(self.control_frame, text="Stop", command=self.handle_stop)
        self.reset_button = ctk.CTkButton(self.control_frame, text="Reset", command=self.handle_reset)

        self.start_button.pack(pady=20, fill="x", padx=20)
        self.stop_button.pack(pady=20, fill="x", padx=20)
        self.reset_button.pack(pady=20, fill="x", padx=20)

        # Right side: contains live video (top) and photo (bottom)
        self.video_frame = ctk.CTkFrame(self.root)
        self.video_frame.grid(row=0, column=1, sticky="nsew", padx=10, pady=10)
        self.video_frame.grid_rowconfigure(0, weight=3)  # Live feed
        self.video_frame.grid_rowconfigure(1, weight=2)  # Captured photo
        self.video_frame.grid_columnconfigure(0, weight=1)

        # Live video display (top)
        self.video_label = ctk.CTkLabel(self.video_frame, text="")
        self.video_label.grid(row=0, column=0, sticky="nsew", padx=10, pady=(10, 5))

        # Captured photo display (bottom)
        self.photo_label = ctk.CTkLabel(self.video_frame, text="No photo yet")
        self.photo_label.grid(row=1, column=0, sticky="nsew", padx=10, pady=(5, 10))

        # Status below both
        self.status_label = ctk.CTkLabel(self.video_frame, textvariable=self.status_text, height=30)
        self.status_label.grid(row=2, column=0, sticky="ew", padx=10, pady=(0, 10))

        # Camera + model
        self.cap = cv2.VideoCapture(0)
        self.running = True
        self.tk_image = None

        self.device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
        self.model = self.load_yolov11_model()

        # Start frame thread
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
            ret, frame = self.cap.read()
            if not ret:
                continue

            annotated = self.run_inference(frame)
            annotated = cv2.resize(annotated, display_size)
            annotated = cv2.cvtColor(annotated, cv2.COLOR_BGR2RGB)

            img = Image.fromarray(annotated)
            imgtk = ImageTk.PhotoImage(image=img)

            self.video_label.configure(image=imgtk)
            self.video_label.image = imgtk  # keep reference to avoid garbage collection

    def run_inference(self, frame):
        original = frame.copy()
        img = cv2.resize(frame, (640, 640))
        img = img / 255.0
        img = torch.from_numpy(img).float().permute(2, 0, 1).unsqueeze(0).to(self.device)

        with torch.no_grad():
            preds = self.model(img)[0]

        preds = preds.cpu().numpy()

        for pred in preds:
            x1, y1, x2, y2, conf, cls = pred
            if conf > 0.3:
                cv2.rectangle(original, (int(x1), int(y1)), (int(x2), int(y2)), (0, 255, 0), 2)
                cv2.putText(original, f"ID {int(cls)}: {conf:.2f}", (int(x1), int(y1) - 10),
                            cv2.FONT_HERSHEY_SIMPLEX, 0.6, (0, 255, 0), 2)
        return original

    def handle_start(self):
        self.status_text.set("Status: Start pressed")

    def handle_stop(self):
        self.status_text.set("Status: Stop pressed")

    def handle_reset(self):
        self.status_text.set("Status: Reset pressed")

    def exit_app(self):
        self.running = False
        self.cap.release()
        self.root.destroy()


if __name__ == "__main__":
    root = ctk.CTk()
    app = YoloCameraApp(root)
    root.mainloop()
