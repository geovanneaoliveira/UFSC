import cv2
from ultralytics import YOLO
from ultralytics.engine.results import Results, Boxes, Annotator
from ultralytics import settings


model = YOLO("models/best.pt", task="detect")

# Update a setting

print(model.model)