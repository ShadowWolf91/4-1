import cv2
import mediapipe as mp

mp_pose = mp.solutions.pose
mp_drawing = mp.solutions.drawing_utils

cap = cv2.VideoCapture(0)

with mp_pose.Pose(min_detection_confidence=0.5, min_tracking_confidence=0.5) as pose:
    prev_hip_y = None
    squat_count = 0

    while cap.isOpened():
        ret, frame = cap.read()
        if not ret:
            break

        image_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        results = pose.process(image_rgb)

        if results.pose_landmarks:
            hip_y = results.pose_landmarks.landmark[mp_pose.PoseLandmark.LEFT_HIP].y

            if prev_hip_y is not None:
                # Проверка изменения положения таза с большим изменением
                hip_change = abs(hip_y - prev_hip_y)
                if hip_change > 0.05:  # Здесь 0.05 - произвольный порог изменения
                    squat_count += 1
                    print(f"Squat count: {squat_count}")

            prev_hip_y = hip_y

            mp_drawing.draw_landmarks(frame, results.pose_landmarks, mp_pose.POSE_CONNECTIONS)

        cv2.imshow('MediaPipe Pose Detection', frame)

        if cv2.waitKey(10) & 0xFF == ord('q'):
            break

cap.release()
cv2.destroyAllWindows()
