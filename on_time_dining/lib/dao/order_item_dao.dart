import '../data/database_helper.dart';

class OrderItemDao {
  final dbHelper = DatabaseHelper.instance;

  Future<List<Map<String, dynamic>>> getAllOrderItems() async {
    return await DatabaseHelper.queryAll('OrderItem');
  }

  Future<int> insertOrderItem(Map<String, dynamic> orderItem) async {
    return await DatabaseHelper.insert('OrderItem', orderItem);
  }

  Future<int> updateOrderItem(Map<String, dynamic> orderItem) async {
    return await DatabaseHelper.update('OrderItem', orderItem);
  }

  Future<int> deleteOrderItem(int orderItemId) async {
    return await DatabaseHelper.delete('OrderItem', 'id = ?', [orderItemId]);
  }
}
