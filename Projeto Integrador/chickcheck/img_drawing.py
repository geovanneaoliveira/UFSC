import random
import cv2

def draw_masks_segmentation(image, results, alpha=0.5, draw_boxes=True, draw_labels=True):
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


def draw_bounding_box(image, results, model):
    for r in results:
        annotator = Annotator(image)
        boxes = r.boxes
        for box in boxes:
            b = box.xyxy[0]  # get box coordinates in (left, top, right, bottom) format
            c = box.cls
            annotator.box_label(b, model.names[int(c)])
    img = annotator.result()
    return img  