import numpy as np
import cv2
from matplotlib import pyplot as plt

img = cv2.imread('3HeapMoney.jpg')
gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
ret, thresh = cv2.threshold(gray,0,255,cv2.THRESH_BINARY_INV+cv2.THRESH_OTSU)

plt.imshow(thresh)
plt.show()

# noise removal
kernel = np.ones((3,3),np.uint8)
opening = cv2.morphologyEx(thresh,cv2.MORPH_OPEN,kernel, iterations = 1)

# sure background area
sure_bg = cv2.dilate(opening,kernel,iterations=3)

# Finding sure foreground area
dist_transform = cv2.distanceTransform(opening,cv2.DIST_L2,5)
ret, sure_fg = cv2.threshold(dist_transform,0.7*dist_transform.max(),255,0)
plt.imshow(dist_transform)
plt.show()
# Finding unknown region
sure_fg = np.uint8(sure_fg)
unknown = cv2.subtract(sure_bg,sure_fg)

# Marker labelling
ret, markers = cv2.connectedComponents(sure_fg)
count_objects = ret - 1  # Вычитаем фон
print(f"Количество предметов на изображении: {count_objects}")

# Add one to all labels so that sure background is not 0, but 1
markers = markers+1

# Now, mark the region of unknown with zero
markers[unknown==255] = 0

plt.imshow(unknown)
plt.show()

markers = cv2.watershed(img,markers)
img[markers == -1] = [255,0,0]
plt.imshow(markers)
plt.show()
plt.imshow(img)
plt.show()

import cv2
import numpy as np

# Загрузка изображения
image = cv2.imread('red-chili-peppers.jpg')
hsv = cv2.cvtColor(image,cv2.COLOR_BGR2HSV)

# Определение диапазона цвета
# Определение диапазона красного цвета в HSV
lower_red = np.array([0, 100, 100])
upper_red = np.array([10, 255, 255])
mask1 = cv2.inRange(hsv, lower_red, upper_red)

lower_red = np.array([170, 100, 100])
upper_red = np.array([180, 255, 255])
mask2 = cv2.inRange(hsv, lower_red, upper_red)

# Объединение масок
mask = mask1 + mask2

# Применение маски к исходному изображению
result = cv2.bitwise_and(image, image, mask=mask)

cv2.imshow('Original Image', image)
cv2.imshow('Color Detected Image', result)
cv2.waitKey(0)
cv2.destroyAllWindows()
plt.show()