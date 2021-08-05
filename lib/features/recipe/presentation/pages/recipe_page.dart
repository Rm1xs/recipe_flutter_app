import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_flutter_app/domain/entities/recipe.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/bloc/bloc.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/widgets/loading_widget.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/widgets/message_display.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/widgets/recipe_controls.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/widgets/recipe_display.dart';


import '../../../../injection_container.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({Key? key}) : super(key: key);

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  Recipe data = Recipe(hits: []);

  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            sl<RecipeBloc>()
                .add(SaveRecipes(list: data));
            final snackBar = SnackBar(content: const Text('Data saved'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          child: Icon(Icons.save),
        ),
      appBar: AppBar(
        title: Text('Recipes'),
        actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              PopupMenuItem(value: 0, child: Text('History')),
              PopupMenuItem(value: 1, child: Text('About')),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }


  BlocProvider<RecipeBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RecipeBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              RecipeControls(),
              BlocBuilder<RecipeBloc, RecipeState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return MessageDisplay(
                      message: 'Start searching',
                    );
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Loaded) {
                    data = state.list;
                    return RecipeDisplay(recipe: state.list,);
                  } else if (state is Error) {
                    return MessageDisplay(message: 'Error');
                  }
                  return MessageDisplay(message: 'Not found items');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        checkerInternet();
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

  checkerInternet(){
    if(_connectionStatus == ConnectivityResult.none.toString()){
      return notify('No internet connection');
    }
    else if(_connectionStatus == ConnectivityResult.wifi.toString() ||  _connectionStatus == ConnectivityResult.mobile.toString()){
      return notify('Connected');
    }
    else{
      return notify('Failed to get connectivity');
    }
  }

  notify(String message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
void onSelected(BuildContext context, int item) {
  switch (item) {
    case 0:
      print('hi');
      break;
    case 1:
      print('hi');
      break;
  }
}




