import 'package:recipe_flutter_app/core/data/models/recipe_class_model.dart';

class HitModel {
  HitModel({
    required this.recipe,
  });

  factory HitModel.fromJson(Map<String, dynamic> json) => HitModel(
        recipe: RecipeClassModel.fromJson(json['recipe']),
      );

  RecipeClassModel recipe;
}
