import 'package:flutter/material.dart';
import 'package:on_time_dining/models/order.dart';
import 'package:on_time_dining/models/plat.dart';
import 'package:on_time_dining/pages/checkout_page.dart';
import 'package:on_time_dining/pages/order_history_page.dart';
import 'package:on_time_dining/pages/restaurant_list_page.dart';

import 'dao/order_dao.dart';
import 'dao/plat_dao.dart';
import 'data/database_helper.dart';


void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => MyAppState();
}
  class MyAppState extends State<MyApp> {

    PlatDao platDao = PlatDao();
    OrderDao orderDao = OrderDao();

    void insertPlat() async{
      /*Map<String, dynamic> platToinsert = {
        'id': 1,
      'name': "hhh",
      'description': "BBB",
      'price' : 45,
      'image' : "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/Eq_it-na_pizza-margherita_sep2005_sml.jpg/800px-Eq_it-na_pizza-margherita_sep2005_sml.jpg"
      };*/
      //await platDao.insertPlat(1,platToinsert);

      List<Map<String, dynamic>> orderAFF = await OrderDao.getAllOrders();
      print('All order : $orderAFF');

    }

    @override
    void initState() {
      super.initState();
      insertPlat();
    }

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Restaurant App',
        theme: ThemeData(
          primarySwatch: Colors.orange,
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




