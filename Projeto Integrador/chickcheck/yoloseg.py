from ultralytics import YOLO
import cv2
from motor import move_step_motor
from result_dealing import get_parsed_results, get_classes, get_classes_ids_from_parsed_results
from img_drawing import draw_masks_segmentation

# datasets\cvr_egg2\test\images\IMG_20241024_155952_TIMEBURST15_jpg.rf.75edaed86f44495c5b4fb3959c81f881.jpg
# imgpath = "datasets/cvr_egg/test/images/IMG_20241024_155952_TIMEBURST15_jpg.rf.75edaed86f44495c5b4fb3959c81f881.jpg"
imgpath = "datasets/cvr_egg/test/images/IMG_20241024_160643_TIMEBURST19_jpg.rf.4a74979d9c65ffc321eb7c4044744e00.jpg"
model = YOLO("models/seg50epcvr2.pt")
image = cv2.imread(imgpath)

# Run inference
results = model(image)[0]  # Assuming this returns one result

parsed_results = get_parsed_results(results)
obtained_classes = get_classes(model.names, results)
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

