import 'package:hive_flutter/hive_flutter.dart';

class HiveProvider {
  static Future<Box<Product>> getBox<Product>(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<Product>(boxName);
    } else {
      return await Hive.openBox<Product>(boxName);
    }
  }
}
