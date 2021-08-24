import 'package:flutter/material.dart';
import 'package:recipe_flutter_app/core/data/models/hit_model.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key, required this.recipe, required this.index})
      : super(key: key);

  final HitModel recipe;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.brown[400],
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height / 2.5,
            leading: const BackButton(color: Colors.black),
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
                      style: const TextStyle(
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
                      // border: Border.all(
                      //   color: Colors.green,
                      //   width: 0,
                      // ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text(
                        '${recipe.recipe.calories.toStringAsFixed(1)} Calories',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 35, 0, 20),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
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
                        recipe.recipe.ingredientLines.length, (int index) {
                      return Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                '• ${recipe.recipe.ingredientLines[index]}',
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.brown),
                              ),
                            ),
                          ),
                          const Divider(),
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
