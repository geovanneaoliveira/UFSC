from ultralytics import YOLO
import cv2
import numpy as np
import random

def draw_yolov11_masks(image, results, alpha=0.5, draw_boxes=True, draw_labels=True):
    """
    Draws segmentation masks on an image from YOLOv11 segmentation model results.

    Parameters:
        image (np.ndarray): The original image (H x W x 3).
        results (List[dict]): List of detections, each with keys: 'mask', 'box', 'class', 'score'.
        alpha (float): Transparency of the mask overlay.
        draw_boxes (bool): Whether to draw bounding boxes.
        draw_labels (bool): Whether to draw class labels.

    Returns:
        np.ndarray: The image with segmentation masks drawn.
    """
    overlay = image.copy()
    output = image.copy()

    # Generate a unique color for each class
    color_map = {}

    for det in results:
        class_id = det['class']
        score = det.get('score', None)
        mask = det['mask']  # Expected shape: H x W, binary mask
        box = det.get('box', None)

        if class_id not in color_map:
            color_map[class_id] = [random.randint(0, 255) for _ in range(3)]
        color = color_map[class_id]
        
        # Resize the mask to match the image size
        original_height, original_width = image.shape[:2]
        mask_resized = cv2.resize(mask.astype(np.uint8), (original_width, original_height), interpolation=cv2.INTER_NEAREST)

        # Create color mask
        colored_mask = np.zeros_like(image)
        for c in range(3):
            colored_mask[:, :, c] = mask_resized * color[c]

        overlay = cv2.addWeighted(overlay, 1.0, colored_mask, alpha, 0)

        # Draw bounding box and label
        if draw_boxes and box is not None:
            x1, y1, x2, y2 = map(int, box)
            cv2.rectangle(overlay, (x1, y1), (x2, y2), color, 2)

        if draw_labels and box is not None:
            label = f'Class {class_id}'
            if score is not None:
                label += f' {score:.2f}'
            x1, y1 = map(int, box[:2])
            cv2.putText(overlay, label, (x1, y1 - 10), cv2.FONT_HERSHEY_SIMPLEX,
                        0.5, color, 2, cv2.LINE_AA)

    # Blend overlay with original image
    cv2.addWeighted(overlay, alpha, output, 1 - alpha, 0, output)

    return output

model = YOLO("models/bestseg.pt")
image = cv2.imread("datasets/cvr_egg/test/images/IMG_20241024_160643_TIMEBURST19_jpg.rf.4a74979d9c65ffc321eb7c4044744e00.jpg")

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

# Draw and save output
output_img = draw_yolov11_masks(image, parsed_results)
cv2.imwrite("segmented_output.jpg", output_img)
cv2.imshow('YOLO V11 Detection', output_img)
cv2.waitKey(0)
