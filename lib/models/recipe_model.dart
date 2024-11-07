import 'ingredients_model.dart';

class Recipe {
  final String label;
  final String image;
  final double calories;
  final List<Ingredient> ingredients;

  Recipe(
      {required this.label,
      required this.image,
      required this.calories,
      required this.ingredients});
  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'image': image,
      'calories': calories,
      'ingredients': ingredients.map((ingredient) => ingredient.toJson()).toList(),
    };
  }
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      label: json['recipe']['label'] ?? 'No name provided',
      image: json['recipe']['image'] ?? '',
      calories: json['recipe']['calories'] ?? 0.0,
      ingredients: (json['recipe']['ingredients'] as List)
          .map((item) => Ingredient.fromJson(item))
          .toList(),
    );
  }
}
