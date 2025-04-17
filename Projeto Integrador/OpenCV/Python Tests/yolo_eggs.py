import torch
import onnx
import onnxruntime as ort
import numpy as np
import os
import cv2
from ultralytics import YOLO
from ultralytics.engine.results import Results, Boxes, Annotator

model = YOLO("models/bestv2.pt", task="detect")
image_path = "datasets/cvr_egg/test/images/IMG_20241020_102042_jpg.rf.10157a2d2fdd578317fe7b52b2f14f1d.jpg"

img = cv2.imread(image_path)

results = model(image_path)

for r in results:
        
        annotator = Annotator(img)
        
        boxes = r.boxes
        for box in boxes:
            
            b = box.xyxy[0]  # get box coordinates in (left, top, right, bottom) format
            c = box.cls
            annotator.box_label(b, model.names[int(c)])
          
img = annotator.result()  

result_obj = Results(results)
boxes_obj = Boxes(results[0].boxes)

print(result_obj)
print(boxes_obj)

cv2.imshow('YOLO V8 Detection', img)
cv2.waitKey(0)
