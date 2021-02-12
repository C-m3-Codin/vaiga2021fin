import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaiga_farmcare/provider/provider.dart';
import 'package:vaiga_farmcare/screens/graph.dart';
import 'package:vaiga_farmcare/screens/homescreen.dart';
import 'package:vaiga_farmcare/screens/realtime.dart';
import 'package:vaiga_farmcare/screens/splashscreen.dart';
import 'package:vaiga_farmcare/tflite/disease_detect.dart';

import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => UserProvider(),
        child: MaterialApp(
          // theme: ThemeData(
          //   // dar
          //   scaffoldBackgroundColor: Colors.green,
          //   primaryColor: kPrimaryColor,
          //   textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
          //   visualDensity: VisualDensity.adaptivePlatformDensity,
          //   // visualDensity: VisualDensity.adaptivePlatformDensity,
          // ),
          theme: ThemeData.dark(),
          darkTheme: ThemeData.dark(),

          home: SplashScreen(),
          routes: {
            "splash": (contxt) => SplashScreen(),
            'home': (context) => HomePage(),
            'realTime': (context) => RealTime(),
            "tab": (context) => TabBarDemo(),
            'diseaseDetect': (context) => DiseaseDetection(),
            // 'shell': (context) => Shell(),
            "stream": (context) => StreamReal(),
          },
        ));
  }
}
