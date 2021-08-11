import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:recipe_flutter_app/core/animation/scale_route.dart';
import 'package:recipe_flutter_app/core/localization/app_localizations.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/pages/login/login_page.dart';
import 'features/authorization/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'features/authorization/presentation/bloc/auth_bloc/auth_event.dart';
import 'features/authorization/presentation/bloc/auth_bloc/auth_state.dart';
import 'features/recipe/presentation/recipe/pages/recipe_page.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  Firebase.initializeApp();

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
      supportedLocales: [
        Locale('en', 'US'),
        Locale('sk', 'SK'),
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
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: SafeArea(
        child: AnimatedSplashScreen(
          duration: 2500,
          splash: Lottie.network(
            'https://assets7.lottiefiles.com/packages/lf20_p1bmwqtk.json',
          ),
          nextScreen: BlocProvider<AuthenticationBloc>(
            create: (_) => sl<AuthenticationBloc>(),
            child: Authentication(),
          ),
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
    BlocProvider.of<AuthenticationBloc>(context)
        .add(AuthenticationLoggedChek());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is UserNeedsToLogIn) {
          Navigator.pushAndRemoveUntil(
            context,
            ScaleRoute(
              page: const LoginPage(),
            ),
            (Route route) => false,
          );
        } else if (state is UserLogged) {
          Navigator.pushAndRemoveUntil(
            context,
            ScaleRoute(
              page: const RecipePage(),
            ),
            (Route route) => false,
          );
        }
      },
      child: Container(),
    );
  }
}
