import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:on_time_dining/dao/order_dao.dart';
import 'package:on_time_dining/models/order_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dao/order_item_dao.dart';
import '../models/order.dart';

class CartListPage extends StatefulWidget {
  @override
  _CartListPageState createState() => _CartListPageState();
}

class _CartListPageState extends State<CartListPage> {
  List<Map<String, dynamic>> _cartItems = [];
  OrderItemDao orderItemDao = OrderItemDao();
  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }
  Future<void> _loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = prefs.getStringList('cartItems') ?? [];
    final items = List<Map<String, dynamic>>.from(itemsJson.map((item) => json.decode(item)));
    setState(() {
      this._cartItems = items;
    });
    print('card from storege' + _cartItems.toString());
  }
  double getTotalPrice() {
    double total = 0;
    for (var item in _cartItems) {
      total += item['price'] * item['quantity'];
    }
    return total;
  }

  Future<void> _addToOrder(List<Map<String, dynamic>> items) async {
    final prefs = await SharedPreferences.getInstance();
    final orderJson = prefs.getStringList('orders') ?? [];
    final order = orderJson.map((item) => Order.fromMap(jsonDecode(item))).toList();

    final totalPrice = getTotalPrice();
    final lastOrderId = await OrderDao.getLastOrderId();
    final newOrderId = lastOrderId != null ? lastOrderId + 1 : 1;

    final newOrder = Order(
      id: order.length + 1,
      date: DateTime.now(),
      totalPrice: totalPrice,
    );


    final orderId = await OrderDao.insertOrder(newOrder.toMap());
    order.add(newOrder);

    for (var item in items) {
      final orderItem = OrderDetail(
        id: item['id'],
        orderId: orderId,
        quantity: item['quantity'],
        price: item['price'],
      );
      await orderItemDao.insertOrderItem(orderItem.toMap());
    }
    await prefs.setStringList('orders', order.map((item) => jsonEncode(item.toMap())).toList());
    print('Added to order: $newOrder');
    // Remove cart items after successfully adding to order
    await prefs.remove('cartItems');

    setState(() {
      _cartItems = [];
    });
  }


  void _removeFromCart(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = prefs.getStringList('cartItems') ?? [];
    final items = List<Map<String, dynamic>>.from(
        itemsJson.map((item) => json.decode(item)));
    items.removeAt(index);
    prefs.setStringList(
        'cartItems', items.map((item) => json.encode(item)).toList());
    setState(() {
      _cartItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Items'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => _addToOrder(_cartItems),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _cartItems.length,
        itemBuilder: (BuildContext context, int index) {
          final item = _cartItems[index];
          print("final check item: $item");
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              title: Text(
                item['name'] ?? '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Image.network(
                    item['image'] ?? '',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item['quantity'] ?? 0} x \$${item['price'] ?? 0}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '\$${(item['quantity'] ?? 0) * (item['price'] ?? 0)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _removeFromCart(index),
              ),
            ),

          );
        },
      ),
    );
  }
}
