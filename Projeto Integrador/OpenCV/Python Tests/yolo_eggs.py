import cv2
from ultralytics import YOLO
from ultralytics.engine.results import Results, Boxes, Annotator

model = YOLO("models/bestv2.pt", task="detect")
image_path = "datasets/cvr_egg/test/images/IMG_20241024_160643_TIMEBURST19_jpg.rf.4a74979d9c65ffc321eb7c4044744e00.jpg"

# datasets\cvr_egg\test\images\IMG_20241030_154905_jpg.rf.eb89f2420f86ae1877e60e09b6c5fb55.jpg
# datasets\cvr_egg\test\images\IMG_20241030_154554_jpg.rf.4111464a138174e77af06a90bf4648ee.jpg
# datasets\cvr_egg\test\images\IMG_20241030_154554_jpg.rf.4111464a138174e77af06a90bf4648ee.jpg
# datasets\cvr_egg\test\images\IMG_20241024_160643_TIMEBURST19_jpg.rf.4a74979d9c65ffc321eb7c4044744e00.jpg
# datasets\cvr_egg\test\images\IMG_20241027_104709_TIMEBURST8_jpg.rf.fbb7856f1c905321a85eb2db3fed976f.jpg
# datasets\cvr_egg\valid\images\IMG_20241024_151433_TIMEBURST4_jpg.rf.6e13f08ef214bd2c13e733a59270b741.jpg

#img = cv2.imread(image_path)

#results = model(image_path)

cam = cv2.VideoCapture(1)

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

# result_obj = Results(results)
# boxes_obj = Boxes(results[0].boxes)

# print(result_obj)
# print(boxes_obj)

cv2.imshow('YOLO V11 Detection', img)
cv2.waitKey(0)
