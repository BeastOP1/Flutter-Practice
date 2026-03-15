
class Recipe {
  final int id;
  final String name;
  final String category;
  final int calories;
  final String image;
  final List<Ingredient> ingredients;
  final List<String> instructions;
  final int prepTime;
  final int cookTime;
  final int servings;

  Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.calories,
    required this.image,
    required this.ingredients,
    required this.instructions,
    required this.prepTime,
    required this.cookTime,
    required this.servings,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      calories: json['calories'],
      image: json['image'],
      ingredients: (json['ingredients'] as List)
          .map((i) => Ingredient.fromJson(i))
          .toList(),
      instructions: List<String>.from(json['instructions']),
      prepTime: json['prepTime'] ?? 0,
      cookTime: json['cookTime'] ?? 0,
      servings: json['servings'] ?? 1,
    );
  }
}

class Ingredient {
  final String name;
  final int amount;
  final String unit;
  final String image;

  Ingredient({
    required this.name,
    required this.amount,
    required this.unit,
    required this.image,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'],
      amount: json['amount'],
      unit: json['unit'] ?? 'g',
      image: json['image'],
    );
  }
}