class Restaurant {
  final int id;
  final String name;
  final String adresse;
  final String image;

  Restaurant({required this.id, required this.name, required this.adresse, required this.image});


  factory Restaurant.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return Restaurant(name: '', adresse: '', id: -1, image: '');
    }
    return Restaurant(
      name: map['name'] ?? '',
      adresse: map['address'] ?? '',
      id: map['id'] ?? -1,
      image:map['image'] ?? '',
    );
  }

}