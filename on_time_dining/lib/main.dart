import 'package:flutter/material.dart';
import 'package:on_time_dining/pages/checkout_page.dart';
import 'package:on_time_dining/pages/order_history_page.dart';
import 'package:on_time_dining/pages/restaurant_list_page.dart';

import 'data/database_helper.dart';


void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => RestaurantListPage(),
        '/order_history': (context) => OrderHistoryPage(),
        '/checkout': (context) => CheckoutPage(),
      },
    );
  }
}
