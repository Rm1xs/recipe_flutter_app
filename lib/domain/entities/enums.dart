enum Caution { SULFITES, FODMAP }

enum SchemaOrgTag {
  FAT_CONTENT,
  CARBOHYDRATE_CONTENT,
  PROTEIN_CONTENT,
  CHOLESTEROL_CONTENT,
  SODIUM_CONTENT,
  SATURATED_FAT_CONTENT,
  TRANS_FAT_CONTENT,
  FIBER_CONTENT,
  SUGAR_CONTENT
}

enum Unit { G, MG, UNIT_G, EMPTY, KCAL }

enum Q { SOUP, MAIN_COURSE }

enum MealType { LUNCH_DINNER }



class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}


final schemaOrgTagValues = EnumValues({
  "carbohydrateContent": SchemaOrgTag.CARBOHYDRATE_CONTENT,
  "cholesterolContent": SchemaOrgTag.CHOLESTEROL_CONTENT,
  "fatContent": SchemaOrgTag.FAT_CONTENT,
  "fiberContent": SchemaOrgTag.FIBER_CONTENT,
  "proteinContent": SchemaOrgTag.PROTEIN_CONTENT,
  "saturatedFatContent": SchemaOrgTag.SATURATED_FAT_CONTENT,
  "sodiumContent": SchemaOrgTag.SODIUM_CONTENT,
  "sugarContent": SchemaOrgTag.SUGAR_CONTENT,
  "transFatContent": SchemaOrgTag.TRANS_FAT_CONTENT
});


final unitValues = EnumValues({
  "%": Unit.EMPTY,
  "g": Unit.G,
  "kcal": Unit.KCAL,
  "mg": Unit.MG,
  "µg": Unit.UNIT_G
});

final qValues = EnumValues({
  "main course": Q.MAIN_COURSE,
  "soup": Q.SOUP
});

final mealTypeValues = EnumValues({
  "lunch/dinner": MealType.LUNCH_DINNER
});

final cautionValues = EnumValues({
  "FODMAP": Caution.FODMAP,
  "Sulfites": Caution.SULFITES
});
