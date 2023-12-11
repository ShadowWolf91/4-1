import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  List<Map<String, dynamic>> _foodList = [];

  @override
  void initState() {
    super.initState();
    _loadFood();
  }

  Future<void> _loadFood() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'food.db'),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE food (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            country TEXT
          )
        ''');
      },
      version: 1,
    );

    final db = await database;
    final food = await db.query('food');
    setState(() {
      _foodList = food;
    });
  }

  Future<void> _addFood() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'food.db'),
      version: 1,
    );

    final db = await database;
    final id = await db.insert('food', {
      'name': 'Ramen',
      'country': 'Japan',
    });
    print('Added food with id: $id');
    _loadFood();
  }

  Future<void> _updateFood() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'food.db'),
      version: 1,
    );

    final db = await database;
    const id = 4;
    final rowsUpdated = await db.update(
        'food',
        {
          'name': 'Draniki',
          'country': 'Belarus',
        },
        where: 'id = ?',
        whereArgs: [id]);
    print('Updated $rowsUpdated food(s)');
    _loadFood();
  }

  Future<void> _deleteFood() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'food.db'),
      version: 1,
    );

    final db = await database;
    const id = 2;
    final rowsDeleted =
        await db.delete('food', where: 'id = ?', whereArgs: [id]);
    print('Deleted $rowsDeleted food(s)');
    _loadFood();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food'),
      ),
      body: ListView.builder(
        itemCount: _foodList.length,
        itemBuilder: (context, index) {
          final food = _foodList[index];
          return ListTile(
            title: Text(food['name']),
            trailing: Text(food['country']),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _addFood,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8.0),
          FloatingActionButton(
            onPressed: _updateFood,
            child: const Icon(Icons.edit),
          ),
          const SizedBox(height: 8.0),
          FloatingActionButton(
            onPressed: _deleteFood,
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
