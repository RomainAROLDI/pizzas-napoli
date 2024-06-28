class Ingredient {
  final int id;
  final String name;
  final String category;
  final String image;

  Ingredient({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'image': image,
    };
  }
}
