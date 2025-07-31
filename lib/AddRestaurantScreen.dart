import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'restaurant.dart';
import 'AddressSearchWebView.dart'; // 상단에 import 추가
import 'package:cloud_firestore/cloud_firestore.dart';


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


class AddRestaurantScreen extends StatefulWidget {
  @override
  _AddRestaurantScreenState createState() => _AddRestaurantScreenState();
}

class _AddRestaurantScreenState extends State<AddRestaurantScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String? selectedCategory;
  String? selectedSubCategory;
  String address = '';
  double rating = 0.0;
  final TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('음식점 등록')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: '식당명'),
                onSaved: (val) => name = val ?? '',
                validator: (val) => val!.isEmpty ? '식당명을 입력하세요' : null,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: '대분류'),
                value: selectedCategory,
                items: categories.keys
                    .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedCategory = val;
                    selectedSubCategory = null;
                  });
                },
                validator: (val) => val == null ? '대분류를 선택하세요' : null,
              ),
              if (selectedCategory != null)
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: '소분류'),
                  value: selectedSubCategory,
                  items: categories[selectedCategory]!
                      .map((sub) => DropdownMenuItem(value: sub, child: Text(sub)))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedSubCategory = val;
                    });
                  },
                  validator: (val) => val == null ? '소분류를 선택하세요' : null,
                ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(labelText: '주소'),
                      readOnly: true,
                      validator: (val) => val!.isEmpty ? '주소를 입력하세요' : null,
                      onSaved: (val) => address = val ?? '',
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AddressSearchWebView(),
                        ),
                      );

                      if (result != null && result is String && result.isNotEmpty) {
                        setState(() {
                          addressController.text = result;
                        });
                      }
                    },
                    child: Text('주소찾기'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text('평점', style: TextStyle(fontSize: 16)),
              RatingBar.builder(
                initialRating: 0,
                minRating: 0.5,
                allowHalfRating: true,
                itemSize: 36,
                direction: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
                onRatingUpdate: (value) {
                  setState(() {
                    rating = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('등록'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final newRestaurant = Restaurant(
                      name: name,
                      category: selectedCategory ?? '',
                      subCategory: selectedSubCategory ?? '',
                      address: addressController.text,
                      rating: rating,
                    );

                    // Firestore 저장
                    await FirebaseFirestore.instance.collection('restaurants').add({
                      'name': newRestaurant.name,
                      'category': newRestaurant.category,
                      'subCategory': newRestaurant.subCategory,
                      'address': newRestaurant.address,
                      'rating': newRestaurant.rating,
                    });

                    // 메인으로 돌아가면서 식당 정보와 등록 성공 플래그 함께 전달
                    Navigator.pop(context, {
                      'restaurant': newRestaurant,
                      'success': true,
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}