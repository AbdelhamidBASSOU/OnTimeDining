import 'package:flutter/material.dart';
import 'package:on_time_dining/dao/order_dao.dart';
import 'package:on_time_dining/models/order.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  List<Order> _orders = [];

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    final orders = await OrderDao.getAllOrders();
    setState(() {
      _orders = orders.map((order) => Order.fromMap(order)).toList();
    });
  }

  Future<void> _deleteOrder(Order order) async {
    await OrderDao.deleteOrder(order.id!);
    setState(() {
      _orders.remove(order);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          )
        ],
      ),
      body: _orders.isEmpty
          ? Center(child: Text('No orders found.'))
          : ListView.builder(
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          final order = _orders[index];
          return Dismissible(
            key: Key(order.id.toString()),
            onDismissed: (_) => _deleteOrder(order),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
            ),
            child: ListTile(
              title: Text('Order #${order.id}'),
              subtitle: Text('Total: \$${order.totalPrice.toStringAsFixed(2)}'),
            ),
          );
        },
      ),
    );
  }
}
