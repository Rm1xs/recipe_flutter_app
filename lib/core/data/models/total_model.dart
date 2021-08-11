import 'package:recipe_flutter_app/core/data/models/enum_model.dart';

class TotalModel {
  TotalModel({
    required this.label,
    required this.quantity,
    required this.unit,
  });

  String label;
  double quantity;
  Unit? unit;


  factory TotalModel.fromJson(Map<String, dynamic> json) => TotalModel(
    label: json["label"],
    quantity: json["quantity"].toDouble(),
    unit: unitValues.map[json["unit"]],
  );

}