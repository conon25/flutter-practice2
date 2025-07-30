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