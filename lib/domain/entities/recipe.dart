import 'package:recipe_flutter_app/domain/entities/enums.dart';
import 'package:recipe_flutter_app/domain/entities/hit.dart';

class Recipe {
  Recipe({
    required this.hits,
  });


  List<Hit> hits;


  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    hits: List<Hit>.from(json["hits"].map((x) => Hit.fromJson(x))),
  );


}




