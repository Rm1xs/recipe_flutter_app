abstract class RecipeEvent {}

class GetRecipe extends RecipeEvent {
  final String inputString;

  GetRecipe(this.inputString);

}
