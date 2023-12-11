import 'package:hive/hive.dart';
import 'hive.dart';


class FoodAdapter extends TypeAdapter<Food> {
  @override
  final typeId = 0;

  @override
  Food read(BinaryReader reader) {
    final name = reader.read();
    final country = reader.read();
    return Food(name: name, country: country);
  }

  @override
  void write(BinaryWriter writer, Food obj) {
    writer.write(obj.name);
    writer.write(obj.country);
  }
}