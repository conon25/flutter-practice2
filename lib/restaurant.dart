import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant {
  final String name;         // 식당명
  final String category;     // 대분류 (예: 한식, 중식 등)
  final String subCategory;  // 소분류 (예: 고기집, 분식 등)
  final String address;      // 주소
  final double rating;       // 평점

  Restaurant({
    required this.name,
    required this.category,
    required this.subCategory,
    required this.address,
    required this.rating,
  });
}

Future<List<Restaurant>> fetchRestaurants({String? category, String? subCategory, String? keyword}) async {
  Query query = FirebaseFirestore.instance.collection('restaurants');

  if (category != null) {
    query = query.where('category', isEqualTo: category);
  }

  if (subCategory != null) {
    query = query.where('subCategory', isEqualTo: subCategory);
  }

  if (keyword != null && keyword.isNotEmpty) {
    query = query.where('name', isGreaterThanOrEqualTo: keyword)
        .where('name', isLessThan: keyword + 'z');
  }

  final snapshot = await query.get();
  return snapshot.docs.map((doc) => Restaurant(
    name: doc['name'],
    category: doc['category'],
    subCategory: doc['subCategory'],
    address: doc['address'],
    rating: doc['rating'].toDouble(),
  )).toList();
}
