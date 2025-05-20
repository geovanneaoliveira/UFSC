import cv2
from ultralytics import YOLO
from ultralytics.engine.results import Results, Boxes, Annotator

model = YOLO("models/best50ep.pt", task="detect")
image_path = "egg2.jpg"

# datasets/cvr_egg/test/images/IMG_20241030_154905_jpg.rf.eb89f2420f86ae1877e60e09b6c5fb55.jpg
# datasets/cvr_egg/test/images/IMG_20241030_154554_jpg.rf.4111464a138174e77af06a90bf4648ee.jpg
# datasets/cvr_egg/test/images/IMG_20241030_154554_jpg.rf.4111464a138174e77af06a90bf4648ee.jpg
# datasets/cvr_egg/test/images/IMG_20241024_160643_TIMEBURST19_jpg.rf.4a74979d9c65ffc321eb7c4044744e00.jpg
# datasets/cvr_egg/test/images/IMG_20241027_104709_TIMEBURST8_jpg.rf.fbb7856f1c905321a85eb2db3fed976f.jpg
# datasets/cvr_egg/valid/images/IMG_20241024_151433_TIMEBURST4_jpg.rf.6e13f08ef214bd2c13e733a59270b741.jpg

img = cv2.imread(image_path)

results = model(img)

for r in results:
        
        annotator = Annotator(img)
        
        boxes = r.boxes
        for box in boxes:
            
            b = box.xyxy[0]  # get box coordinates in (left, top, right, bottom) format
            c = box.cls
            annotator.box_label(b, model.names[int(c)])
          
img = annotator.result()  
classes_arr = []

for box in results[0].boxes:
        class_id = int(box.cls)  # Get class ID
        class_label = results[0].names[class_id]  # Get class label from class ID
        classes_arr.append(class_label)
        print(f'Detected class: {class_label}')  # Print class label

print(classes_arr)
print(results[0].names)

if "crack" or "spoiled area" or "broken yolk" or "break" in classes_arr:
    print("esteira avança, secundária direita - danificado")
elif "blood vessel" or "embryo" in classes_arr:
    print("esteira recua - fertil")
else:      
    print("esteira avança, secundária esquerda - infertil")

cv2.imshow('YOLO V11 Detection', img)
cv2.waitKey(0)
