class OrderDetail {
  final int id;
  final int quantity;
  final double price;
  final int orderId;

  OrderDetail({required this.id, required this.quantity, required this.price, required this.orderId});

  factory OrderDetail.fromMap(Map<String, dynamic> map) {
    return OrderDetail(
      id: map['id'],
      quantity: map['quantity'],
      price: map['price'],
      orderId: map['orderId'],
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