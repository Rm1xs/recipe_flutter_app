import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:recipe_flutter_app/core/animation/scale_route.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe/pages/recipe_page.dart';

class MainLottieAnimation extends StatefulWidget {
  @override
  _MainLottieAnimation createState() => _MainLottieAnimation();
}

class _MainLottieAnimation extends State<MainLottieAnimation>
    with TickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
              'https://assets7.lottiefiles.com/packages/lf20_p1bmwqtk.json',
              controller: _controller,
              onLoaded: (composition) {
                _controller!.duration = composition.duration;
                _controller!.forward().whenComplete(
                      () => Navigator.pushAndRemoveUntil(
                        context,
                        ScaleRoute(
                          page: RecipePage() ,
                        ),
                        (route) => false,
                      ),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
