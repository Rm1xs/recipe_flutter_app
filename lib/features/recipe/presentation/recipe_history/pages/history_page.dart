import 'package:flutter/material.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe_history/widgets/history_widget.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'),
        backgroundColor: Colors.brown[400],
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(child: HistoryWidget()),
        ],
      ),
    );
  }
}
