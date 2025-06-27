import cv2
import tkinter as tk
from PIL import Image, ImageTk

class FullscreenCameraApp:
    def __init__(self, window):
        self.window = window
        self.window.title("Fullscreen Camera App")

        # Set full screen
        self.window.attributes('-fullscreen', True)

        # Escape key to exit full screen
        self.window.bind("<Escape>", lambda e: self.close_app())

        # OpenCV capture
        self.cap = cv2.VideoCapture(0)

        # Container for layout
        self.main_frame = tk.Frame(self.window, bg="black")
        self.main_frame.pack(fill=tk.BOTH, expand=True)

        # Camera display area
        self.video_label = tk.Label(self.main_frame, bg="black")
        self.video_label.pack(fill=tk.BOTH, expand=True)

        # Button frame at bottom
        self.button_frame = tk.Frame(self.main_frame, bg="gray")
        self.button_frame.pack(fill=tk.X, side=tk.BOTTOM)

        self.btn1 = tk.Button(self.button_frame, text="Button 1", command=self.action1, height=2)
        self.btn2 = tk.Button(self.button_frame, text="Button 2", command=self.action2, height=2)
        self.btn3 = tk.Button(self.button_frame, text="Button 3", command=self.action3, height=2)

        self.btn1.pack(side=tk.LEFT, expand=True, fill=tk.X, padx=5, pady=5)
        self.btn2.pack(side=tk.LEFT, expand=True, fill=tk.X, padx=5, pady=5)
        self.btn3.pack(side=tk.LEFT, expand=True, fill=tk.X, padx=5, pady=5)

        # Start update loop
        self.update_frame()

    def update_frame(self):
        ret, frame = self.cap.read()
        if ret:
            screen_width = self.window.winfo_screenwidth()
            screen_height = self.window.winfo_screenheight()

            # Resize the frame to fit screen width while keeping aspect ratio
            frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            img = Image.fromarray(frame)
            img = img.resize((screen_width, screen_height - 100))
            imgtk = ImageTk.PhotoImage(image=img)

            self.video_label.imgtk = imgtk
            self.video_label.configure(image=imgtk)

        self.window.after(15, self.update_frame)

    def action1(self):
        print("Button 1 pressed")

    def action2(self):
        print("Button 2 pressed")

    def action3(self):
        print("Button 3 pressed")

    def close_app(self):
        self.cap.release()
        self.window.destroy()

# Run app
if __name__ == "__main__":
    root = tk.Tk()
    app = FullscreenCameraApp(root)
    root.mainloop()
