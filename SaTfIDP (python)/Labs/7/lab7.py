import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, precision_score, recall_score
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
import joblib

#Классификация текстов и анализ тональности

data = pd.read_csv('IMDB Dataset.csv', nrows=400)
data.info()
print("-----")
print(data.head())

# Преобразование текста в числовой формат (TF-IDF векторизация)
vectorizer = TfidfVectorizer(max_features=5000) 
X = vectorizer.fit_transform(data['review'])

# Если 'sentiment' - 'positive', то 1, если 'sentiment' - 'negative', то 0
data['sentiment'] = data['sentiment'].map({'positive': 1, 'negative': 0})

y = data['sentiment']

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

print("svm")
from sklearn.svm import SVC

svm_model = SVC(kernel='linear', C=0.7, max_iter=75, tol=1e-4)
#C=0.6, max_iter=20, tol=1e-4
#0.5 15
#7 39
#7 75
svm_model.fit(X_train, y_train)

# Предсказание на тестовой выборке
y_pred = svm_model.predict(X_test)

svm_accuracy = accuracy_score(y_test, y_pred)
svm_precision = precision_score(y_test, y_pred)
svm_recall = recall_score(y_test, y_pred)

print(f'Accuracy SVM: {svm_accuracy}')
print(f'Precision SVM: {svm_precision}')
print(f'Recall SVM: {svm_recall}')


print("forest")
from sklearn.ensemble import RandomForestClassifier

# Создание модели случайного леса
rf_model = RandomForestClassifier(n_estimators=50, random_state=10)
#50 20/10
rf_model.fit(X_train, y_train)

y_pred = rf_model.predict(X_test)

rf_accuracy = accuracy_score(y_test, y_pred)
rf_precision = precision_score(y_test, y_pred)
rf_recall = recall_score(y_test, y_pred)

print(f'Accuracy Random Forest: {rf_accuracy}')
print(f'Precision Random Forest: {rf_precision}')
print(f'Recall Random Forest: {rf_recall}')


print("Logistic Regression")

log_reg_model = LogisticRegression(C=0.9, penalty='l2', solver='liblinear', max_iter=7)  
log_reg_model.fit(X_train, y_train)

y_pred = log_reg_model.predict(X_test)

lr_accuracy = accuracy_score(y_test, y_pred)
lr_precision = precision_score(y_test, y_pred, zero_division=1)
lr_recall = recall_score(y_test, y_pred)

print(f'Accuracy Logistic Regression: {lr_accuracy}')
print(f'Precision Logistic Regression: {lr_precision}')
print(f'Recall Logistic Regression: {lr_recall}')


import matplotlib.pyplot as plt

# Создание списков с метриками для каждой модели
accuracy_scores = [svm_accuracy, rf_accuracy, lr_accuracy]
precision_scores = [svm_precision, rf_precision, lr_precision]
recall_scores = [svm_recall, rf_recall, lr_recall]

models = ['SVM', 'Random Forest', 'Logistic Regression']

# Создание графика
plt.figure(figsize=(10, 6))

plt.bar(models, accuracy_scores, color='blue', alpha=0.7, label='Accuracy')
plt.bar(models, precision_scores, color='orange', alpha=0.7, label='Precision')
plt.bar(models, recall_scores, color='green', alpha=0.7, label='Recall')

plt.xlabel('Models')
plt.ylabel('Scores')
plt.title('Comparison of Models')

plt.legend()
plt.tight_layout()

plt.show()

# Сохранение модели в файл
joblib.dump(svm_model, 'log_reg_model.pkl')


#5
import requests
from bs4 import BeautifulSoup

url = 'https://www.kino-teatr.ru/kino/movie/hollywood/19867/annot/'

response = requests.get(url)

if response.status_code == 200:
    html_content = response.text
    
    # Инициализация парсера BeautifulSoup
    soup = BeautifulSoup(html_content, 'html.parser')
    data = []

    count = 0
    titles = soup.find_all('div', class_='comment_text')
    for title in titles: 
        print("new comment -----", title.text)
        data.append(title.text.strip())
    
else:
    print('Ошибка при получении страницы:', response.status_code)
 


#6
from joblib import load 
from googletrans import Translator

translator = Translator()
translated_data = [translator.translate(text, dest='en').text for text in data]
print(translated_data)

#----
import re
import nltk
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
from nltk.stem import WordNetLemmatizer


nltk.download('stopwords')
nltk.download('punkt')
nltk.download('wordnet')

lemmatizer = WordNetLemmatizer()

def clean_text(text):
   
    text = re.sub(r'http\S+|www\S+|<\S+>', '', text, flags=re.MULTILINE)
    tokens = word_tokenize(text)
    words = [word.lower() for word in tokens if word.isalpha()]
    stop_words = set(stopwords.words('english'))
    words = [word for word in words if word not in stop_words]
    words = [lemmatizer.lemmatize(word) for word in words]
    return ' '.join(words)
cleaned_data = [clean_text(text) for text in translated_data]



#--------------------------------------------------------------------
# svc_model = load('best_model.pkl')
# svc_model = load('rf_model.pkl')
svc_model = load('log_reg_model.pkl')

X = vectorizer.transform(translated_data)

y_pred = svc_model.predict(X)

for i in range(len(translated_data)):
    if y_pred[i] == 0:
        print("Отзыв ", i ," - негативный".format(translated_data[i]))
    if y_pred[i] == 1:
        print("Отзыв ",i," - позитивный".format(translated_data[i]))


#негативный
#негативный
#позитивный
#позитивный
#негативный