import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'restaurant.dart';
import 'AddressSearchWebView.dart'; // 상단에 import 추가

final categories = {
  '한식': ['분식', '고기집', '국밥'],
  '중식': ['짜장면', '짬뽕'],
  '일식': ['스시', '라멘'],
  '양식': ['파스타', '스테이크'],
  '기타': ['패스트푸드', '카페']
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.pop(
                        context,
                        Restaurant(
                          name: name,
                          category: selectedCategory ?? '',
                          subCategory: selectedSubCategory ?? '',
                          address: addressController.text,
                          rating: rating,
                        ));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}