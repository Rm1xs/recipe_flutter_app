import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double scaffoldOpacity = 1.0;
  bool isSettingsOpen = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedOpacity(
          opacity: scaffoldOpacity,
          duration: Duration(milliseconds: 100),
          child: Scaffold(
            appBar: AppBar(
              leading: FlatButton(
                child: Icon(Icons.settings),
                onPressed: () {
                  setState(() {
                    scaffoldOpacity = 0.3;
                    isSettingsOpen = true;
                  });
                },
              ),
              title: Text('Main Page'),
            ),
            body: Container(
              color: Colors.white,
              child: Text('MAIN PAGE BODY'),
            ),
          ),
        ),
        Visibility(
            visible: isSettingsOpen,
            child: Container(
              child: Column(
                children: <Widget>[
                  Text('Settings'),
                  //Button,

                  //Button to close settings dialog
                  FlatButton(
                    child: Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        scaffoldOpacity = 1.0;
                        isSettingsOpen = false;
                      });
                    },
                  ),

                  // rest of the settings page ui
                ],
              ),
            )),
      ],
    );
  }
}
