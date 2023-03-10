import 'package:flutter/material.dart';
import 'checkout_page.dart';

class OrderHistoryPage extends StatelessWidget {
  final List<String> orders = [
    'Order 1',
    'Order 2',
    'Order 3',
    'Order 4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(orders[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CheckoutPage()),
              );
            },
          );
        },
      ),
    );
  }
}
