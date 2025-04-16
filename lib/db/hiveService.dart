import 'package:hive_flutter/hive_flutter.dart';

import '../pages/Products/product_adapter.dart';


class HiveService {

  static Future<void> initHive() async {
    await Hive.initFlutter();
    _registerAdapters();
  }

  static void _registerAdapters() {
    Hive.registerAdapter(ProductAdapter()); // Register Product adapter
  }

   
  static Future<Box<T>> openBox<T>(String boxName) async {
    
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<T>(boxName);
    }
    return Hive.box<T>(boxName);
  }

  static Future<void> closeBox(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      await Hive.box(boxName).close();
    }
  }

  static Future<void> clearBox(String boxName) async {
    final box = await openBox(boxName);
    await box.clear();
  }

 


}