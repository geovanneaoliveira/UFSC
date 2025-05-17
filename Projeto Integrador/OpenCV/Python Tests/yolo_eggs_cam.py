import cv2
from ultralytics import YOLO
from ultralytics.engine.results import Results, Boxes, Annotator

model = YOLO("models/bestv2.pt", task="detect")

cam = cv2.VideoCapture(0)

# Check if the camera is opened successfully
if not cam.isOpened():
    raise IOError("Cannot open webcam")

# Read a frame from the camera
ret, frame = cam.read()

# Check if the frame was read successfully
if not ret:
    raise IOError("Cannot read frame")

# Save the captured frame as an image
cv2.imwrite("captured_image.jpg", frame)

# Release the camera
cam.release()

print("Image captured and saved as captured_image.jpg")

img = cv2.imread("captured_image.jpg")

results = model("captured_image.jpg")

for r in results:
        
        annotator = Annotator(img)
        
        boxes = r.boxes
        for box in boxes:
            
            b = box.xyxy[0]  # get box coordinates in (left, top, right, bottom) format
            c = box.cls
            annotator.box_label(b, model.names[int(c)])
          
img = annotator.result()  

cv2.imshow('YOLO V11 Detection', img)
cv2.waitKey(0)
