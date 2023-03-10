class User {
  final int id;
  final String email;
  final int phone;
  final String username;

  User({required this.id, required this.email, required this.phone, required this.username});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      phone: map['phone'],
      username: map['username'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'username': username,
    };
  }
}