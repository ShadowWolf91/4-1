import cv2
import numpy as np
import matplotlib.pyplot as plt

# Загрузка изображения
image = cv2.imread('Love.jpg', cv2.IMREAD_GRAYSCALE)

# Применение оператора Собеля
sobel_x = cv2.Sobel(image, cv2.CV_64F, 1, 0, ksize=3)
sobel_y = cv2.Sobel(image, cv2.CV_64F, 0, 1, ksize=3)
sobel_combined = cv2.bitwise_or(sobel_x, sobel_y)

# Применение оператора Лапласа
laplacian = cv2.Laplacian(image, cv2.CV_64F)

# Применение детектора границ Кэнни
canny = cv2.Canny(image, threshold1=30, threshold2=100)

# Вывод изображений на экран
cv2.imshow('Original Image', image)
# Объединение изображений горизонтально
combined_image = np.hstack((sobel_combined, laplacian, canny))
# Вывод объединенного изображения на экран
cv2.imshow('Combined Images', combined_image)
# Ожидание нажатия клавиши для закрытия окна
cv2.waitKey(0)

# 2
# Загрузка изображения
# 1. Загрузка изображения
img = cv2.imread('BW.jpg')

imgray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
filtered_image = cv2.GaussianBlur(imgray, (3, 3), 0)

ret, thresh_img = cv2.threshold(filtered_image, 220, 255, cv2.THRESH_BINARY_INV)

contours, hierarchy = cv2.findContours(thresh_img, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE) #image, сontours, hierarchy, mode, method, offset

img_contours = np.zeros_like(img)
cv2.drawContours(img_contours, contours, -1, (255, 255, 255), 1)

plt.figure(figsize=(15, 7))

plt.subplot(231)
plt.title('Thresholded Image')
plt.imshow(thresh_img, cmap='gray')
plt.axis('off')

plt.subplot(232)
plt.title('Image with Contours')
plt.imshow(cv2.cvtColor(img_contours, cv2.COLOR_BGR2RGB))
plt.axis('off')

plt.subplot(233)
plt.title('Image with Bounding Rectangle and Contour')
img_contours_rect = img.copy()
for contour in contours:
    x, y, w, h = cv2.boundingRect(contour)
    rect = cv2.minAreaRect(contour)
    box = cv2.boxPoints(rect)
    box = np.intp(box)
    cv2.rectangle(img_contours_rect, (x, y), (x + w, y + h), (255, 255, 255), 3)
    cv2.drawContours(img_contours_rect, [box], -1, (255, 100, 155), 3)
    cv2.drawContours(img_contours_rect, [contour], -1, (255, 255, 255), 2)

plt.imshow(cv2.cvtColor(img_contours_rect, cv2.COLOR_BGR2RGB))
plt.axis('off')

# Выделение контуров с наибольшей длиной и площадью
max_length_contour = max(contours, key=lambda x: cv2.arcLength(x, True))
max_area_contour = max(contours, key=cv2.contourArea)

plt.subplot(234)
plt.title('Max Length Contour')
img_max_length_contour = np.zeros_like(img)
cv2.drawContours(img_max_length_contour, [max_length_contour], -1, (255, 255, 255), 2)
plt.imshow(cv2.cvtColor(img_max_length_contour, cv2.COLOR_BGR2RGB))
plt.axis('off')

plt.subplot(235)
plt.title('Max Area Contour')
img_max_area_contour = np.zeros_like(img)
cv2.drawContours(img_max_area_contour, [max_area_contour], -1, (255, 255, 255), 2)
plt.imshow(cv2.cvtColor(img_max_area_contour, cv2.COLOR_BGR2RGB))
plt.axis('off')


print('Objects amount (filtered):', len(contours))


plt.tight_layout()
plt.show()

# 3
# Загрузка изображения с прямолинейными объектами
img = cv2.imread('Comps.jpg')
gray_img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
edges = cv2.Canny(gray_img, 50, 150, apertureSize=3)

# Копия изображения для отрисовки линий
gray_img_lines = cv2.cvtColor(img.copy(), cv2.COLOR_BGR2RGB)

# Обнаружение линий с помощью преобразования Хафа
lines = cv2.HoughLinesP(edges, 1, np.pi/180, 100, minLineLength=70, maxLineGap=250) #image, lines, rho, theta, threshold, minLineLength, maxLineGap
if lines is not None:
    for line in lines:
        x1, y1, x2, y2 = line[0]
        cv2.line(gray_img_lines, (x1, y1), (x2, y2), (255, 0, 0), 3)

# Отображение ребер и обнаруженных линий на одной странице
plt.figure(figsize=(12, 6))

plt.subplot(121)
plt.imshow(edges, cmap='gray')
plt.title('Edges')
plt.axis('off')

plt.subplot(122)
plt.imshow(gray_img_lines)
plt.title('Detected Lines')
plt.axis('off')

plt.tight_layout()
plt.show()


img = cv2.imread('Coffee.jpg')
img = cv2.medianBlur(img, 5)
gray_img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

circles = cv2.HoughCircles(gray_img, cv2.HOUGH_GRADIENT, 1, 35, #image, circles, method, dp, minDist, param1, param2, minRadius, maxRadius
                            param1=250, param2=45, minRadius=30, maxRadius=300)#обратное ^ отношение разрешения аккумулятора к разрешению изображения.

if circles is not None:
    circles = np.uint16(np.around(circles))
    for i in circles[0,:]:
        cv2.circle(img, (i[0], i[1]), i[2], (0, 255, 0), 2)
        cv2.circle(img, (i[0], i[1]), 2, (0, 0, 255), 3)

     # Отображение изображения с окружностями
    cv2.imshow('Circles Image', img)
    cv2.waitKey(0)