import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_flutter_app/core/data/models/recipe_model.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe_details/presentation/pages/details_page.dart';

class RecipeDisplay extends StatefulWidget {
  const RecipeDisplay({
    Key? key,
    required this.recipe,
  }) : super(key: key);
  final RecipeModel recipe;

  @override
  _RecipeDisplayState createState() => _RecipeDisplayState();
}

class _RecipeDisplayState extends State<RecipeDisplay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.recipe.hits.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(widget.recipe.hits[index].recipe.label),
              onDismissed: (DismissDirection direction) {
                // Remove the item from the data source.
                setState(() {
                  widget.recipe.hits.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        '${widget.recipe.hits[index].recipe.label} dismissed'),
                  ),
                );
              },
              background: Container(
                color: Colors.red[400],
                child: const Center(
                  child: Text(
                    'Delete',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => DetailsPage(
                        recipe: widget.recipe.hits[index],
                        index: index,
                      ),
                    ),
                  );
                },
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
                        Hero(
                          tag: 'item_$index',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: CachedNetworkImage(
                              width: 80.0,
                              height: 80.0,
                              fit: BoxFit.fill,
                              imageUrl: widget.recipe.hits[index].recipe.image,
                              placeholder: (BuildContext context, String url) =>
                                  Transform.scale(
                                scale: 0.5,
                                child: const CircularProgressIndicator(),
                              ),
                              errorWidget:
                                  (BuildContext context, String url, dynamic error) =>
                                      const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.recipe.hits[index].recipe.label,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.brown,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.green,
                                      width: 0.8,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      '${widget.recipe.hits[index].recipe.calories.toStringAsFixed(1)} Cal',
                                      style: const TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.brown,
                                      ),
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
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
