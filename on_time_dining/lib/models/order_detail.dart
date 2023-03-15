class OrderDetail {
  final int? id;
  final int quantity;
  final double price;
  final int? orderId;
  final int? platId;

  OrderDetail({this.id, required this.quantity, required this.price, required this.orderId, required this.platId});

  factory OrderDetail.fromMap(Map<String, dynamic> map) {
    return OrderDetail(
      id: map['id'],
      quantity: map['quantity'],
      price: map['price'],
      orderId: map['orderId'],
      platId: map['platId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quantity': quantity,
      'price': price,
      'orderId': orderId,
      'platId': platId,
    };
  }
}