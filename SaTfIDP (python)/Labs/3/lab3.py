import warnings
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

warnings.filterwarnings('ignore')

df = pd.read_csv('D:\\BSTU\\4\\4-1\\SaTfIDP (python)\\Labs\\3\\adult_salary.csv', header=None, sep=',\s')
col_names = ['age', 'workclass', 'fnlwgt', 'education', 'education_num', 'marital_status', 'occupation', 'relationship',
             'race', 'sex', 'capital_gain', 'capital_loss', 'hours_per_week', 'native_country', 'income']

df.columns = col_names
df.head()

###################
df.info()


categorical = [var for var in df.columns if df[var].dtype == 'O']

print('Количество категориальных переменных: {}\n'.format(len(categorical)))

print('Столбцы:\n\n', categorical)

################
#Данные содержат ? в качестве null значений


df.workclass.unique()

###
for col_name in col_names:
    df[col_name].replace('?', np.NaN, inplace=True)

# 
df.isnull().sum()
# 

for categorical_col in categorical:
    df[categorical_col].fillna(df[categorical_col].mode()[0], inplace=True)
# 
df.isnull().sum()

#Выделение столбцов параметров и результатов, замена категориальных значений OneHotEncoding, 
# разделение на обучающие и тестовые данные
#

from sklearn.model_selection import train_test_split

X = df.drop(['income'], axis=1)
y = df['income']

X = pd.get_dummies(X)
X_train, X_test, y_train, y_test = train_test_split(X, y, random_state=0)

# 
X.head()

# Нормализация данных
# 
from sklearn.preprocessing import RobustScaler

scaler = RobustScaler()

X_train = scaler.fit_transform(X_train)

X_test = scaler.transform(X_test)

X_train[0:5]

# Функции для уменьшения повторения кода. Выполняют обработку данных моделью и высчитывают статистические данные (Accuracy, Recall, Precision, AUC, AUC-ROC)
 
from sklearn.metrics import precision_score, recall_score
from sklearn.metrics import roc_curve
from sklearn.metrics import roc_auc_score, accuracy_score
from sklearn.ensemble import RandomForestClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.svm import SVC

def show_roc(model, X_test, y_test):
    y_pred1 = model.predict_proba(X_test)[:, 1]
    fpr, tpr, thresholds = roc_curve(y_test, y_pred1, pos_label='>50K')
    plt.figure(figsize=(6, 4))
    plt.plot(fpr, tpr, linewidth=2)
    plt.plot([0, 1], [0, 1], 'k--')
    plt.rcParams['font.size'] = 20
    plt.title('ROC')
    plt.xlabel('False Positive Rate')
    plt.ylabel('True Positive Rate')
    plt.show()
    ROC_AUC = roc_auc_score(y_test, y_pred1)
    print('ROC AUC : {:.4f}'.format(ROC_AUC))


def test_accuracy(model):
    model.fit(X_train, y_train)
    y_pred = model.predict(X_test)
    print('Точность на обучающем наборе: {0:0.4f}'.format(model.score(X_train, y_train)))
    print('Точность на тестовом наборе (Accuracy): {0:0.4f}'.format(model.score(X_test, y_test)))
    print('Precision: ', format(precision_score(y_test, y_pred, pos_label='>50K')))
    print('Recall: ', format(recall_score(y_test, y_pred, pos_label='>50K')))
    show_roc(model, X_test, y_test)
    return y_pred


# Различные модели с ROC-кривыми


# 
print('KNeighborsClassifier')
y_pred = test_accuracy(KNeighborsClassifier())

print('DecisionTreeClassifier')
y_pred = test_accuracy(DecisionTreeClassifier())

print('RandomForestClassifier')
y_pred = test_accuracy(RandomForestClassifier())

print('SVC')
svc = SVC()
svc.fit(X_train, y_train)
y_pred = svc.predict(X_test)
print('Точность на обучающем наборе: {0:0.4f}'.format(svc.score(X_train, y_train)))
print('Точность на тестовом наборе (Accuracy): {0:0.4f}'.format(svc.score(X_test, y_test)))
print('Precision: ', format(precision_score(y_test, y_pred, pos_label='>50K')))
print('Recall: ', format(recall_score(y_test, y_pred, pos_label='>50K')))

#**Bernoulli без RobustScaler**
#Точность на обучающем наборе: 0.7946
#Точность на тестовом наборе: 0.7562

#**RandomForestClassifier**
#Точность на обучающем наборе: 1.0000
#Точность на тестовом наборе: 0.8526
# 
y_value_counts = y_test.value_counts()
y_value_counts

# Null Accuracy - проверка точности с угадыванием самого частовстречаемого класса. Если точность ниже null accuracy, то выбранная модель бесполезна

# 
null_accuracy = (y_value_counts[0] / (y_value_counts[0] + y_value_counts[1]))
print('Проверка по самому частому классу: {0:0.4f}'.format(null_accuracy))

# GridSearch

# 
from sklearn.model_selection import GridSearchCV


def grid_search(model, param):
    clf = GridSearchCV(model, param, scoring='roc_auc', cv=10, return_train_score=True)
    clf.fit(X_train, y_train)
    print(clf.best_score_, "\n", clf.best_params_)


# 
grid_search(KNeighborsClassifier(), {'n_neighbors': np.arange(0, 30, 5)})

# 
grid_search(DecisionTreeClassifier(), {'max_depth': np.arange(1, 16, 5), 'max_features': np.arange(0, 30, 5)})

# 
grid_search(RandomForestClassifier(), {'max_depth': np.arange(1, 11, 5), 'max_features': ['auto', 'log2']})

#
# grid_search(SVC(), {'gamma': ['auto', 'scale'], 'C': np.arange(1, 0.2, 0.5)})

# Применение GridSearch


#
print('KNeighborsClassifier')
y_pred = test_accuracy(KNeighborsClassifier(n_neighbors=25))

print('DecisionTreeClassifier')
y_pred = test_accuracy(DecisionTreeClassifier(max_depth=10, max_features=25))

print('RandomForestClassifier')
y_pred = test_accuracy(RandomForestClassifier(max_depth=11, max_features=25))

print('SVC')
svc = SVC(gamma='scale', C=0.5)
svc.fit(X_train, y_train)
y_pred = svc.predict(X_test)
print('Точность на обучающем наборе: {0:0.4f}'.format(svc.score(X_train, y_train)))
print('Точность на тестовом наборе (Accuracy): {0:0.4f}'.format(svc.score(X_test, y_test)))
print('Precision: ', format(precision_score(y_test, y_pred, pos_label='>50K')))
print('Recall: ', format(recall_score(y_test, y_pred, pos_label='>50K')))