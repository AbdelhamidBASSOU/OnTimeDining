class Plat {
  final int id;
  final String name;
  final String description;
  final double price;

  Plat({required this.id, required this.name, required this.description, required this.price});

  factory Plat.fromMap(Map<String, dynamic> map) {
    return Plat(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
    };
  }
}