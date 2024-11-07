import 'package:get/get.dart';
import 'package:food_recipe/models/recipe_model.dart';

class RecipeController extends GetxController {
  final savedRecipes = <Recipe>[].obs;

  void saveRecipe(Recipe recipe) {
    if (!savedRecipes.contains(recipe)) {
      savedRecipes.add(recipe);
      Get.snackbar("Saved", "Recipe saved successfully!");
    } else {
      Get.snackbar("Already Saved", "This recipe is already in your saved list.");
    }
  }
}
