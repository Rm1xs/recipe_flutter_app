import 'package:recipe_flutter_app/core/data/models/enum_model.dart';

class Total {
  Total({
    required this.label,
    required this.quantity,
    required this.unit,
  });

  String label;
  double quantity;
  Unit? unit;
}