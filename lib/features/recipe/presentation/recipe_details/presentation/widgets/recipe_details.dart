import 'package:flutter/material.dart';
import 'package:recipe_flutter_app/core/domain/entities/recipe.dart';

class RecipeDetails extends StatelessWidget {
  const RecipeDetails({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: recipe.hits.length,
          itemBuilder: (BuildContext context, int index) {
            return Hero(
              tag: 'item_$index',
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: Colors.grey),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(
                          recipe.hits[index].recipe.image,
                          width: 200.0,
                          height: 200.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
