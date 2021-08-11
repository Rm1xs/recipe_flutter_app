import 'package:flutter/material.dart';
import 'package:recipe_flutter_app/core/data/models/hit_model.dart';

class DetailsPage extends StatelessWidget {
  final HitModel recipe;
  final int index;

  const DetailsPage({Key? key, required this.recipe, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height / 2.5,
            leading: BackButton(color: Colors.black),
            //title: Text(recipe.recipe.label),
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                  tag: 'item_$index',
                  child: Image.network(recipe.recipe.image, fit: BoxFit.cover)),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 35, 0, 20),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      recipe.recipe.label,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.lightGreen[400],
                      border: Border.all(
                        color: Colors.green,
                        width: 0,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text(
                        '${recipe.recipe.calories.toStringAsFixed(1)} Calories',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 35, 0, 20),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Ingredients:',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.brown,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 20, 0),
                  child: Column(
                    children: List.generate(
                        recipe.recipe.ingredientLines.length, (index) {
                      return Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                '• ${recipe.recipe.ingredientLines[index]}',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.brown),
                              ),
                            ),
                          ),
                          Divider(),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
