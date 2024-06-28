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

class Pizza {
  final String id;
  final String name;
  final double price;
  final String base;
  final List<Ingredient> ingredients;
  final String imageId;
  final String category;

  Pizza({
    required this.id,
    required this.name,
    required this.price,
    required this.base,
    required this.ingredients,
    required this.imageId,
    required this.category,
  });

  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      base: json['base'] as String,
      ingredients: (json['elements'] as List)
          .map((element) => Ingredient.fromJson(element['ingredients_id']))
          .toList(),
      imageId: json['image'] as String,
      category: json['category'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'base': base,
      'ingredients':
          ingredients.map((ingredient) => ingredient.toJson()).toList(),
      'image': imageId,
      'category': category,
    };
  }
}
