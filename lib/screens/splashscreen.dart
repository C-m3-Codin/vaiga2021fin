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
      () => Navigator.pushNamed(context, 'shell'),
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

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<UserProvider>(context);
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.arrow_left_sharp)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: Text('FarmCare'),
          ),
          body: TabBarView(
            children: [
              HomePage(),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                prov.readDate();
              },
              child: Icon(Icons.add)),
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
  final databaseRef = FirebaseDatabase.instance.reference();
  String humidity = "";
  String temperature = "";
  int temp, humid;
  double td, valu;
  // void readDate() {

  //   databaseRef.child("Humidity").once().then((DataSnapshot data) =>
  //       {print("${data.value}"), humidity = data.value.toString()});
  //   databaseRef.child("Temperature").once().then((DataSnapshot data) =>
  //       {print("${data.value}"), temperature = data.value.toString()});
  // }

  // Future<String> readDate() async {
  //   databaseRef.child("Humidity").once().then((DataSnapshot data) => {
  //         print("${data.value}"),
  //         humidity = data.value.toString(),
  //         humid = int.parse(humidity)
  //       });
  //   databaseRef.child("Temperature").once().then((DataSnapshot data) => {
  //         print("${data.value}"),
  //         temperature = data.value.toString(),
  //         temp = int.parse(temperature),
  //         td = temp - ((100 - humid) / 100),
  //         valu = 100 - (((temp - td) / temp) * 100)
  //       });
  //   var dat = await databaseRef.child("Humidity").once();
  //   var da = dat.value;
  //   return da.toString();
  // }

  // var recentJobsRef = FirebaseDatabase.instance.reference().child('data');

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<UserProvider>(context);
    final uses = prov.getUser;
    // final data = prov.readFromRTDBTemperature();

    return Container(
        child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: Colors.blue,
                  height: 30,
                  child: prov.temperature.isEmpty
                      ? Text("temperature", textAlign: TextAlign.center)
                      : Card(
                          child: Text("Temperature is ${prov.temperature}",
                              textAlign: TextAlign.center)),
                ),
                // Text("Humidity"),
                Container(
                  color: Colors.blue,
                  height: 30,
                  child: prov.temperature.isEmpty
                      ? Text("Not Fetched", textAlign: TextAlign.center)
                      : Card(
                          child: Text("Humidity is ${prov.humidity}",
                              textAlign: TextAlign.center)),
                ),
                // Text("Dew Point"),
                Container(
                  color: Colors.blue,
                  child: prov.temperature.isEmpty
                      ? Text("Not fetched")
                      : Card(
                          child: Text("dew point is ",
                              textAlign: TextAlign.center)),
                ),
                Container(
                    color: Colors.blue,
                    child: prov.temperature.isEmpty
                        ? Text("No values yet")
                        : Card(
                            child: Text(
                                prov.humid > 75
                                    ? "Turn on fan"
                                    : "Gonna start Irrigation ",
                                textAlign: TextAlign.center))),

                RaisedButton(
                    color: Colors.green,
                    onPressed: () async {
                      print("\n\n\n tadaaa$temperature");
                      // humidity = await readDate();
                      await prov.readDate();
                      print("hum,$humidity");
                      setState(() {});
                    },
                    child: Text("fetch values")),
              ],
            )));
  }
}
