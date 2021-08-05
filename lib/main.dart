import 'package:flutter/material.dart';
import 'package:recipe_flutter_app/core/animation/main_lottie_animation.dart';
import 'package:recipe_flutter_app/core/localization/app_localizations.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppLocalizations.of(context)!.translate('app_name')!,
      theme: ThemeData(primaryColor: Colors.brown,),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ru', 'RU'),
      ],

      localizationsDelegates: [

        AppLocalizations.delegate,

      ],

      localeResolutionCallback: (locale, supportedLocales) {

        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale!.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      home: SafeArea(child: MainLottieAnimation()),
    );
  }
}

