import 'package:gmarket_app/pages/Products/product_page.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  factory DbHelper() => _instance;
  DbHelper._internal();

  static const String _dbName = 'products.db';
  static const int _dbVersion = 2;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE products (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            image TEXT,
            name TEXT,
            category TEXT,
            rating REAL,
            price REAL,
            quantity INTEGER DEFAULT 0
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE products ADD COLUMN quantity INTEGER DEFAULT 0');
        }
      },
    );
  }


  Future<void> insertProduct(Product product) async {
    final db = await database;
    await db.insert('products', product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
Future<List<Product>> getProductsByCategory(String category) async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query(
    'products',
    where: 'LOWER(category) = ?',
    whereArgs: [category.toLowerCase()],
  );
  print('Found ${maps.length} products for category: $category');
  return List.generate(maps.length, (i) => Product.fromMap(maps[i]));
}


  
Future<List<Product>> getAllProducts() async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query('products');
  return List.generate(maps.length, (i) => Product.fromMap(maps[i]));
}
}


Future<void> populateDatabase() async {
  final dbHelper = DbHelper();

  final products = [
    Product(name: 'Mangos', image: 'lib/images/mangos.jpg', rating: 4.5, category: 'Fruits', price: 2.0),
    Product(name: 'Apple', image: 'lib/images/apples.jpg', rating: 4.7, category: 'Fruits', price: 8.0),
    Product(name: 'Banana', image: 'lib/images/banana.jpg', rating: 2.1, category: 'Fruits', price: 20.0),
    Product(name: 'Pawpaw', image: 'lib/images/pawpaw.jpg', rating: 2.1, category: 'Fruits', price: 15.0),
    Product(name: 'Citrus', image: 'lib/images/citrus.jpg', rating: 2.5, category: 'Fruits', price: 22.0),
    Product(name: 'Tomato', image: 'lib/images/tomato.png', rating: 4.2, category: 'Vegetables', price: 12.0),
    Product(name: 'Carrot', image: 'lib/images/carrots.jpg', rating: 4.4, category: 'Vegetables', price: 28.0),
    Product(name: 'Chicken', image: 'lib/images/chicken.jpg', rating: 4.8, category: 'Meat & Fish', price: 94.0),
    Product(name: 'Fish', image: 'lib/images/fish.jpg', rating: 4.6, category: 'Meat & Fish', price: 234.0),
  ];

  for (var product in products) {
    await dbHelper.insertProduct(product);
  }
}
