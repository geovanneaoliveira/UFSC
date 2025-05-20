import albumentations as A
from albumentations.pytorch import ToTensorV2
import cv2
import numpy as np

transform = A.Compose([
    A.Blur(p=0.01, blur_limit=(3, 7)),
    A.MedianBlur(p=0.01, blur_limit=(3, 7)),
    A.ToGray(p=0.01, mode='weighted'),  
    A.CLAHE(p=0.01, clip_limit=(1.0, 4.0)
            , tile_grid_size=(8, 8)),
    A.HorizontalFlip(p=0.5),  
    A.VerticalFlip(p=0.5),
    A.Affine(shear={"x": (-10, 10)
                    , "y": (-10, 10)}, p=0.3),
    ToTensorV2()
])
# Example: Apply to an image
def apply_augmentation(image_path):
    image = cv2.imread(image_path)
    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)  # Convert to RGB for consistency
    augmented = transform(image=image)
    return augmented['image']

# Example usage
# tensor_image = apply_augmentation("your_image.jpg")
