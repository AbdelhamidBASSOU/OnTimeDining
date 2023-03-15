class Order {
    int?  id;
  final DateTime date;
  final double totalPrice;


  Order({ this.id, required this.date, required this.totalPrice});

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] != null ? map['id'] as int : null,
      date: map['date'] != null ? DateTime.parse(map['date'] as String) : DateTime.now(),
      totalPrice: (map['totalPrice'] as double?) ?? 0.0,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'id' : id ,
      'date': date.toIso8601String(),
      'totalPrice': totalPrice,
    };
  }

  @override
  String toString() {
    return 'Order{id: $id, date: $date, totalPrice: $totalPrice}';
  }
}