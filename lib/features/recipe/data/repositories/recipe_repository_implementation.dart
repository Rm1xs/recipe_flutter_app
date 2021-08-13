import 'dart:convert';

import 'package:recipe_flutter_app/core/data/datasources/recipe_remote_datasource.dart';
import 'package:recipe_flutter_app/core/data/models/hit_model.dart';
import 'package:recipe_flutter_app/core/data/models/recipe_class_model.dart';
import 'package:recipe_flutter_app/core/data/models/recipe_model.dart';
import 'package:recipe_flutter_app/core/error/exeptions.dart';
import 'package:recipe_flutter_app/features/recipe/domain/repositories/recipe_repository.dart';
import 'package:http/http.dart' as http;

class RecipeRepositoryImplementation implements RecipeRepository {
  RecipeRepositoryImplementation(this.recipeRemoteDataSource);

  final RecipeRemoteDataSource recipeRemoteDataSource;


  @override
  Future<RecipeModel> getRecipe(String recipe) async {

    final String data = recipeRemoteDataSource.getRecipe(recipe);
    return await _getFromUrl(data);
  }

  @override
  Future<void> addRecipe(RecipeModel recipe) async {
    return await recipeRemoteDataSource.addRecipe(recipe);
  }

  @override
  Future<List<RecipeClassModel>> getRecipesDb() async {
    return await recipeRemoteDataSource.getRecipesDb();
  }

  Future<RecipeModel> _getFromUrl(String query) async {
    final http.Client client = http.Client();
    final http.Response response = await client.get(
      Uri.parse(query),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final RecipeModel data = RecipeModel.fromJson(json.decode(response.body));

      data.hits.sort((HitModel a, HitModel b) =>
          a.recipe.calories.compareTo(b.recipe.calories));
      return data;
    } else {
      throw ServerException();
    }
  }
}
