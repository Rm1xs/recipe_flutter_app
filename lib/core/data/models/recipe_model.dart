import 'package:recipe_flutter_app/core/data/models/hit_model.dart';

class RecipeModel {
  RecipeModel({
    required this.hits,
  });

  List<HitModel> hits;

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
    hits: List<HitModel>.from(json['hits'].map((dynamic x) => HitModel.fromJson(x))),
  );
}
