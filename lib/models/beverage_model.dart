class BeverageModel {
  final String name;
  final String imageUrl;
  final String volume; // [BARU] Untuk tulisan "350ml" di Product Card
  final String ingredients;
  final String nutritionFacts;
  final String healthGrade;
  final bool isPopular; // [BARU] Saklar untuk kategori "Minuman Populer"

  BeverageModel({
    required this.name,
    required this.imageUrl,
    required this.volume,
    required this.ingredients,
    required this.nutritionFacts,
    required this.healthGrade,
    this.isPopular = false, // Secara default tidak populer, kecuali diatur True di Firestore
  });

  factory BeverageModel.fromMap(Map<String, dynamic> map) {
    return BeverageModel(
      name: map['name'] as String? ?? '',
      imageUrl: map['image_url'] as String? ?? '',
      volume: map['volume'] as String? ?? '', // [BARU]
      ingredients: map['ingredients'] as String? ?? '',
      nutritionFacts: map['nutrition_facts'] as String? ?? '',
      healthGrade: map['health_grade'] as String? ?? '',
      isPopular: map['is_popular'] as bool? ?? false, // [BARU]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image_url': imageUrl,
      'volume': volume, // [BARU]
      'ingredients': ingredients,
      'nutrition_facts': nutritionFacts,
      'health_grade': healthGrade,
      'is_popular': isPopular, // [BARU]
    };
  }
}