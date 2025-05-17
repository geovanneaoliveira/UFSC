import cv2
from ultralytics import YOLO
from ultralytics.engine.results import Results, Boxes, Annotator

model = YOLO("models/bestv2.pt", task="detect")
image_path = "datasets/cvr_egg/test/images/IMG_20241030_154554_jpg.rf.4111464a138174e77af06a90bf4648ee.jpg"

# datasets/cvr_egg/test/images/IMG_20241030_154905_jpg.rf.eb89f2420f86ae1877e60e09b6c5fb55.jpg
# datasets/cvr_egg/test/images/IMG_20241030_154554_jpg.rf.4111464a138174e77af06a90bf4648ee.jpg
# datasets/cvr_egg/test/images/IMG_20241030_154554_jpg.rf.4111464a138174e77af06a90bf4648ee.jpg
# datasets/cvr_egg/test/images/IMG_20241024_160643_TIMEBURST19_jpg.rf.4a74979d9c65ffc321eb7c4044744e00.jpg
# datasets/cvr_egg/test/images/IMG_20241027_104709_TIMEBURST8_jpg.rf.fbb7856f1c905321a85eb2db3fed976f.jpg
# datasets/cvr_egg/valid/images/IMG_20241024_151433_TIMEBURST4_jpg.rf.6e13f08ef214bd2c13e733a59270b741.jpg

raw_img = cv2.imread(image_path)

height, width = raw_img.shape[:2]

# Determine the size of the square
min_dim = min(height, width)

# Calculate coordinates to crop the image to a centered square
top = (height - min_dim) // 2
left = (width - min_dim) // 2
square_crop = raw_img[top:top + min_dim, left:left + min_dim]

# Resize the cropped square to 600x600
resized_image = cv2.resize(square_crop, (640, 640))

# # Save the result
# cv2.imwrite('resized_square.jpg', square_crop)

# # Optional: Display the result
# cv2.imshow('Square Resized Image', resized_image)
# cv2.waitKey(0)
# cv2.destroyAllWindows()

results = model(resized_image)

for r in results:
        
        annotator = Annotator(resized_image)
        
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


# cv2.imwrite('resized_square.jpg', square_crop)
# cv2.imshow('YOLO V11 Detection', img)
# cv2.waitKey(0)
