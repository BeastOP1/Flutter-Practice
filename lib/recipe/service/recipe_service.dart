// lib/services/recipe_service.dart

import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/recipe.dart';

class RecipeService {
  // StreamController banayein
  final StreamController<List<Recipe>> _recipesController =
  StreamController<List<Recipe>>.broadcast();

  // Getter for stream
  Stream<List<Recipe>> get recipesStream => _recipesController.stream;

  // All recipes store karne ke liye
  List<Recipe> _allRecipes = [];

  // JSON file load karein
  Future<void> loadRecipes() async {
    try {
      // Simulate network loading (optional)
      await Future.delayed(Duration(seconds: 1));

      // assets se JSON file read karein
      String jsonString = await rootBundle.loadString('json/recipe.json');

      // JSON parse karein
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      // Recipes list mein convert karein
      _allRecipes = (jsonMap['recipes'] as List)
          .map((recipeJson) => Recipe.fromJson(recipeJson))
          .toList();

      // Stream mein data bhejein
      _recipesController.sink.add(_allRecipes);

    } catch (e) {
      // Error ko stream mein bhejein
      _recipesController.addError('Failed to load recipes: $e');
      print('Error loading recipes: $e');
    }
  }

  // Filter recipes by category
  void filterByCategory(String category) {
    if (category == 'All') {
      _recipesController.sink.add(_allRecipes);
    } else {
      final filtered = _allRecipes
          .where((recipe) => recipe.category == category)
          .toList();
      _recipesController.sink.add(filtered);
    }
  }

  // Search recipes by name
  void searchRecipes(String query) {
    if (query.isEmpty) {
      _recipesController.sink.add(_allRecipes);
    } else {
      final searched = _allRecipes
          .where((recipe) =>
          recipe.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      _recipesController.sink.add(searched);
    }
  }

  // Get single recipe by id
  Recipe? getRecipeById(int id) {
    try {
      return _allRecipes.firstWhere((recipe) => recipe.id == id);
    } catch (e) {
      return null;
    }
  }

  // Stream close karein
  void dispose() {
    _recipesController.close();
  }
}