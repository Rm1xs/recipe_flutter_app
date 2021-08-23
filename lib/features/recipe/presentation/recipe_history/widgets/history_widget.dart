import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/controller/recipe_controller.dart';

class HistoryWidget extends StatelessWidget {

  final RecipeController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        Visibility(
            visible: _controller.loadingHistory.value,
            child: showRecipe()
        ));
    // return BlocBuilder<RecipeHistoryBloc, RecipeHistoryState>(
    //   builder: (BuildContext context, RecipeHistoryState state) {
    //     if (state is HistoryEmpty) {
    //       return const Center(child: Text('No data'));
    //     }
    //     if (state is HistoryLoading) {
    //       return const Center(child: CircularProgressIndicator());
    //     }
    //     if (state is HistoryLoaded) {
    //       return ListView.builder(
    //           itemCount: state.recipes.length,
    //           itemBuilder: (BuildContext context, int index) {
    //             return InkWell(
    //               onTap: () {
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute<void>(
    //                     builder: (BuildContext context) => DetailsPage(
    //                       recipe: HitModel(recipe: state.recipes[index]),
    //                       index: index,
    //                     ),
    //                   ),
    //                 );
    //               },
    //               child: ListTile(
    //                 title: Text('${state.recipes[index].label}'),
    //               ),
    //             );
    //           });
    //     }
    //
    //     if (state is HistoryError) {
    //       return const Center(
    //         child: Text('Error', style: TextStyle(fontSize: 20.0)),
    //       );
    //     }

  }
  Widget showRecipe(){
    return Container();
  }
}
