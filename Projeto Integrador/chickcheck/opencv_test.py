import cv2
import matplotlib.pyplot as plt
import numpy as np
from scipy.stats import skew, kurtosis
image = cv2.imread('cvr_egg2/train/images/IMG_20241020_113746_TIMEBURST28_jpg.rf.1809d62b5f7a44e474d7763f0597cd91.jpg')  # Replace with your actual path
imageRGB = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
cv2.imshow("Original Image", image)
denoised = cv2.blur(image, (5, 5))
cv2.imshow("Denoised Image", denoised)
B, G, R = cv2.split(denoised)
_, binary_mask = cv2.threshold(R, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)
egg_area = cv2.bitwise_and(image, image, mask=binary_mask)

cv2.imshow("Binary Mask (Thresholded R Channel)", binary_mask)
cv2.imshow("Segmented Egg Area", egg_area)

def compute_normalized_histogram(channel, bins=256):
    """Compute the normalized histogram of a given color channel."""
    hist = cv2.calcHist([channel], [0], None, [bins], [0, 256])  # Compute histogram
    hist = hist / hist.sum()  # Normalize
    return hist

# Split into R, G, B channels
R, G, B = cv2.split(imageRGB)

# Compute normalized histograms
hist_R = compute_normalized_histogram(R)
hist_G = compute_normalized_histogram(G)
hist_B = compute_normalized_histogram(B)

# Plot the histograms
plt.figure(figsize=(10, 5))
plt.plot(hist_R, color='red', label="Red Channel")
plt.plot(hist_G, color='green', label="Green Channel")
plt.plot(hist_B, color='blue', label="Blue Channel")
plt.title("Normalized Histograms of RGB Channels")
plt.xlabel("Pixel Intensity")
plt.ylabel("Normalized Frequency")
plt.legend()
plt.show()


def compute_color_statistics(channel):
    """Compute mean, standard deviation, skewness, and kurtosis for a channel."""
    mean_val = np.mean(channel)
    std_dev = np.std(channel)
    skewness = skew(channel.ravel())  # Flatten the image array
    kurt = kurtosis(channel.ravel())

    return mean_val, std_dev, skewness, kurt

# Extract statistics
stats_R = compute_color_statistics(R)
stats_G = compute_color_statistics(G)
stats_B = compute_color_statistics(B)

# Display results
print(f"Red Channel: Mean={stats_R[0]:.2f}, StdDev={stats_R[1]:.2f}, Skewness={stats_R[2]:.2f}, Kurtosis={stats_R[3]:.2f}")
print(f"Green Channel: Mean={stats_G[0]:.2f}, StdDev={stats_G[1]:.2f}, Skewness={stats_G[2]:.2f}, Kurtosis={stats_G[3]:.2f}")
print(f"Blue Channel: Mean={stats_B[0]:.2f}, StdDev={stats_B[1]:.2f}, Skewness={stats_B[2]:.2f}, Kurtosis={stats_B[3]:.2f}")

cv2.destroyAllWindows()
cv2.waitKey(0)

