import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/constants/my_text.dart';
import 'package:food_recipe/models/recipe_model.dart';
import 'package:food_recipe/controllers/home_controller.dart';

class FoodDetails extends StatefulWidget {
  final Recipe recipe;

  const FoodDetails({super.key, required this.recipe});

  @override
  _FoodDetailsState createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  final RecipeController recipeController = Get.put(RecipeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(widget.recipe.label),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recipe Image
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(widget.recipe.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Ingredients List
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Ingredients:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.blueAccent,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.recipe.ingredients.length,
              itemBuilder: (context, index) {
                final ingredient = widget.recipe.ingredients[index];
                return ListTile(
                  leading: ingredient.image != null && ingredient.image!.isNotEmpty
                      ? Image.network(ingredient.image!)
                      : null,
                  title: MyText(
                    "${ingredient.text}",
                    fontSize: 16,
                  ),
                  subtitle: MyText("${ingredient.quantity} ${ingredient.unit}"),
                );
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {

              },
              child: MyText('Save Recipe for later'),
            ),
          ),
        ],
      ),
    );
  }
}
