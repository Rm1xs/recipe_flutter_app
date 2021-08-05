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
    required this.dietLabels,
  });

  String label;
  String image;
  List<String> ingredientLines;
  double calories;

  List<String> dietLabels;

  factory RecipeClass.fromJson(Map<String, dynamic> json) => RecipeClass(
        label: json["label"],
        image: json["image"],
        ingredientLines:
            List<String>.from(json["ingredientLines"].map((x) => x)),
        calories: json["calories"].toDouble(),
        dietLabels: List<String>.from(json["dietLabels"].map((x) => x)),
      );


  Map<String, dynamic> toJson() => {
    "label": label,
    "image": image,
    "dietLabels": List<dynamic>.from(dietLabels.map((x) => x)),
    "ingredientLines": List<dynamic>.from(ingredientLines.map((x) => x)),
    "calories": calories,

  };
}
