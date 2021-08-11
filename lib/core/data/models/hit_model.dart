import 'package:recipe_flutter_app/core/data/models/recipe_class_,model.dart';

class HitModel {
  HitModel({
    required this.recipe,
  });

  RecipeClassModel recipe;


  factory HitModel.fromJson(Map<String, dynamic> json) => HitModel(
    recipe: RecipeClassModel.fromJson(json["recipe"]),
  );

}