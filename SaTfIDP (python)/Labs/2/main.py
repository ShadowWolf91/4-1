import pandas as pd
import numpy as np
import seaborn as sbr
import matplotlib.pyplot as plt

nintendo_dataset = pd.read_csv('NintendoGames.csv', encoding='latin-1')

nintendo_dataset.head()
print(nintendo_dataset.head())

plt.figure(figsize=(10, 6))
cols = nintendo_dataset.columns[:] 
# определяем цвета 
# красный - пропущенные данные
colours = ['#eeeeee', '#ff0000']
sbr.heatmap(nintendo_dataset[cols].isnull(), cmap=sbr.color_palette(colours))
plt.savefig('before.png')

nintendo_dataset.info(memory_usage='deep')

isNull = nintendo_dataset.isnull().any()
print(isNull)

nintendo_dataset["user_score"]=nintendo_dataset["user_score"].fillna(nintendo_dataset["user_score"].mean())
nintendo_dataset["meta_score"]=nintendo_dataset["meta_score"].fillna(nintendo_dataset["meta_score"].mean())
nintendo_dataset["esrb_rating"]=nintendo_dataset["esrb_rating"].map({"E": 1, "T": 2, "E10+":3, "M":4, "RP":5})
nintendo_dataset["esrb_rating"]=nintendo_dataset["esrb_rating"].fillna(nintendo_dataset["esrb_rating"].mean())
nintendo_dataset["platform"]=nintendo_dataset["platform"].map({"3DS": 1, "Switch": 2, "DS":3, "WII":4, "WIIU":5,"GBA": 6, "GC": 7, "N64":8, "iOS":9, "TG16":10})
nintendo_dataset=nintendo_dataset.drop(["link", "date", "genres", "title"],axis=1)
print(nintendo_dataset.head())

plt.figure(figsize=(10, 6))
cols = nintendo_dataset.columns[:] 
colours = ['#eeeeee', '#ff0000']
sbr.heatmap(nintendo_dataset[cols].isnull(), cmap=sbr.color_palette(colours))
plt.savefig('after.png')

nintendo_dataset["developers"]=nintendo_dataset["developers"].map({"['Nintendo']": 1, "['Intelligent Systems']": 2, "['Game Freak']":3, "['HAL Labs']":4, "['Level 5']":5})
nintendo_dataset["developers"] = nintendo_dataset["developers"].fillna(0)

nintendo_dataset.info(memory_usage='deep')

Q1 = nintendo_dataset['user_score'].quantile(0.25)
Q3 = nintendo_dataset['user_score'].quantile(0.75)
IQR = Q3 - Q1
lower_bound = Q1 - 1.5 * IQR
upper_bound = Q3 + 1.5 * IQR

# Удаление выбросов из данных
data_no_outliers = nintendo_dataset[(nintendo_dataset['user_score'] >= lower_bound) & (nintendo_dataset['user_score'] <= upper_bound)]

print(data_no_outliers)
print("Проверка балансировки по")
print(nintendo_dataset["user_score"].value_counts())

# Вычисление дисперсии каждого числового столбца

print(nintendo_dataset.var())

# в этом приере столбец Outcome является столбцом меток Y, поэтому не будем учитывать его при формировании таблицы признаков
numeric = nintendo_dataset[['meta_score','user_score','esrb_rating','developers']]
var = numeric.var()
numeric = numeric.columns

variable = [ ]

for i in range(0,len(var)):
    if var.iloc[i]>=0.7:   # setting the threshold as 10%
       variable.append(numeric[i])
       
data_less=nintendo_dataset[variable]
print(data_less)

from sklearn.tree import DecisionTreeClassifier
from sklearn.model_selection import cross_val_score, train_test_split

y=nintendo_dataset['platform']
X=nintendo_dataset.drop("platform", axis=1)

X_train, X_valid, y_train, y_valid = train_test_split(   # 70% и 30%
    X, y, test_size=0.1, random_state=17)  

tree = DecisionTreeClassifier(random_state=17)
cross_val_score(tree, X_train, y_train, cv=10) # оценка модели с помощью кросс-валидации

np.mean(cross_val_score(tree, X_train, y_train, cv=10)) #среднее по пяти оценкам

X_less = data_less
X1=data_less.drop("platform", axis=1)

X_less_train, X_less_valid, y_train, y_valid = train_test_split(   #  70% и 30%
    X1, y, test_size=0.3, random_state=17)  
tree_less = DecisionTreeClassifier(random_state=17)
cross_val_score(tree, X_less_train, y_train, cv=10) # оценка модели с помощью кросс-валидации

np.mean(cross_val_score(tree_less, X_less_train, y_train, cv=10)) #среднее по пяти оценкам
