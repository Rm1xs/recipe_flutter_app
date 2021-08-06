import 'package:flutter/material.dart';
import 'package:recipe_flutter_app/core/animation/main_lottie_animation.dart';
import 'package:recipe_flutter_app/core/localization/app_localizations.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe',
      theme: ThemeData(
        primaryColor: Colors.brown,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: SafeArea(child: MainLottieAnimation()),
    );
  }
}
