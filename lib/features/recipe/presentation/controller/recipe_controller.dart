import 'package:get/get.dart';
import 'package:recipe_flutter_app/core/data/datasources/recipe_remote_datasource.dart';
import 'package:recipe_flutter_app/core/data/models/hit_model.dart';
import 'package:recipe_flutter_app/core/data/models/recipe_class_model.dart';
import 'package:recipe_flutter_app/core/data/models/recipe_model.dart';

class RecipeController extends GetxController {
  final RecipeRemoteDataSourceImplementation _recipeRepository =
      Get.put(RecipeRemoteDataSourceImplementation());

  RxBool loadingRecipes = false.obs;
  RxBool loadingHistory = false.obs;
  RxList<HitModel> listRecipe = <HitModel>[].obs;

  Future<void> getRecipe(String url) async {
    loadingRecipes.value = true;
    listRecipe.clear();
    _recipeRepository
        .getRecipe(url)
        .whenComplete(() => loadingRecipes.value = false)
        .then((RecipeModel value) => value.hits.forEach((HitModel element) {
              listRecipe.add(element);
            }));
  }

  Future<void> addRecipe(RecipeModel model) {
    return _recipeRepository.addRecipe(model);
  }

  Future<List<RecipeClassModel>> getRecipesFromDb() {
    return _recipeRepository.getRecipesDb();
  }
}
