import 'package:recipe_flutter_app/domain/entities/enums.dart';

class Digest {
  Digest({
    required this.label,
    required this.tag,
    required this.schemaOrgTag,
    required this.total,
    required this.hasRdi,
    required this.daily,
    required this.unit,
    required this.sub,
  });

  String label;
  String tag;
  SchemaOrgTag? schemaOrgTag;
  double total;
  bool hasRdi;
  double daily;
  Unit? unit;
  List<Digest>? sub;



  factory Digest.fromJson(Map<String, dynamic> json) => Digest(
    label: json["label"],
    tag: json["tag"],
    schemaOrgTag: json["schemaOrgTag"] == null ? null : schemaOrgTagValues.map[json["schemaOrgTag"]],
    total: json["total"].toDouble(),
    hasRdi: json["hasRDI"],
    daily: json["daily"].toDouble(),
    unit: unitValues.map[json["unit"]],
    sub: json["sub"] == null ? null : List<Digest>.from(json["sub"].map((x) => Digest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "tag": tag,
    "schemaOrgTag": schemaOrgTag == null ? null : schemaOrgTagValues.reverse![schemaOrgTag],
    "total": total,
    "hasRDI": hasRdi,
    "daily": daily,
    "unit": unitValues.reverse![unit],
    "sub": sub == null ? null : List<dynamic>.from(sub!.map((x) => x.toJson())),
  };
}