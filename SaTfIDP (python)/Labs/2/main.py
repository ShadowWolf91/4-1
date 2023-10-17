import pandas as pd
import numpy as np
import seaborn as sbr
import matplotlib.pyplot as plt

nintendo_dataset = pd.read_csv('NintendoGames.csv', encoding='latin-1')

before = nintendo_dataset.head()
print(before)

plt.figure(figsize=(12, 8))
nintendo_dataset.dropna().hist(bins=10, color='blue', alpha=0.5)
plt.suptitle("Распределение данных (до обработки пропусков)", fontsize=16, y=0.92)
plt.tight_layout()
plt.savefig('before.png')

plt.figure(figsize=(10, 6))
cols = nintendo_dataset.columns[:] 
# определяем цвета: красный - пропущенные данные
colours = ['#eeeeee', '#ff0000']
sbr.heatmap(nintendo_dataset[cols].isnull(), cmap=sbr.color_palette(colours))
plt.savefig('missData.png')

nintendo_dataset.info(memory_usage='deep')

isNull = nintendo_dataset.isnull().any()
print(isNull)

nintendo_dataset["user_score"]=nintendo_dataset["user_score"].fillna(nintendo_dataset["user_score"].mean())
nintendo_dataset["meta_score"]=nintendo_dataset["meta_score"].fillna(nintendo_dataset["meta_score"].mean())

plt.figure(figsize=(12, 8))
nintendo_dataset.dropna().hist(bins=10, color='green', alpha=0.5)
plt.suptitle("Распределение данных (после обработки пропусков)", fontsize=16, y=0.92)
plt.tight_layout()
plt.savefig('after.png')

nintendo_dataset["esrb_rating"]=nintendo_dataset["esrb_rating"].map({"E": 1, "T": 2, "E10+":3, "M":4, "RP":5})
nintendo_dataset["esrb_rating"]=nintendo_dataset["esrb_rating"].fillna(nintendo_dataset["esrb_rating"].mean())
nintendo_dataset["platform"]=nintendo_dataset["platform"].map({"3DS": 1, "Switch": 2, "DS":3, "WII":4, "WIIU":5,"GBA": 6, "GC": 7, "N64":8, "iOS":9, "TG16":10})
nintendo_dataset=nintendo_dataset.drop(["link", "date", "genres", "developers"],axis=1)
after = nintendo_dataset.head()
print(after)

# nintendo_dataset["developers"]=nintendo_dataset["developers"].map({"['Nintendo']": 1, "['Intelligent Systems']": 2, "['Game Freak']":3, "['HAL Labs']":4, "['Level 5']":5})
# nintendo_dataset["developers"] = nintendo_dataset["developers"].fillna(0)

nintendo_dataset.info(memory_usage='deep')

plt.figure(figsize=(12, 8))
nintendo_dataset['esrb_rating'].hist(bins=10, color='green', alpha=0.5)
plt.suptitle("Распределение данных без выбросов", fontsize=16, y=0.92)
plt.tight_layout()
plt.savefig('Before deleting blowout.png')

Q1 = nintendo_dataset['esrb_rating'].quantile(0.25)
Q3 = nintendo_dataset['esrb_rating'].quantile(0.75)
IQR = Q3 - Q1
lower_bound = Q1 - 1.5 * IQR
upper_bound = Q3 + 1.5 * IQR

# Удаление выбросов из данных
data_no_outliers = nintendo_dataset['esrb_rating'][(nintendo_dataset['esrb_rating'] >= lower_bound) & (nintendo_dataset['esrb_rating'] <= upper_bound)]

plt.figure(figsize=(12, 8))
data_no_outliers.hist(bins=10, color='blue', alpha=0.5)
plt.suptitle("Распределение данных без выбросов", fontsize=16, y=0.92)
plt.tight_layout()
plt.savefig('After deleting blowout.png')

print("Проверка балансировки по")
print(nintendo_dataset["esrb_rating"].value_counts())
print("Проверка балансировки по")
print(nintendo_dataset["platform"].value_counts())

nintendo_dataset2 = pd.read_csv('NintendoGames.csv', encoding='latin-1')

nintendo_dataset2["user_score"]=nintendo_dataset2["user_score"].fillna(nintendo_dataset2["user_score"].mean())
nintendo_dataset2["esrb_rating"]=nintendo_dataset2["esrb_rating"].map({"E": 1, "T": 2, "E10+":3, "M":4, "RP":5})
nintendo_dataset2["platform"]=nintendo_dataset2["platform"].map({"3DS": 1, "Switch": 2, "DS":3, "WII":4, "WIIU":5,"GBA": 6, "GC": 7, "N64":8, "iOS":9, "TG16":10})
nintendo_dataset2=nintendo_dataset2.drop(["link", "date", "genres", "developers"],axis=1)
nintendo_dataset2['title'] = range(1, len(nintendo_dataset2) + 1)

print(nintendo_dataset2.var())

numeric = nintendo_dataset2[['meta_score','user_score','title','esrb_rating']]
var = numeric.var()
numeric = numeric.columns

variable = [ ]

for i in range(0,len(var)):
    if var.iloc[i]>=0.7:   # setting the threshold as 10%
       variable.append(numeric[i])
       
data_less=nintendo_dataset2[variable]
print(data_less)

from sklearn.tree import DecisionTreeClassifier
from sklearn.model_selection import cross_val_score, train_test_split

y=nintendo_dataset2['platform']
X=nintendo_dataset2.drop("platform", axis=1)

X_train, X_valid, y_train, y_valid = train_test_split(   # 70% и 30%
    X, y, test_size=0.7, random_state=17)  
tree = DecisionTreeClassifier(random_state=17)
print(cross_val_score(tree, X_train, y_train, cv=3)) # оценка модели с помощью кросс-валидации
print(np.mean(cross_val_score(tree, X_train, y_train, cv=3))) #среднее по 3 оценкам

X1 = data_less

X_less_train, X_less_valid, y_train, y_valid = train_test_split(   #  70% и 30%
    X1, y, test_size=0.3, random_state=17)  
tree_less = DecisionTreeClassifier(random_state=17)
print(cross_val_score(tree, X_less_train, y_train, cv=3)) # оценка модели с помощью кросс-валидации
print(np.mean(cross_val_score(tree_less, X_less_train, y_train, cv=3))) #среднее по 3 оценкам

print(nintendo_dataset2.corr())

sbr.heatmap(nintendo_dataset2.corr(), annot=True, annot_kws={'size': 21})
plt.savefig('corr.png')