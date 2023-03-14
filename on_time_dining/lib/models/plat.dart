class Plat {
  final int id;
  final String name;
  final String description;
  final double price;
  final String image;
  final int restaurantId;

  Plat({required this.id, required this.name, required this.description, required this.price,required this.image,required this.restaurantId});



  factory Plat.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return Plat(name: '', description: '', id: -1, price: 0.0,image: '',restaurantId: -1);
    }
    return Plat(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      id: map['id'] ?? -1,
      price:map['price'] ?? 0.0,
      image:map['image'] ?? '',
      restaurantId:map['restaurantId'] ?? -1,
    );
  }

  @override
  String toString() {
    return 'Plat{id: $id, name: $name, description: $description, price: $price, image: $image, restaurantId: $restaurantId}';
  }
}