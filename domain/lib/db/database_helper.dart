
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  late Database _db;

  static const String _databaseName = 'shop_database';
  static const _databaseVersion = 1;

  final currentDate = DateFormat('yyyy-MM-dd')
      .format(DateTime.now());

  static const String categoriesTable = 'categories';
  static const category = (
    id: 'categoryId',
    title: 'title',
    url: 'url',
    hasSubcategories: 'hasSubcategories',
    fullName: 'fullName',
    categoryDescription: 'categoryDescription',
    date: 'date'
  );

  static const String productsTable = 'products';
  static const product = (
    categoryId: 'categoryId',
    id: 'id',
    title: 'title',
    description: 'description',
    price: 'price',
    image: 'image',
    images: 'images',
    rating: 'rating',
    isAvailableForSale: 'isAvailableForSale',
    date: 'date'
  );

  Future<void> initDatabase() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: _onCreate,
      version: _databaseVersion
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    db.execute('''
      CREATE TABLE $categoriesTable (
        ${category.id} INTEGER PRIMARY KEY,
        ${category.title} TEXT,
        ${category.url} TEXT,
        ${category.hasSubcategories} INTEGER,
        ${category.fullName} TEXT,
        ${category.categoryDescription} TEXT,
        ${category.date} TEXT
      )
    ''');

    db.execute('''
      CREATE TABLE  $productsTable (
        ${product.id} INTEGER PRIMARY KEY,
        ${product.categoryId} INTEGER,
        ${product.title} TEXT,
        ${product.description} TEXT,
        ${product.price} INTEGER,
        ${product.image} TEXT,
        ${product.images} TEXT,
        ${product.rating} REAL,
        ${product.isAvailableForSale} INTEGER,
        ${product.date} TEXT
      )
    ''');
  }

  Future<int> insert(String table, Map<String, dynamic> row) async {
    return await _db.insert(
      table,
      row,
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<int> update(String table, Map<String, dynamic> row) async {
    final id = row['id'];
    return await _db.update(
      table,
      row,
      where: 'id = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<int> delete(String table, Map<String, dynamic> row) async {
    final id = row['id'];
    return await _db.delete(
        table,
        where: 'id = ?',
        whereArgs: [id]
    );
  }

  Future<List<Map<String, Object?>>> getItemsFromTable({
    required String table,
    String? where,
    List<Object?>? whereArgs
  }) async {
    return await _db.query(
      table,
      where: where,
      whereArgs: whereArgs
    );
  }

  Future<Map<String, Object?>> getItemFromTableById({
    required String table,
    required int id
  }) async {
    final item = await _db.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1
    );
    return item.first;
  }
}
