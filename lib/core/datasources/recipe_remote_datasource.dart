import 'dart:convert';

import 'package:recipe_flutter_app/core/error/exeptions.dart';
import 'package:recipe_flutter_app/domain/entities/recipe.dart';
import 'package:http/http.dart' as http;

abstract class RecipeRemoteDataSource {
  Future<Recipe> getRecipe(String recipe);
}

class RecipeRemoteDataSourceImplementation implements RecipeRemoteDataSource {
  final http.Client client;

  RecipeRemoteDataSourceImplementation(this.client);

  @override
  Future<Recipe> getRecipe(String recipe) {
    return _getFromUrl(
        'https://api.edamam.com/search?q=$recipe&app_id=f54d1c43&app_key=ea6e29f77ce572331ff618bee02f7ab8');
  }

  Future<Recipe> _getFromUrl(String query) async {
    final http.Response response = await client.get(
      Uri.parse(query),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      Recipe data = Recipe.fromJson(json.decode(response.body));

      return data;
    } else {
      throw ServerException();
    }
  }
}
