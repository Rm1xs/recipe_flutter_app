class Ingredient {
  Ingredient({
    required this.text,
    required this.weight,
    required this.foodCategory,
    required this.foodId,
    required this.image,
  });

  String text;
  double weight;
  String foodCategory;
  String foodId;
  String image;


  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
    text: json["text"],
    weight: json["weight"].toDouble(),
    foodCategory: json["foodCategory"],
    foodId: json["foodId"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "weight": weight,
    "foodCategory": foodCategory,
    "foodId": foodId,
    "image": image == null ? null : image,
  };
}