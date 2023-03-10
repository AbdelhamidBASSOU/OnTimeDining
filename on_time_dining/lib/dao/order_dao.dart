import '../data/database_helper.dart';

class OrderDao {
  final dbHelper = DatabaseHelper.instance;

  static Future<List<Map<String, dynamic>>> getAllOrders() async {
    return await DatabaseHelper.queryAll('Order');
  }

  static Future<int> insertOrder(Map<String, dynamic> order) async {
    return await DatabaseHelper.insert('Order', order);
  }

  static Future<int> updateOrder(Map<String, dynamic> order) async {
    return await DatabaseHelper.update('Order', order);
  }

  static Future<int> deleteOrder(int orderId) async {
    return await DatabaseHelper.delete('Order', 'id = ?', [orderId]);
  }
  
}