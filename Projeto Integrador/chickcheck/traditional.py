import cv2
import numpy as np

# === 1. Carrega imagem e prepara ===
image = cv2.imread("cvr_egg2/train/images/IMG_20241030_154854_jpg.rf.f075ba3b7e3816466d788e1f9545ea87.jpg")
# image = cv2.imread("cvr_egg2/train/images/IMG_20241027_105345_TIMEBURST12_jpg.rf.9ad795cfa9584dab09a36768401e4279.jpg")
image_display = image.copy()
gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

# === 2. Detectar rachaduras com Canny ===
blurred = cv2.GaussianBlur(gray, (5, 5), 0)
edges = cv2.Canny(blurred, threshold1=30, threshold2=100)

contours, _ = cv2.findContours(edges.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
for cnt in contours:
    area = cv2.contourArea(cnt)
    if 100 < area < 1000:  # Rachaduras geralmente são finas
        x, y, w, h = cv2.boundingRect(cnt)
        cv2.rectangle(image_display, (x, y), (x+w, y+h), (0, 0, 255), 2)  # Vermelho = rachadura

# === 3. Detectar manchas internas escuras (possível embrião) ===
# Limiar adaptativo ou Otsu
_, thresh_embryo = cv2.threshold(blurred, 0, 255, cv2.THRESH_BINARY_INV + cv2.THRESH_OTSU)

# Remover ruídos pequenos
kernel = np.ones((3, 3), np.uint8)
cleaned = cv2.morphologyEx(thresh_embryo, cv2.MORPH_OPEN, kernel, iterations=2)

contours, _ = cv2.findContours(cleaned, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
for cnt in contours:
    area = cv2.contourArea(cnt)
    if 300 < area < 3000:  # Faixa sugerida para embriões
        x, y, w, h = cv2.boundingRect(cnt)
        cv2.rectangle(image_display, (x, y), (x+w, y+h), (255, 0, 0), 2)  # Azul = embrião

# === 4. Detectar manchas difusas escuras (podridão) ===
_, dark_mask = cv2.threshold(gray, 50, 255, cv2.THRESH_BINARY_INV)  # Intenso < 50 → escuro

contours, _ = cv2.findContours(dark_mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
for cnt in contours:
    area = cv2.contourArea(cnt)
    if area > 1000:  # Manchas grandes
        x, y, w, h = cv2.boundingRect(cnt)
        cv2.rectangle(image_display, (x, y), (x+w, y+h), (0, 255, 255), 2)  # Amarelo = estrago

# === 5. Exibir resultados ===
cv2.imshow("Resultado: Defeitos detectados", image_display)
cv2.imshow("Rachaduras (edges)", edges)
cv2.imshow("Embrião (limiar)", cleaned)
cv2.imshow("Podridão (mascara escura)", dark_mask)

cv2.waitKey(0)
cv2.destroyAllWindows()
