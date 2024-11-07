import 'package:flutter/material.dart';
import 'package:food_recipe/constants/my_text.dart';
import 'package:food_recipe/controllers/home_controller.dart';
import 'package:food_recipe/view/food_details_view.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _isTextFieldVisible = false;

  void _toggleTextFieldVisibility() {
    setState(() {
      _isTextFieldVisible = !_isTextFieldVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final RecipeController recipeController = Get.put(RecipeController());
    return Scaffold(
      appBar: AppBar(
        title: const MyText('Food App'),
        actions: [
          IconButton(
            icon: Icon(_isTextFieldVisible ? Icons.close : Icons.search),
            onPressed: _toggleTextFieldVisibility,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(_isTextFieldVisible ? 60 : 0),
          child: Visibility(
            visible: _isTextFieldVisible,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: recipeController.searchController,
                decoration: InputDecoration(
                  hintText: 'Search recipes...',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: recipeController.clearSearch,
                  ),
                ),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    recipeController.fetchApi(value.trim());
                    recipeController.clearSearch();
                  }
                },
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Icon(Icons.person, size: 30),
                ),
                title: MyText("Ritnesh Thakur"),
                subtitle: MyText("thakurritnesh@gmail.com"),
              ),
            ),
            ListTile(
              onTap: () {},
              title: const MyText("Saved Recipes"),
              trailing: const Icon(Icons.saved_search),
            ),
            ListTile(
              onTap: () {},
              title: const MyText("About "),
              trailing: const Icon(Icons.info),
            ),
            ListTile(
              onTap: () {},
              title: const MyText("Log Out"),
              trailing: const Icon(Icons.logout),
            )
          ],
        ),
      ),
      body: Obx(() {
        if (recipeController.recipes.isEmpty ) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: recipeController.categories.map((cat) {
                    return GestureDetector(
                      onTap: () => recipeController.updateCategory(cat),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          color: cat == recipeController.category.value
                              ? Colors.red
                              : Colors.blue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: MyText(
                            cat,
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
           recipeController.isLoading.value==true? Expanded(
              child: ListView.builder(
                itemCount: recipeController.recipes.length,
                itemBuilder: (context, index) {
                  final recipe = recipeController.recipes[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(12),
                      elevation: 8,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => FoodDetails(recipe: recipe));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2.5,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    recipe.image,
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) {
                                      return Container(
                                        height: 200,
                                        color: Colors.grey[200],
                                        child: const Center(
                                          child: Icon(
                                            Icons.broken_image,
                                            color: Colors.grey,
                                            size: 60,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 8),
                                MyText(
                                  recipe.label,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                MyText(
                                  "Calories: ${recipe.calories.toStringAsFixed(2)}",
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "Ingredients:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: recipe.ingredients.length,
                                    itemBuilder: (context, index) {
                                      final ingredient =
                                      recipe.ingredients[index];
                                      return MyText(
                                        "${ingredient.quantity} ${ingredient.text}",
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ):CircularProgressIndicator(),
          ],
        );
      }),
    );
  }
}
