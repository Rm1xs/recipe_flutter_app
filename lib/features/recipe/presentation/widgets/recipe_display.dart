import 'package:flutter/material.dart';
import 'package:recipe_flutter_app/domain/entities/recipe.dart';

class RecipeDisplay extends StatelessWidget {

  final Recipe recipe;

  const RecipeDisplay({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Container(
      height: MediaQuery.of(context).size.height / 1.25,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: ListView.builder(
                itemCount: recipe.hits.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(border: Border(
                      bottom: BorderSide(width: 1, color: Colors.grey),
                    ),),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.network(
                              recipe.hits[index].recipe.image,
                              width: 100.0,
                              height: 100.0,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    recipe.hits[index].recipe.label,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.brown,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.green,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                        ('${recipe.hits[index].recipe.calories.toStringAsFixed(1)} Cal'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

