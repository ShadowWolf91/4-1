import cv2
import numpy as np
import matplotlib.pyplot as plt
# 1-2
# Загрузка изображения
image = cv2.imread('Love.jpg')

# Преобразование в оттенки серого
gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

# Пороговая бинаризация
_, binary_image = cv2.threshold(gray_image, 127, 255, cv2.THRESH_BINARY)

# Адаптивная бинаризация
binary_image_adaptive = cv2.adaptiveThreshold(gray_image, 255, cv2.ADAPTIVE_THRESH_MEAN_C, cv2.THRESH_BINARY, 11, 2)

# Вывод изображений на экран
cv2.imshow('Original Image', image)
# Объединение изображений горизонтально
combined_image = np.hstack((gray_image, binary_image, binary_image_adaptive))
# Вывод объединенного изображения на экран
cv2.imshow('Combined Images', combined_image)
# Ожидание нажатия клавиши для закрытия окна
cv2.waitKey(0)

# 3
# Загрузка затемненного изображения
dark_image = cv2.imread('tent.jpg', 0)

# Построение гистограммы затемненного изображения
hist_dark = cv2.calcHist([dark_image], [0], None, [256], [0, 256])

# Выравнивание освещенности изображения
equalized_image = cv2.equalizeHist(dark_image)

# Объединение изображений горизонтально
combined_image = np.hstack((dark_image, equalized_image))
# Вывод объединенного изображения на экран
cv2.imshow('Combined Images', combined_image)
# Ожидание нажатия клавиши для закрытия окон
cv2.waitKey(0)

# Построение гистограммы выровненного изображения
hist_equalized = cv2.calcHist([equalized_image], [0], None, [256], [0, 256])

# Отображение гистограмм
plt.figure(figsize=(10, 5))
plt.subplot(1, 2, 1)
plt.plot(hist_dark, color='black')
plt.title('Histogram of Dark Image')
plt.xlabel('Pixel Value')
plt.ylabel('Frequency')
plt.subplot(1, 2, 2)
plt.plot(hist_equalized, color='black')
plt.title('Histogram of Equalized Image')
plt.xlabel('Pixel Value')
plt.ylabel('Frequency')
plt.tight_layout()
plt.show()

# 4
# Загрузка изображения с шумами
image = cv2.imread('spider.jpg')

# Применение фильтра blur()
blurred_image = cv2.blur(image, (5, 5))

# Применение фильтра GaussianBlur()
gaussian_blurred_image = cv2.GaussianBlur(image, (5, 5), 0)

# Применение фильтра medianBlur()
median_blurred_image = cv2.medianBlur(image, 5)

combined_image = np.hstack((image, blurred_image, gaussian_blurred_image, median_blurred_image))
# Вывод объединенного изображения на экран
cv2.imshow('Combined Images', combined_image)
# Ожидание нажатия клавиши для закрытия окон
cv2.waitKey(0)

# 5
# Загрузка изображения
image = cv2.imread('example.png', 0)

# Преобразование в бинарное изображение
_, binary_image = cv2.threshold(image, 127, 255, cv2.THRESH_BINARY)

# Операция эрозии
eroded_image = cv2.erode(binary_image, None, iterations=1)

# Операция дилатации
dilated_image = cv2.dilate(binary_image, None, iterations=1)

# Отображение изображений на экран
combined_image = np.hstack((image, binary_image, eroded_image, dilated_image))
# Вывод объединенного изображения на экран
cv2.imshow('Combined Images', combined_image)
# Ожидание нажатия клавиши для закрытия окон
cv2.waitKey(0)