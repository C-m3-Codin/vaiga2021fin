import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vaiga_farmcare/firebase.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    initializeFirebaseApp(context);
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => null,
    );
  }
  //hey there

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "FARM CARE",
              style: TextStyle(fontSize: 24, letterSpacing: 2.0),
            )
          ],
        ),
      ),
    );
  }
}
