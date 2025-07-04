import cv2
from ultralytics import YOLO
from ultralytics.engine.results import Results, Boxes, Annotator
from img_drawing import draw_masks_segmentation
from result_dealing import get_parsed_results
model = YOLO("yolo11nseg100.pt")
image_path0 = "cvr_egg2/valid/images/IMG_20241027_102109_TIMEBURST5_jpg.rf.c025cde9575089f8836858d35c4b25d9.jpg"
image_path1 = "IMG_20241020_101338_jpg.rf.dc6f668f5aa3ecde88ba563d69e78659.jpg"
image_path2 = "cvr_egg2/valid/images/IMG_20241027_095554_TIMEBURST3_jpg.rf.0a1abb35aca811fd6232a8ea5b6a3b62.jpg"
image_path3 = "cvr_egg2/valid/images/IMG_20241027_104935_TIMEBURST29_jpg.rf.964f9cb046e4624e45c808feaa63a8c7.jpg"

raw_img = cv2.imread(image_path0)
results = model(raw_img)[0]
parsed_results = get_parsed_results(results)
output_image0 = draw_masks_segmentation(model=model, image=raw_img, results=parsed_results)

raw_img = cv2.imread(image_path1)
results = model(raw_img)[0]
parsed_results = get_parsed_results(results)
output_image1 = draw_masks_segmentation(model=model, image=raw_img, results=parsed_results)

raw_img = cv2.imread(image_path2)
results = model(raw_img)[0]
parsed_results = get_parsed_results(results)
output_image2 = draw_masks_segmentation(model=model, image=raw_img, results=parsed_results)

raw_img = cv2.imread(image_path3)
results = model(raw_img)[0]
parsed_results = get_parsed_results(results)
output_image3 = draw_masks_segmentation(model=model, image=raw_img, results=parsed_results)

cv2.imshow('ChickCheck Model Test 1', output_image0)
cv2.imshow('ChickCheck Model Test 2', output_image1)
cv2.imshow('ChickCheck Model Test 3', output_image2)
cv2.imshow('ChickCheck Model Test 4', output_image3)
cv2.waitKey(0)
