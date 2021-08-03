import 'package:recipe_flutter_app/domain/entities/recipe_class.dart';

class Hit {
  Hit({
    required this.recipe,
  });

  RecipeClass recipe;


  factory Hit.fromJson(Map<String, dynamic> json) => Hit(
    recipe: RecipeClass.fromJson(json["recipe"]),
  );

  Map<String, dynamic> toJson() => {
    "recipe": recipe.toJson(),
  };
}