import '../data/database_helper.dart';

class RestaurantDao {
  final dbHelper = DatabaseHelper.instance;

  Future<List<Map<String, dynamic>>> getAllRestaurants() async {
    return await DatabaseHelper.queryAll('Restaurant');
  }

  Future<int> insertRestaurant(Map<String, dynamic> restaurant) async {
    return await DatabaseHelper.insert('Restaurant', restaurant);
  }

  Future<int> updateRestaurant(Map<String, dynamic> restaurant) async {
    return await DatabaseHelper.update('Restaurant', restaurant);
  }

  Future<int> deleteRestaurant(int restaurantId) async {
    return await DatabaseHelper.delete('Restaurant', 'id = ?', [restaurantId]);
  }
}