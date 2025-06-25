import cv2
from motor import move_step_motor
from result_dealing import get_parsed_results, get_classes, get_classes_ids_from_parsed_results
from img_drawing import draw_masks_segmentation

def run_inference_frame(model, cam):
    # Read a frame from the camera
    ret, frame = cam.read()
    # Check if the frame was read successfully
    if not ret:
        raise IOError("Cannot read frame")
    
    # Save the captured frame as an image
    cv2.imwrite("captured_image.jpg", frame)

    print("Image captured and saved as captured_image.jpg")

    image = cv2.imread("captured_image.jpg")
    # Run inference
    results = model(image)[0]  # Assuming this returns one result
    parsed_results = get_parsed_results(results)
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