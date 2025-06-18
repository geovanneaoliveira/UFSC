from ultralytics import YOLO
import cv2
import numpy as np
from move_ard import move_motor
from yoloseg import draw_yolov11_masks


imgpath = "datasets/cvr_egg/test/images/IMG_20241024_160643_TIMEBURST19_jpg.rf.4a74979d9c65ffc321eb7c4044744e00.jpg"
model = YOLO("models/seg50epcvr2.pt")
image = cv2.imread(imgpath)

# Run inference
results = model(image)[0]  # Assuming this returns one result
parsed_results = []

for seg, cls_id, conf, box in zip(results.masks.data, results.boxes.cls, results.boxes.conf, results.boxes.xyxy):
    parsed_results.append({
        "class": int(cls_id),
        "score": float(conf),
        "mask": seg.cpu().numpy().astype(np.uint8),
        "box": box.cpu().numpy().tolist()
    })

results_arr = []

for p_result in parsed_results:
    results_arr.append(p_result['class'])

if 0 or 2 or 4 in results_arr:
    print("Improprio")
    move_motor(200)
elif 3 in results_arr:
    print("Proprio")
    move_motor(300)
else:
    print("Consumo")
    move_motor(400)

# Draw and save output
output_img = draw_yolov11_masks(image, parsed_results)
cv2.imwrite("segmented_output.jpg", output_img)
cv2.imshow('YOLO V11 Detection', output_img)
cv2.waitKey(0)

