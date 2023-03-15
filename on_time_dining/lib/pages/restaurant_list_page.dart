import 'package:flutter/material.dart';
import '../dao/restaurant_dao.dart';
import '../data/database_helper.dart';
import '../models/Restaurent.dart';
import 'menu_page.dart';
import 'order_history_page.dart';

class RestaurantListPage extends StatefulWidget {
  @override
  _RestaurantListPageState createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  final databaseHelper = DatabaseHelper.instance;
  final RestaurantDao restaurantDao = RestaurantDao();
 /* final List<Restaurant> restaurants = [
  Restaurant(name: 'Restaurant 1', adresse: 'This is the first restaurant',id: 1 ,image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ef/Restaurant_N%C3%A4sinneula.jpg/1200px-Restaurant_N%C3%A4sinneula.jpg'),
    Restaurant(name: 'Restaurant 2', adresse: 'This is the second restaurant',id:2,image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ef/Restaurant_N%C3%A4sinneula.jpg/1200px-Restaurant_N%C3%A4sinneula.jpg'),
    Restaurant(name: 'Restaurant 3', adresse: 'This is the third restaurant',id:3,image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ef/Restaurant_N%C3%A4sinneula.jpg/1200px-Restaurant_N%C3%A4sinneula.jpg'),
  ];*/

  @override
  void initState() {
    super.initState();
    //_addRestaurantsToDatabase();
  }

  /*void _addRestaurantsToDatabase() async {
   for (Restaurant restaurant in restaurants) {
      Map<String, dynamic> restaurantMap = {
        'name': restaurant.name,
       'address': restaurant.adresse,
      'image': restaurant.image,
      };
      await restaurantDao.insertRestaurant(restaurantMap);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant List'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: restaurantDao.getAllRestaurants(),
        builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            List<Map<String, dynamic>> restaurantMaps = snapshot.data!;
            List<Restaurant> restaurants = restaurantMaps.map((map) => Restaurant.fromMap(map)).toList();
            return ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    title: Text(
                      restaurants[index].name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          restaurants[index].adresse,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 10),
                        Image.network(
                          '${restaurants[index].image}',
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MenuPage(restaurants[index].name)),
                      );
                    },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OrderHistoryPage()),
          );
        },
        tooltip: 'History',
        child: Icon(Icons.history),
      ),
    );
  }

}
