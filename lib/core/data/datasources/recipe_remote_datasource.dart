import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recipe_flutter_app/core/data/models/hit_model.dart';
import 'package:recipe_flutter_app/core/data/models/recipe_class_,model.dart';
import 'package:recipe_flutter_app/core/data/models/recipe_model.dart';
import 'package:recipe_flutter_app/core/error/exeptions.dart';
import 'package:http/http.dart' as http;


abstract class RecipeRemoteDataSource {
  Future<RecipeModel> getRecipe(String recipe);

  Future<void> addRecipe(RecipeModel recipe);

  Future<List<RecipeClassModel>> getRecipesDb();

}

class RecipeRemoteDataSourceImplementation implements RecipeRemoteDataSource {
  final http.Client client;

  RecipeRemoteDataSourceImplementation(this.client);

  @override
  Future<RecipeModel> getRecipe(String recipe) {
    return _getFromUrl(
        'https://api.edamam.com/search?q=$recipe&app_id=f54d1c43&app_key=ea6e29f77ce572331ff618bee02f7ab8');
  }

  Future<RecipeModel> _getFromUrl(String query) async {
    final http.Response response = await client.get(
      Uri.parse(query),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final RecipeModel data = RecipeModel.fromJson(json.decode(response.body));

      data.hits.sort((a, b) => a.recipe.calories.compareTo(b.recipe.calories));
      return data;
    } else {
      throw ServerException();
    }
  }

  @override
  Future addRecipe(RecipeModel recipeClass) async {
    final User tokenResult = FirebaseAuth.instance.currentUser!;
    final String idToken = tokenResult.uid;

    await Firebase.initializeApp();

    final CollectionReference recipe =
        FirebaseFirestore.instance.collection('Recipes-${idToken.toString()}');

    await deleteRecipe(recipe);

    recipeClass.hits.forEach((HitModel element) {
      recipe.add(element.recipe.toJson());
    });
  }

  Future deleteRecipe(CollectionReference ref) async{
    final User tokenResult = FirebaseAuth.instance.currentUser!;
    final String idToken = tokenResult.uid;

    final CollectionReference<Map<String, dynamic>> collection = FirebaseFirestore.instance.collection('Recipes-${idToken.toString()}');
    final QuerySnapshot<Map<String, dynamic>> snapshots = await collection.get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }

  @override
  Future<List<RecipeClassModel>> getRecipesDb() async {
    final User tokenResult = FirebaseAuth.instance.currentUser!;
    final String idToken = tokenResult.uid;

    await Firebase.initializeApp();
    final QuerySnapshot<Map<String, dynamic>> db = await FirebaseFirestore.instance.collection('Recipes-${idToken.toString()}').get();

    final List<QueryDocumentSnapshot<Map<String, dynamic>>> result = db.docs;
    final List temp = [];

    result.forEach((QueryDocumentSnapshot<Map<String, dynamic>> element) {
      temp.add(element.data());
    });

    var data = temp.map((e) => RecipeClassModel.fromJson(e)).toList();


    return data;
  }
}
