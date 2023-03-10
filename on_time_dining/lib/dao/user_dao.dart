import '../data/database_helper.dart';

class UserDao {
  final dbHelper = DatabaseHelper.instance;

  // Query all users from the database
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    return await DatabaseHelper.queryAll('User');
  }

  // Insert a new user into the database
  Future<int> insertUser(Map<String, dynamic> user) async {
    return await DatabaseHelper.insert('User', user);
  }

  // Update an existing user in the database
  Future<int> updateUser(Map<String, dynamic> user) async {
    return await DatabaseHelper.update('User', user);
  }

  // Delete a user from the database
  Future<int> deleteUser(int userId) async {
    return await DatabaseHelper.delete('User', 'id = ?', [userId]);
  }
}
