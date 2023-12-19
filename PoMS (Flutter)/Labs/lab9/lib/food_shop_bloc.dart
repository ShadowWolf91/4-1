import 'dart:async';
import 'package:flutter/material.dart';

enum FoodCategory { Breakfast, Dessert, Meat }
class FoodShopBloc {
  final _colorController = StreamController<Map<FoodCategory, Color>>();
  late Map<FoodCategory, Color> _containerColorMap;
  late Map<FoodCategory, Color> _iconColorMap;
  late Map<FoodCategory, Color> _textColorMap;

  Stream<Map<FoodCategory, Color>> get colorStream => _colorController.stream;

  FoodShopBloc() {
    _containerColorMap = {
      FoodCategory.Breakfast: Colors.grey.shade200,
      FoodCategory.Dessert: Colors.grey.shade200,
      FoodCategory.Meat: Colors.grey.shade200,
    };

    _iconColorMap = {
      FoodCategory.Breakfast: Colors.black,
      FoodCategory.Dessert: Colors.black,
      FoodCategory.Meat: Colors.black,
    };

    _textColorMap = {
      FoodCategory.Breakfast: Colors.black,
      FoodCategory.Dessert: Colors.black,
      FoodCategory.Meat: Colors.black,
    };
  }

  Color getContainerColor(FoodCategory category) {
    return _containerColorMap[category] ?? Colors.grey.shade200;
  }

  Color getTextColor(FoodCategory category) {
    return _textColorMap[category] ?? Colors.black;
  }

  Color getIconColor(FoodCategory category) {
    return _iconColorMap[category] ?? Colors.black;
  }
  void updateColor(FoodCategory category, Color color) {
    _containerColorMap[category] = color;
    _iconColorMap[category] = color == Colors.grey.shade200 ? Colors.black : Colors.white;
    _textColorMap[category] = color == Colors.grey.shade200 ? Colors.black : Colors.black;

    _colorController.sink.add(_containerColorMap); // Отправляем цвета контейнеров обратно в виджет
    _colorController.sink.add(_iconColorMap); // Отправляем цвета иконок обратно в виджет
    _colorController.sink.add(_textColorMap); // Отправляем цвета текста обратно в виджет
  }


  void dispose() {
    _colorController.close();
  }
}

