import 'dart:async';
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
      () => Navigator.pushNamed(context, 'home'),
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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<userProvider>(context);
    final uses = prov.getUser;

    return Scaffold(
      appBar: AppBar(
        title: Text("Farm Care"),
      ),
      body: Container(
        child: Text("Bam"),
      ),
    );
  }
}
