import 'package:flutter/material.dart';
import '../dao/plat_dao.dart';
import '../data/database_helper.dart';
import '../models/plat.dart';
import 'cart_page.dart';

class MenuPage extends StatefulWidget {
  final String restaurantName;

  MenuPage(this.restaurantName);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final databaseHelper = DatabaseHelper.instance;
  final PlatDao platDao = PlatDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurantName),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: platDao.getAllPlats(widget.restaurantName),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            List<Map<String, dynamic>> platMaps = snapshot.data!;
            List<Plat> plats =
            platMaps.map((map) => Plat.fromMap(map)).toList();
            return ListView.builder(
              itemCount: plats.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    title: Text(
                      plats[index].name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          plats[index].description,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 10),
                        plats[index].image != null
                            ? Image.network(
                          '${plats[index].image}',
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                            : SizedBox.shrink(),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${plats[index].price}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CartPage(plats[index])),
                                );
                              },
                              child: Text('Add to cart'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }}