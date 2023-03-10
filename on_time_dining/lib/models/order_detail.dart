class OrderDetail {
  final int id;
  final int quantity;
  final double price;

  OrderDetail({required this.id, required this.quantity, required this.price});

  factory OrderDetail.fromMap(Map<String, dynamic> map) {
    return OrderDetail(
      id: map['id'],
      quantity: map['quantity'],
      price: map['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quantity': quantity,
      'price': price,
    };
  }
}