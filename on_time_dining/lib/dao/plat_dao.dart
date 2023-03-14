
import '../data/database_helper.dart';

class PlatDao {
  final dbHelper = DatabaseHelper.instance;

  Future<List<Map<String, dynamic>>> getAllPlats(String restaurantName) async {
    return await DatabaseHelper.queryAll('Plat');
  }

  Future<int> insertPlat(int restaurantId, Map<String, dynamic> plat) async {
    // Add the restaurant_id to the plat map before inserting
    plat['restaurant_id'] = restaurantId;
    return await DatabaseHelper.insert('Plat', plat);
  }


  Future<int> updatePlat(Map<String, dynamic> plat) async {
    return await DatabaseHelper.update('Plat', plat);
  }

  Future<int> deletePlat(int platId) async {
    return await DatabaseHelper.delete('Plat', 'id = ?', [platId]);
  }
}