class Pizza {
  final String id;
  final String name;
  final double price;
  final String base;
  final List<String> ingredients;
  final String imageId;
  final String category;
  final List<int> elements;

  Pizza({
    required this.id,
    required this.name,
    required this.price,
    required this.base,
    required this.ingredients,
    required this.imageId,
    required this.category,
    required this.elements,
  });

  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      base: json['base'] as String,
      ingredients: List<String>.from(json['ingredients']),
      imageId: json['image'] as String,
      category: json['category'] as String,
      elements: List<int>.from(json['elements']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'base': base,
      'ingredients': ingredients,
      'image': imageId,
      'category': category,
      'elements': elements,
    };
  }
}