import 'package:get/get.dart';
import 'package:recipe_flutter_app/core/data/datasources/recipe_remote_datasource.dart';
import 'package:recipe_flutter_app/core/data/models/recipe_class_model.dart';
import 'package:recipe_flutter_app/core/data/models/recipe_model.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe/widgets/loading_widget.dart';


class RecipeController extends GetxController {
  final RecipeRemoteDataSourceImplementation _recipeRepository =
      Get.put(RecipeRemoteDataSourceImplementation());

  RxBool loadingRecipes = false.obs;

  Future<RecipeModel> getRecipe(String url) {
    loadingRecipes.value = true;
    return _recipeRepository.getRecipe(url).whenComplete(() => loadingRecipes.value = false);
  }

  Future<void> addRecipe(RecipeModel model){
    return _recipeRepository.addRecipe(model);
  }

  Future<List<RecipeClassModel>> getRecipesFromDb(){
    return _recipeRepository.getRecipesDb();
  }
}
