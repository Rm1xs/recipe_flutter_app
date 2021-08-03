import 'package:recipe_flutter_app/domain/entities/digest.dart';
import 'package:recipe_flutter_app/domain/entities/enums.dart';
import 'package:recipe_flutter_app/domain/entities/ingredient.dart';
import 'package:recipe_flutter_app/domain/entities/total.dart';

class RecipeClass {
  RecipeClass({
    required this.label,
    required this.image,
    required this.ingredientLines,
    required this.calories,
  });

  String label;
  String image;
  List<String> ingredientLines;
  double calories;

  factory RecipeClass.fromJson(Map<String, dynamic> json) => RecipeClass(
        label: json["label"],
        image: json["image"],
        ingredientLines:
            List<String>.from(json["ingredientLines"].map((x) => x)),
        calories: json["calories"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "image": image,
        "ingredientLines": List<dynamic>.from(ingredientLines.map((x) => x)),
        "calories": calories,
      };
}
