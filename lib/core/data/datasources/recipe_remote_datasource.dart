import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_flutter_app/core/data/models/hit_model.dart';
import 'package:recipe_flutter_app/core/data/models/recipe_class_model.dart';
import 'package:recipe_flutter_app/core/data/models/recipe_model.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_flutter_app/core/error/exeptions.dart';

abstract class RecipeRemoteDataSource {
  Future<RecipeModel> getRecipe(String recipe);

  Future<void> addRecipe(RecipeModel recipe);

  Future<List<RecipeClassModel>> getRecipesDb();
}

class RecipeRemoteDataSourceImplementation implements RecipeRemoteDataSource {
  RecipeRemoteDataSourceImplementation();

  @override
  Future<RecipeModel> getRecipe(String recipe) {
    return _getFromUrl(
        'https://api.edamam.com/search?q=$recipe&app_id=f54d1c43&app_key=ea6e29f77ce572331ff618bee02f7ab8');
  }

  @override
  Future<void> addRecipe(RecipeModel recipeClass) async {
    final User tokenResult = FirebaseAuth.instance.currentUser!;
    final String idToken = tokenResult.uid;

    final CollectionReference recipe =
        FirebaseFirestore.instance.collection('Recipes-${idToken.toString()}');

    await deleteRecipe(recipe);

    recipeClass.hits.forEach((HitModel element) {
      recipe.add(element.recipe.toJson());
    });
  }

  @override
  Future<List<RecipeClassModel>> getRecipesDb() async {
    final User tokenResult = FirebaseAuth.instance.currentUser!;
    final String idToken = tokenResult.uid;

    final QuerySnapshot<Map<String, dynamic>> db = await FirebaseFirestore
        .instance
        .collection('Recipes-${idToken.toString()}')
        .get();

    final List<QueryDocumentSnapshot<Map<String, dynamic>>> result = db.docs;

    final List temp = <dynamic>[];

    result.forEach((QueryDocumentSnapshot<Map<String, dynamic>> element) {
      temp.add(element.data());
    });

    final List<RecipeClassModel> data =
        temp.map((dynamic e) => RecipeClassModel.fromJson(e)).toList();

    return data;
  }

  Future<void> deleteRecipe(CollectionReference ref) async {
    final User tokenResult = FirebaseAuth.instance.currentUser!;
    final String idToken = tokenResult.uid;

    final CollectionReference<Map<String, dynamic>> collection =
        FirebaseFirestore.instance.collection('Recipes-${idToken.toString()}');
    final QuerySnapshot<Map<String, dynamic>> snapshots =
        await collection.get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshots.docs) {
      await doc.reference.delete();
    }
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
