import pandas as pd
import numpy as np
import seaborn as sbr
import matplotlib.pyplot as plt

pd.set_option('display.max_rows', None)
pd.set_option('display.max_columns', None)
pd.set_option('display.max_colwidth', None)

nintendo_dataset = pd.read_csv('NintendoGames.csv', encoding='latin-1')

games_platforms = nintendo_dataset["platform"].groupby(nintendo_dataset["platform"]).count()
print("Кол-во игр на разные платформы \n", games_platforms)

avg_amount = games_platforms.mean().__round__()
print("Кол-во игр в среднем на платформе: ", avg_amount)
print("Медиана числа игр: ", games_platforms.median().__round__())

import csv

# Открываем файл CSV
with open('NintendoGames.csv', 'r') as file:
    reader = csv.DictReader(file)

    # Читаем строки файла
    for row in reader:
        # Получаем значение столбца "genres"
        genres = row['genres']

        # Разделяем жанры по запятой и получаем первый жанр
        first_genre = genres.split(',')[0].strip()

        # Выводим первый жанр
        print(f"- {row['title']}")
        print(f"  - Platform: {row['platform']}")
        print(f"  - First Genre: " + first_genre + ']')

plt.figure(figsize=(10, 6))
sbr.histplot(data=nintendo_dataset["platform"])
plt.show()

sbr.boxplot(data=nintendo_dataset, x='user_score', showfliers=True)
plt.show()