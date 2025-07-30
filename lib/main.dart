import 'package:flutter/material.dart';
import 'AddRestaurantScreen.dart';
import 'restaurant.dart';

// 더미 데이터
final List<Restaurant> dummyRestaurants = [
  Restaurant(
    name: '김밥천국',
    category: '한식',
    subCategory: '분식',
    address: '서울시 강남구',
    rating: 4.2,
  ),
  Restaurant(
    name: '고기굽는집',
    category: '한식',
    subCategory: '고기집',
    address: '서울시 종로구',
    rating: 4.8,
  ),
  Restaurant(
    name: '파스타하우스',
    category: '양식',
    subCategory: '파스타',
    address: '서울시 마포구',
    rating: 3.9,
  ),
];

void main() {
  runApp(RestaurantReviewApp());
}

class RestaurantReviewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '음식점 리뷰',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Restaurant> restaurantList = List.from(dummyRestaurants);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('음식점 리뷰')),
      body: ListView.builder(
        itemCount: restaurantList.length,
        itemBuilder: (context, index) {
          final restaurant = restaurantList[index];
          return ListTile(
            title: Text(restaurant.name),
            subtitle: Text('${restaurant.category} > ${restaurant.subCategory}\n${restaurant.address}'),
            trailing: Text('⭐️ ${restaurant.rating}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final newRestaurant = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddRestaurantScreen()),
          );
          if (newRestaurant != null) {
            setState(() {
              restaurantList.add(newRestaurant);
            });
          }
        },
      ),
    );
  }
}