import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../constants/my_text.dart';
import '../models/recipe_model.dart';

class SavedRecipesPage extends StatelessWidget {
  Future<List<String>> _getSavedRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('saved_recipes') ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText("Saved Recipes"),
      ),
      body: FutureBuilder<List<String>>(
        future: _getSavedRecipes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          // Convert each JSON string to a Recipe object, filtering out any nulls or invalid JSON
          final recipes = snapshot.data!
              .map((recipeString) {
            try {
              return Recipe.fromJson(jsonDecode(recipeString));
            } catch (e) {
              return null; // Filter out any null or improperly formatted recipes
            }
          })
              .whereType<Recipe>() // Remove any null values
              .toList();

          if (recipes.isEmpty) {
            return Center(child: MyText("No saved recipes found"));
          }

          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return ListTile(
                title: MyText(recipe.label),
                subtitle: MyText(recipe.ingredients.map((i) => i.text).join(", ")),
              );
            },
          );
        },
      ),
    );
  }
}
