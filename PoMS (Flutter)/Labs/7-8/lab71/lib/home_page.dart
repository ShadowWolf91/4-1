import 'package:flutter/material.dart';
import 'package:lab71/file_system_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'hive.dart';
import 'food_adapter.dart';

Future<void> initHive() async {
  Hive.registerAdapter(FoodAdapter());
  await Hive.initFlutter();
  final hiveDB = HiveDB();
  await hiveDB.delAll();

  final food = Food(name: 'Pasta', country: 'Italy');
  final food2 = Food(name: 'Borscht', country: 'Ukraine');

  await hiveDB.addFood(food);
  await hiveDB.addFood(food2);

  print("----Read food data----");
  List<Food> foods = await hiveDB.getAllFood();
  for (int i = 0; i < foods.length; i++) {
    print('${foods[i].name}  ${foods[i].country} ');
  }

  print("----Update food data----");
  final updatedFood = Food(name: 'Pierogi', country: 'Poland');
  await hiveDB.updateFood(0, updatedFood);
  foods = await hiveDB.getAllFood();

  for (int i = 0; i < foods.length; i++) {
    print('${foods[i].name}  ${foods[i].country} ');
  }

  print("----Delete food data----");
  await hiveDB.deleteFood(0);
  foods = await hiveDB.getAllFood();
  for (int i = 0; i < foods.length; i++) {
    print('${foods[i].name}  ${foods[i].country} ');
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/food');
              },
              child: const Text('Food Page'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: const Text('Settings Page'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FileSystemPage()),
                );
              },
              child: const Text('System Page'),
            ),
            ElevatedButton(
                onPressed: () {
                  initHive();
                },
                child: const Text("ORM Hive"))
          ],
        ),
      ),
    );
  }
}
