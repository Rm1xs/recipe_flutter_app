import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_flutter_app/core/data/models/recipe_model.dart';
import 'package:recipe_flutter_app/core/presentation/animation/about_animation_page.dart';
import 'package:recipe_flutter_app/core/utils/localization/app_localizations.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/pages/controls/sign_out_widget.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe/bloc/recipe_bloc.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe/bloc/recipe_event.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe/bloc/recipe_state.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe/widgets/loading_widget.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe/widgets/message_display.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe/widgets/recipe_controls.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe/widgets/recipe_display.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe_history/pages/history_page.dart';

import '../../../../../injection_container.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({Key? key}) : super(key: key);

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  RecipeModel data = RecipeModel(hits: []);
  bool visibility = false;

  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();

    initConnectivity().whenComplete(() {
      setState(() {});
    });
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
      floatingActionButton: Visibility(
        visible: visibility,
        child: FloatingActionButton(
          onPressed: () {
            sl<RecipeBloc>().add(SaveRecipes(list: data));
            const SnackBar snackBar = SnackBar(content: Text('Recipes Saved'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          child: const Icon(Icons.save),
        ),
      ),
      appBar: AppBar(
        title: const Text('Recipes'),
        backgroundColor: Colors.brown[400],
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: (int item) => onSelected(context, item),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<int>(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Container(
                    width: 120,
                    child: RaisedButton.icon(
                      icon: const Icon(Icons.history),
                      label: const Text('History'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                              builder: (BuildContext context) => HistoryPage()),
                        );
                      },
                    ),
                  ),
                ),
              ),
              PopupMenuItem<int>(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Container(
                    width: 120,
                    child: RaisedButton.icon(
                      icon: const Icon(Icons.info),
                      label: Text(AppLocalizations.of(context)!
                          .translate('about_button')
                          .toString()),
                      onPressed: () {
                        showDialog<Dialog>(
                          context: context,
                          builder: (_) => AboutAnimationPage(),
                        );
                      },
                    ),
                  ),
                ),
              ),
              PopupMenuItem<int>(
                child: signOutWidget(context),
              ),
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
    return BlocProvider<RecipeBloc>(
      create: (_) => sl<RecipeBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              const RecipeControls(),
              BlocBuilder<RecipeBloc, RecipeState>(
                builder: (BuildContext context, RecipeState state) {
                  if (state is Empty) {
                    return const MessageDisplay(
                      message: 'Start searching',
                    );
                  } else if (state is Loading) {
                    return const LoadingWidget();
                  } else if (state is Loaded && state.list.hits.isNotEmpty) {
                    data = state.list;
                    return RecipeDisplay(
                      recipe: state.list,
                    );
                  } else if (state is Error) {
                    return const MessageDisplay(message: 'Error');
                  }
                  return const MessageDisplay(message: 'Not found items');
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
      return Future<dynamic>.value(null);
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

  void checkerInternet() {
    if (_connectionStatus == ConnectivityResult.none.toString()) {
      visibility = false;
      return notify('No internet connection');
    } else {
      visibility = true;
    }
  }

  void notify(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}

void onSelected(BuildContext context, int item) {
  switch (item) {
    case 0:
      Navigator.push(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => HistoryPage()),
      );
      break;
    case 1:
      Navigator.push(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => HistoryPage()),
      );
      break;
  }
}
