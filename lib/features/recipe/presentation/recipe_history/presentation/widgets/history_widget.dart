import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_flutter_app/core/data/models/hit_model.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe_details/presentation/pages/details_page.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe_history/presentation/bloc/recipe_history_bloc.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe_history/presentation/bloc/recipe_history_state.dart';

class HistoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeHistoryBloc, RecipeHistoryState>(
      builder: (context, state) {
        if (state is HistoryEmpty) {
          return Center(child: Text('No data'));
        }
        if (state is HistoryLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is HistoryLoaded) {
          return ListView.builder(
              itemCount: state.recipes.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(
                          recipe: HitModel(recipe: state.recipes[index]),
                          index: index,
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text('${state.recipes[index].label}'),
                  ),
                );
              });
        }

        if (state is HistoryError) {
          return Center(
            child: Text('Error', style: TextStyle(fontSize: 20.0)),
          );
        }
        return Container();
      },
    );
  }
}
