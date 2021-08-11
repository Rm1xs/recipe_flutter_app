class RecipeClassModel {
  RecipeClassModel({
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

  factory RecipeClassModel.fromJson(Map<String, dynamic> json) => RecipeClassModel(
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
