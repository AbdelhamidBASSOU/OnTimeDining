import 'package:flutter/material.dart';
import 'cart_page.dart';

class MenuPage extends StatelessWidget {
  final String restaurantName;

  MenuPage(this.restaurantName);

  final List<String> menuList = ['Item 1', 'Item 2', 'Item 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurantName),
      ),
      body: ListView.builder(
        itemCount: menuList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(menuList[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage(menuList[index])),
              );
            },
          );
        },
      ),
    );
  }
}
