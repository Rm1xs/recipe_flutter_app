import 'package:recipe_flutter_app/domain/entities/enums.dart';

class Total {
  Total({
    required this.label,
    required this.quantity,
    required this.unit,
  });

  String label;
  double quantity;
  Unit? unit;


  factory Total.fromJson(Map<String, dynamic> json) => Total(
    label: json["label"],
    quantity: json["quantity"].toDouble(),
    unit: unitValues.map[json["unit"]],
  );

}