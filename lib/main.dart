import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'AddRestaurantScreen.dart';
import 'restaurant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(RestaurantReviewApp());
}

class RestaurantReviewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '음식점 리뷰',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Restaurant> restaurantList = [];
  String? selectedCategory;
  String? selectedSubCategory;
  String searchKeyword = '';

  final categories = {
    '한식': ['분식', '고기집', '국밥', '백반', '한정식', '찜/탕/찌개', '족발/보쌈', '해장국', '삼계탕', '비빔밥'],
    '중식': ['짜장면', '짬뽕', '탕수육', '마라탕', '중화요리', '딤섬'],
    '일식': ['스시', '라멘', '돈카츠', '우동', '덮밥', '이자카야'],
    '양식': ['파스타', '스테이크', '피자', '샐러드', '버거', '리조또'],
    '퓨전': ['한식퓨전', '아시안퓨전', '이탈리안퓨전', '멕시칸퓨전'],
    '아시아': ['쌀국수', '팟타이', '나시고렝', '월남쌈', '태국요리', '인도네시아 음식'],
    '남미/멕시칸': ['타코', '부리또', '퀘사디아'],
    '인도': ['커리', '난', '탄두리치킨'],
    '중동': ['케밥', '팔라펠', '후무스'],
    '아프리카': ['모로코 음식', '에티오피아 음식'],
    '디저트': ['카페', '베이커리', '빙수', '도넛', '마카롱', '크로플', '젤라또'],
    '패스트푸드': ['햄버거', '치킨', '감자튀김', '샌드위치', '핫도그'],
    '샐러드/비건': ['샐러드', '비건 푸드', '채식전문'],
    '분식': ['떡볶이', '김밥', '순대', '튀김', '라면'],
    '주점': ['포장마차', '호프집', '술집', '전통주점', '펍'],
    '기타': ['기타 음식점', '푸드트럭', '호텔레스토랑'],
  };


  @override
  void initState() {
    super.initState();
    fetchRestaurants();
  }

  Future<void> fetchRestaurants() async {
    final query = FirebaseFirestore.instance.collection('restaurants');

    Query filtered = query;
    if (selectedCategory != null) {
      filtered = filtered.where('category', isEqualTo: selectedCategory);
    }
    if (selectedSubCategory != null) {
      filtered = filtered.where('subCategory', isEqualTo: selectedSubCategory);
    }
    if (searchKeyword.isNotEmpty) {
      filtered = filtered.where('name', isGreaterThanOrEqualTo: searchKeyword)
          .where('name', isLessThanOrEqualTo: searchKeyword + '\uf8ff');
    }

    final snapshot = await filtered.get();

    setState(() {
      restaurantList = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        return Restaurant(
          name: data['name']?.toString() ?? '이름없음',
          category: data['category']?.toString() ?? '기타',
          subCategory: data['subCategory']?.toString() ?? '기타',
          address: data['address']?.toString() ?? '주소없음',
          rating: (data['rating'] is num)
              ? (data['rating'] as num).toDouble()
              : 0.0,
        );
      }).toList();
    });

  }

  void resetFilters() {
    selectedCategory = null;
    selectedSubCategory = null;
    searchKeyword = '';
    fetchRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('음식점 리뷰'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: resetFilters,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    hint: Text("대분류"),
                    value: selectedCategory,
                    isExpanded: true,
                    items: categories.keys.map((e) {
                      return DropdownMenuItem(value: e, child: Text(e));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                        selectedSubCategory = null;
                      });
                      fetchRestaurants();
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<String>(
                    hint: Text("소분류"),
                    value: selectedSubCategory,
                    isExpanded: true,
                    items: selectedCategory == null
                        ? []
                        : categories[selectedCategory]!
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSubCategory = value;
                      });
                      fetchRestaurants();
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: '검색어를 입력하세요',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: fetchRestaurants,
                ),
              ),
              onChanged: (value) {
                searchKeyword = value;
              },
              onSubmitted: (_) => fetchRestaurants(),
            ),
          ),
          Expanded(
            child: ListView.builder(
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddRestaurantScreen()),
            );

            if (result != null && result is Map && result['restaurant'] != null) {
              setState(() {
                restaurantList.add(result['restaurant']);
              });

              // ✅ 등록 완료 메시지
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('등록이 정상적으로 완료되었습니다')),
              );
            }
          }
      ),
    );
  }
}
