import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutAnimationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AboutAnimationState();
}

class AboutAnimationState extends State<AboutAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> position;

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Widget _infoTile(String title, String subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle.isEmpty ? 'Not set' : subtitle),
    );
  }

  @override
  void initState() {
    super.initState();

    _initPackageInfo();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    position = Tween<Offset>(begin: Offset(0.0, -4.0), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: controller, curve: Curves.bounceInOut));

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: SlideTransition(
          position: position,
          child: Container(
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Container(
                  child: _infoTile('App version', _packageInfo.version),
                )),
          ),
        ),
      ),
    );
  }
}
