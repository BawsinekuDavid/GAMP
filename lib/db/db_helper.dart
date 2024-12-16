import 'package:gmarket_app/pages/Products/product_page.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  factory DbHelper() => _instance;
  DbHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'products.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE products (
    id INTEGER PRIMARY KEY,
    name TEXT,
    image TEXT,
    rating REAL,
    category TEXT
    )
''');
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
      where: 'category = ?',
      whereArgs: [category],
    );
    return List.generate(maps.length, (i) => Product.fromMap(maps[i]));
  }
}

Future<void> populateDatabase() async {
  final dbHelper = DbHelper();

  final products = [
    Product(
        id: 1,
        name: 'Mango',
        image: 'lib/images/mangos.jpg',
        rating: 4.5,
        category: 'Fruits'),
    Product(
        id: 2,
        name: 'Apple',
        image: 'lib/images/apples.jpg',
        rating: 4.7,
        category: 'Fruits'),
    Product(
        id: 3,
        name: 'Tomato',
        image: 'lib/images/tomato.png',
        rating: 4.2,
        category: 'Vegetables'),
    Product(
        id: 4,
        name: 'Carrot',
        image: 'lib/images/carrots.jpg',
        rating: 4.4,
        category: 'Vegetables'),
    Product(
        id: 5,
        name: 'Chicken',
        image: 'lib/images/chicken.jpg',
        rating: 4.8,
        category: 'Meat & Fish'),
    Product(
        id: 6,
        name: 'Fish',
        image: 'lib/images/fish.jpg',
        rating: 4.6,
        category: 'Meat & Fish'),
    Product(
        id: 7,
        image: 'lib/images/clapping.png',
        name: 'clapping',
        category: "Fruits",
        rating: 2.1)
  ];

  for (var product in products) {
    await dbHelper.insertProduct(product);
  }
}
