import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaiga_farmcare/provider/provider.dart';
import 'package:vaiga_farmcare/screens/graph.dart';
import 'package:vaiga_farmcare/screens/realtime.dart';
import 'package:vaiga_farmcare/screens/splashscreen.dart';
import 'package:vaiga_farmcare/tflite/disease_detect.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => UserProvider(),
        child: MaterialApp(
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: SplashScreen(),
          routes: {
            "splash": (contxt) => SplashScreen(),
            'home': (context) => HomePage(),
            'realTime': (context) => RealTime(),
            "tab": (context) => TabBarDemo(),
            'diseaseDetect': (context) => DiseaseDetection(),
            'shell': (context) => Shell()
          },
        ));
  }
}
