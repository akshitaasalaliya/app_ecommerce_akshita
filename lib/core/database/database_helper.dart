import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:app_ecommerce_akshita/features/product_list/productlist_model.dart';

class DatabaseHelper {

  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'ecommerce.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY,
            name TEXT,
            description TEXT,
            image TEXT,
            price REAL,
            stock INTEGER,
            category TEXT,
            rating REAL,
            quantity INTEGER,
            isFavorite INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertProducts(List<ProductModel> products) async {
    final db = await database;

    Batch batch = db.batch();

    for (var product in products) {
      final List<Map<String, dynamic>> maps = await db.query(
        'products',
        where: 'id = ?',
        whereArgs: [product.id],
      );
      if (maps.isNotEmpty) {
        bool isFav = maps.first['isFavorite'] == 1;
        product.isFavorite = isFav;
      }
      batch.insert(
        'products',
        product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<void> updateProduct(ProductModel product) async {
    final db = await database;
    await db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<List<ProductModel>> getProducts({int limit = 10, int offset = 0}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'products',
      limit: limit,
      offset: offset,
    );
    return List.generate(maps.length, (i) {
      return ProductModel.fromMap(maps[i]);
    });
  }

}
