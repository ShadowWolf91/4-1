import cv2
from IPython.display import Image
import numpy as np
from matplotlib import pyplot as plt
from matplotlib import figure as figure

#Выделим характерные угловые точки на изображении при помощи детектора углов Харриса
img = cv2.imread('geom-figury.png')
img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

gray = np.float32(gray)

dst = cv2.cornerHarris(gray,20,3,0.04)

dst = cv2.dilate(dst, None) 

img[dst>0.01*dst.max()]=[0,0,0]

plt.imshow(img)
plt.show()

#Выделим характерные угловые точки на изображении при помощи детектора углов Ши Томаси
#кол-во углов, качество углов, мин расстояние, метод хариса
img = cv2.imread('geom-figury.png')
img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

corners = cv2.goodFeaturesToTrack(gray,100,0.001,10, useHarrisDetector=True)
corners = np.int0(corners)

for i in corners:
    x,y = i.ravel()
    cv2.circle(img,(x,y),5,255,-1)

plt.imshow(img)
plt.show()
#2

#Определим при помощи классификатора Хаара области лиц, глаз и улыбок
face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')
eye_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_eye.xml')
smile_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_smile.xml')

img = cv2.imread('people.jpg')
img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

faces = face_cascade.detectMultiScale(gray, 1.2, 3)
for (x,y,w,h) in faces:
    img = cv2.rectangle(img,(x,y),(x+w,y+h),(255,0,0),2)
    roi_gray = gray[y:y+h, x:x+w]
    roi_color = img[y:y+h, x:x+w]
    eyes = eye_cascade.detectMultiScale(roi_gray)
    for (ex,ey,ew,eh) in eyes:
        cv2.rectangle(roi_color,(ex,ey),(ex+ew,ey+eh),(0,255,0),2)
    

plt.imshow(img)
plt.show()

#3
#Выведем с камеры ноутбука видео и найдем лицо, глаза и улыбку на видео при помощи классификатора Хаара
# Загрузка предварительно обученных классификаторов Хаара для лиц, глаз и носа
face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')
eye_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_eye.xml')
nose_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_smile.xml')

# Запуск видеопотока с камеры ноутбука
cap = cv2.VideoCapture(0)

while True:
    ret, frame = cap.read()
    if not ret:
        break

    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    # Детектирование лиц на кадре
    faces = face_cascade.detectMultiScale(gray, scaleFactor=1.3, minNeighbors=5)

    for (x, y, w, h) in faces:
        cv2.rectangle(frame, (x, y), (x+w, y+h), (255, 0, 0), 3)
        roi_gray = gray[y:y+h, x:x+w]
        roi_color = frame[y:y+h, x:x+w]

        # Детектирование глаз внутри области лица
        eyes = eye_cascade.detectMultiScale(roi_gray)
        for (ex, ey, ew, eh) in eyes:
            cv2.rectangle(roi_color, (ex, ey), (ex+ew, ey+eh), (0, 255, 0), 2)

        # Детектирование носа внутри области лица
        noses = nose_cascade.detectMultiScale(roi_gray)
        for (nx, ny, nw, nh) in noses:
            cv2.rectangle(roi_color, (nx, ny), (nx+nw, ny+nh), (0, 0, 255), 2)

    # Вывод обработанного кадра с обозначенными лицами, глазами и носами
    cv2.imshow('Video', frame)

    # Нажмите 'q' для завершения работы
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Остановка видеопотока и закрытие окон
cap.release()
cv2.destroyAllWindows()