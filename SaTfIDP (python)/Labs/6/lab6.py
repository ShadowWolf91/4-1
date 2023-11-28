import spacy

nlp = spacy.load('en_core_web_sm')

text = "London is the capital and most populous city of England and the United Kingdom. Standing on the River Thames in the south east of the island of Great Britain, London has been a major settlement for two millennia. It was founded by the Romans, who named it Londinium."

doc = nlp(text)

# Вывод информации о первых токенах
for token in doc[:5]:  # Первые пять токенов
    print(
        f"Токен: {token.text}, Лемма: {token.lemma_}, Часть речи: {token.pos_}, Стоп-слово: {token.is_stop}"
    )


    from spacy import displacy

# Построение дерева зависимостей
# Визуализация дерева зависимостей
html_output = displacy.render(doc, style="dep", options={'compact': True, 'distance': 100})

# Сохранение дерева зависимостей в HTML-файл
output_path = "dependency_tree.html"
with open(output_path, "w", encoding="utf-8") as file:
    file.write(html_output)

#семантика, токенизация, часть речи, леммитизация, стоп-слово, парсинг зависимостей, группы сущ, именн сущ, кореференции
# Извлечение именованных сущностей и их типов
for entity in doc.ents:
    print(f"Сущность: {entity.text}, Тип: {entity.label_}")

print("Русский")    
nlp1 = spacy.load("ru_core_news_sm")

text1 = "Москва — столицы России, многонациональный город. Расположена на западе страны. Занимает площадь в 2 511 км²."

doc1 = nlp1(text1)

# Вывод информации о первых токенах
for token in doc1[:5]:  # Первые пять токенов
    print(
        f"Токен: {token.text}, Лемма: {token.lemma_}, Часть речи: {token.pos_}, Стоп-слово: {token.is_stop}"
    )

# Построение дерева зависимостей
# Визуализация дерева зависимостей
html_output1 = displacy.render(doc1, style="dep", options={'compact': True, 'distance': 100})

# Сохранение дерева зависимостей в HTML-файл
output_path1 = "dependency_tree_ru.html"
with open(output_path1, "w", encoding="utf-8") as file:
    file.write(html_output1)    

# Извлечение именованных сущностей и их типов
for entity in doc1.ents:
    print(f"Сущность: {entity.text}, Тип: {entity.label_}")