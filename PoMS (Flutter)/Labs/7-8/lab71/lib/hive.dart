import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Food {
  String? name;
  String? country;

  Food({this.name, this.country});
}

class HiveDB {
  static const String _foodBoxName = 'foodBox';

  Future<Box<Food>> _getFoodBox() async {
    final foodBox = await Hive.openBox<Food>(_foodBoxName);
    return foodBox;
  }

  Future<List<Food>> getAllFood() async {
    final foodBox = await _getFoodBox();
    final foods = foodBox.values.toList();
    return foods;
  }

  Future<void> addFood(Food food) async {
    final foodBox = await _getFoodBox();
    await foodBox.add(food);
  }

  Future<void> updateFood(int index, Food food) async {
    final foodBox = await _getFoodBox();
    await foodBox.putAt(index, food);
  }

  Future<void> delAll()async{
    final foodBox = await _getFoodBox();
    await foodBox.clear();
  }

  Future<void> deleteFood(int index) async {
    final foodBox = await _getFoodBox();
    await foodBox.deleteAt(index);
  }
}
