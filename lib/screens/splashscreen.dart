import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaiga_farmcare/firebase.dart';
import 'package:vaiga_farmcare/provider/provider.dart';

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
<<<<<<< HEAD
      () => Navigator.pushNamed(context, 'shell'),
=======
      // () => Navigator.pushNamed(context, 'realTime'),
      () => Navigator.pushNamed(context, 'tab'),
      // () => Navigator.pushNamed(context, 'stream')
      // () => Navigator.pushNamed(context, 'realTime'),
>>>>>>> c7a5e61319cd1f618d16f6a9fd9055a923acdcfa
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
