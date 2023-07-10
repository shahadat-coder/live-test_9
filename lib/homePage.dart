import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'API.dart';

class RecipeListPage extends StatefulWidget {
  @override
  _RecipeListPageState createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  List<Recipe> recipes = [];

  Future<void> fetchRecipes() async {
    final response = await http.get(Uri.parse('YOUR_JSON_URL'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final recipeList = jsonData['recipes'] as List<dynamic>;
      setState(() {
        recipes = recipeList
            .map((recipeJson) => Recipe.fromJson(recipeJson))
            .toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe List'),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (BuildContext context, int index) {
          final recipe = recipes[index];
          return ListTile(
            title: Text(recipe.title),
            subtitle: Text(recipe.description),
            onTap: () {
              // Handle recipe item tap
            },
          );
        },
      ),
    );
  }
}