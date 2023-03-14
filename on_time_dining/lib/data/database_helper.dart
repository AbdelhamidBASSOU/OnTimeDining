import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = 'saidGlovoDB.db';
  static final _databaseVersion = 1;

  static final tableUser = 'user';
  static final columnUserId = 'id';
  static final columnUserEmail = 'email';
  static final columnUserPhone = 'phone';
  static final columnUserName = 'username';

  static final tableRestaurant = 'restaurant';
  static final columnRestaurantId = 'id';
  static final columnRestaurantName = 'name';
  static final columnRestaurantAddress = 'address';
  static final columnRestaurantImage = 'image';

  static final tableOrder = 'orders';
  static final columnOrderId = 'id';
  static final columnOrderDate = 'date';
  static final columnOrderTotalPrice = 'totalPrice';
 // static final columnOrderUserId = 'user_id';
  //static final columnOrderRestaurantId = 'restaurant_id';

  static final tableOrderItem = 'order_item';
  static final columnOrderItemId = 'id';
  static final columnOrderItemQuantity = 'quantity';
  static final columnOrderItemPrice = 'price';
  static final columnOrderItemOrderId = 'order_id';
  static final columnOrderItemPlatId = 'plat_id';

  static final tablePlat = 'plat';
  static final columnPlatId = 'id';
  static final columnPlatName = 'name';
  static final columnPlatDescription = 'description';
  static final columnPlatPrice = 'price';
  static final columnPlatImage = 'image';
  static final columnPlatRestaurantId = 'restaurant_id';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableUser (
        $columnUserId INTEGER PRIMARY KEY,
        $columnUserEmail TEXT NOT NULL,
        $columnUserPhone INTEGER NOT NULL,
        $columnUserName TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableRestaurant (
  $columnRestaurantId INTEGER PRIMARY KEY,
  $columnRestaurantName TEXT NOT NULL,
  $columnRestaurantAddress TEXT NOT NULL,
  $columnRestaurantImage TEXT NOT NULL
     )
   ''');

    await db.execute('''
      CREATE TABLE $tableOrder (
        $columnOrderId INTEGER PRIMARY KEY,
        $columnOrderDate TEXT NOT NULL,
        $columnOrderTotalPrice REAL NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableOrderItem (
        $columnOrderItemId INTEGER PRIMARY KEY,
        $columnOrderItemQuantity INTEGER NOT NULL,
        $columnOrderItemPrice REAL NOT NULL,
        $columnOrderItemOrderId INTEGER NOT NULL,
        $columnOrderItemPlatId INTEGER NOT NULL,
        FOREIGN KEY ($columnOrderItemOrderId) REFERENCES $tableOrder ($columnOrderId),
        FOREIGN KEY ($columnOrderItemPlatId) REFERENCES $tablePlat ($columnPlatId)
      )
    ''');

    await db.execute('''
      CREATE TABLE $tablePlat (
        $columnPlatId INTEGER PRIMARY KEY,
        $columnPlatName TEXT NOT NULL,
        $columnPlatDescription TEXT NOT NULL,
        $columnPlatPrice REAL NOT NULL,
        $columnPlatImage TEXT NOT NULL,
        $columnPlatRestaurantId INTEGER NOT NULL,
        FOREIGN KEY ($columnPlatRestaurantId) REFERENCES $tableRestaurant ($columnRestaurantId)
      )
    ''');
  }
  static Future<int> insert(String table, Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert(table, row);
  }

  static Future<int> update(String table, Map<String, dynamic> row) async {
    final db = await instance.database;
    final id = row['id'];
    return await db.update(table, row, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> delete(String table, String whereClause, List<dynamic> whereArgs) async {
    final db = await instance.database;
    return await db.delete(table, where: whereClause, whereArgs: whereArgs);
  }

  static Future<List<Map<String, dynamic>>> queryAll(String table) async {
    final db = await instance.database;
    return await db.query(table);
  }

 static Future<List<Map<String, dynamic>>> query(String table, String whereClause, List<dynamic> whereArgs) async {
    final db = await instance.database;
    return await db.query(table, where: whereClause, whereArgs: whereArgs);
  }
}

