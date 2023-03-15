import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/order_detail.dart';
import '../models/plat.dart';
import '../pages/order_detail_page.dart';

class CartPage extends StatefulWidget {
  final Plat plat;

  CartPage(this.plat);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int _quantity = 1;

  Future<void> _saveToCart() async {
    print(widget.plat);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartItems = prefs.getStringList('cartItems');
    if (cartItems == null) {
      cartItems = [];
    }
    String platJson =
        '{"id": "${widget.plat.id}","name": "${widget.plat.name}", "price": ${widget.plat.price}, "image": "${widget.plat.image}", "quantity": $_quantity}';
    cartItems.add(platJson);
    await prefs.setStringList('cartItems', cartItems);
    print('card to save' + cartItems.toString());
  }

  void _updateTotalPrice() {
    setState(() {});
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
      _updateTotalPrice();
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
        _updateTotalPrice();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.plat.price * _quantity;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add to Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(height: 10),
                Image.network(
                  widget.plat.image,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10),
                ListTile(
                  title: Text(
                    widget.plat.name,
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Text(
                    '\$${widget.plat.price}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: _decrementQuantity,
                  ),
                  title: Text(
                    'Quantity: $_quantity',
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _incrementQuantity,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Total Price:',
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Text(
                    '\$${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () async {
                await _saveToCart();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartListPage()),
                );
              },
              child: Text('Add to Order'),
            ),
          ),
        ],
      ),
    );
  }
}
