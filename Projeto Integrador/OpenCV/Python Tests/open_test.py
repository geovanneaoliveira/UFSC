import cv2

# Initialize the camera (0 is usually the default camera)
cam = cv2.VideoCapture(1)

# Check if the camera is opened successfully
if not cam.isOpened():
    raise IOError("Cannot open webcam")

# Read a frame from the camera
ret, frame = cam.read()

# Check if the frame was read successfully
if not ret:
    raise IOError("Cannot read frame")

# Save the captured frame as an image
cv2.imwrite("captured_image.jpg", frame)

# Release the camera
cam.release()

print("Image captured and saved as captured_image.jpg")