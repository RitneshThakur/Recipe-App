import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_recipe/constants/app_constants.dart';
import 'package:food_recipe/models/recipe_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RecipeController extends GetxController {
  var recipes = <Recipe>[].obs;
  var isTextFieldVisible = false.obs;
  var category = "All".obs;
  TextEditingController searchController = TextEditingController();
  RxBool isLoading = false.obs;
  var categories = [
    "All",
    "Burgers",
    "Pizza",
    "Biryani",
    "Soup",
    "Chicken",
    "Mutton"
  ].obs;

  @override
  void onInit() {
    super.onInit();
    fetchApi('All');
    log('init works');
  }

  void clearSearch() {
    searchController.clear();
  }

  toggleSearchField() {
    isTextFieldVisible.value = !isTextFieldVisible.value;
  }

  ///fetch the api
  fetchApi(String query) async {
    isLoading.value = true;
    recipes.clear();
    update();
    String url = generateUrl(query);
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      List<Recipe> fetchedRecipe =
          (json['hits'] as List).map((item) => Recipe.fromJson(item)).toList();
      recipes.clear();
      recipes.value = fetchedRecipe;
      log('gets values');
      log(query.toString());
      update();
    } else {
      log("Failed to load recipes. Status code: ${response.statusCode}");
    }
  }

  updateCategory(String newCategory) {
    category.value = newCategory;
    fetchApi(newCategory.toLowerCase());
    log('upadtes value');
  }
}
