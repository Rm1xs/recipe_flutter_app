import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_flutter_app/core/utils/localization/app_localizations.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/pages/login/login_page.dart';
import 'core/presentation/animation/scale_route.dart';
import 'features/authorization/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'features/authorization/presentation/bloc/auth_bloc/auth_event.dart';
import 'features/authorization/presentation/bloc/auth_bloc/auth_state.dart';
import 'features/recipe/presentation/recipe/pages/recipe_page.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  await Firebase.initializeApp();
  await Hive.initFlutter();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: SafeArea(
        child: BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>(),
          child: const Authentication(),
        ),
      ),
    );
  }
}

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(AuthenticationLoggedChek());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is UserNeedsToLogIn) {
          Navigator.pushAndRemoveUntil<void>(
            context,
            ScaleRoute(
              page: const LoginPage(),
            ),
            (Route<dynamic> route) => false,
          );
        } else if (state is UserLogged) {
          Navigator.pushAndRemoveUntil<void>(
            context,
            ScaleRoute(
              page: const RecipePage(),
            ),
            (Route<dynamic> route) => false,
          );
        }
      },
      child: Container(),
    );
  }
}
