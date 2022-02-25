import 'package:flutter/material.dart';
import 'dart:async';

import 'package:motokar/screens/signin/signin_view.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context, rootNavigator: true).pushReplacement(
              MaterialPageRoute(builder: (context) => SignInView()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset(
                'assets/images/zen.png',
                width: 200,
                fit: BoxFit.fitWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
