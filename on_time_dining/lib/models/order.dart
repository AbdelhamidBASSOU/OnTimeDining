class Order {
  final int id;
  final DateTime date;
  final double totalPrice;

  Order({required this.id, required this.date, required this.totalPrice});

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      date: DateTime.parse(map['date']),
      totalPrice: map['totalPrice'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'totalPrice': totalPrice,
    };
  }
}