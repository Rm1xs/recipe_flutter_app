import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_flutter_app/core/utils/localization/app_localizations.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/pages/login/login_page.dart';
import 'features/authorization/presentation/controller/auth_controller.dart';
import 'features/recipe/presentation/controller/recipe_controller.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await di.init();
  final AuthController _controller = Get.put(AuthController());
  Get.put(RecipeController());
  await Hive.initFlutter();
  _controller.checkAuth();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Recipe',
      theme: ThemeData(
        primaryColor: Colors.brown,
      ),
      supportedLocales: const <Locale>[
        Locale('en', 'US'),
        Locale('ru', 'RU'),
      ],
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback:
          (Locale? locale, Iterable<Locale> supportedLocales) {
        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale!.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const SafeArea(
        child: LoginPage(),
      ),
    );
  }
}
