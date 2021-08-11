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
}
