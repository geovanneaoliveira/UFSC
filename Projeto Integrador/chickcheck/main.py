import cv2
import serial
from ultralytics import YOLO
from inference import run_inference

model = YOLO("models/seg50epcvr2.pt")
cam = cv2.VideoCapture(0)

# Check if the camera is opened successfully
if not cam.isOpened():
    raise IOError("Cannot open webcam")

# Replace with your actual serial port (e.g., 'COM3' or '/dev/ttyUSB0')
ser = serial.Serial('COM3', 9600, timeout=1)

try:
    while True:
        if ser.in_waiting:
            line = ser.readline().decode('utf-8').strip()
            if line == "BUTTON_PRESSED":
                run_inference(model, cam)
            elif line == "STOP":
                print("Stop button pressed on Arduino. Exiting loop...")
                break
except KeyboardInterrupt:
    print("Program stopped by user.")
finally:
    cam.release()
    ser.close()

