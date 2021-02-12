import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaiga_farmcare/provider/provider.dart';
<<<<<<< HEAD
import 'package:vaiga_farmcare/screens/graph.dart';
=======
import 'package:vaiga_farmcare/screens/homescreen.dart';
>>>>>>> c7a5e61319cd1f618d16f6a9fd9055a923acdcfa
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
          theme: ThemeData(
            scaffoldBackgroundColor: kBackgroundColor,
            primaryColor: kPrimaryColor,
            textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            // visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: SplashScreen(),
          routes: {
            "splash": (contxt) => SplashScreen(),
            'home': (context) => HomePage(),
            'realTime': (context) => RealTime(),
            "tab": (context) => TabBarDemo(),
<<<<<<< HEAD
            'diseaseDetect': (context) => DiseaseDetection(),
            'shell': (context) => Shell()
=======
            "stream": (context) => StreamReal(),
>>>>>>> c7a5e61319cd1f618d16f6a9fd9055a923acdcfa
          },
        ));
  }
}
