import '../data/database_helper.dart';

class OrderDao {
  final dbHelper = DatabaseHelper.instance;

  static Future<List<Map<String, dynamic>>> getAllOrders() async {
    return await DatabaseHelper.queryAll('orders');
  }

  static Future<int> insertOrder(Map<String, dynamic> order) async {
    return await DatabaseHelper.insert(DatabaseHelper.tableOrder, order);
  }

  static Future<int> updateOrder(Map<String, dynamic> order) async {
    return await DatabaseHelper.update('orders', order);
  }

  static Future<int> deleteOrder(int orderId) async {
    return await DatabaseHelper.delete('orders', 'id = ?', [orderId]);
  }
  static Future<int?> getLastOrderId() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.rawQuery('SELECT MAX(id) as last_id FROM orders');
    final lastId = result.first['last_id'];
    return lastId != null ? lastId as int : null;
  }
}