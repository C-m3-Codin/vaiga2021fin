import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaiga_farmcare/firebase.dart';
import 'package:vaiga_farmcare/models/StreamParser.dart';
import 'package:vaiga_farmcare/provider/provider.dart';
import 'package:vaiga_farmcare/screens/LatestNodes.dart';

import 'NodesBar.dart';

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
                Tab(icon: Icon(Icons.sanitizer)),
                Tab(icon: Icon(Icons.graphic_eq)),
              ],
            ),
            title: Text('FarmCare'),
          ),
          body: TabBarView(
            children: [
              HomePage(),
              NodeCollectionPage(),
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
// r recentJobsRef = FirebaseDatabase.instance.reference().child('data');

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<UserProvider>(context);
    final uses = prov.getUser;
    DatabaseReference _dhtref = FirebaseDatabase.instance.reference().child('');
    // final data = prov.readFromRTDBTemperature();

// StreamBuilder(
//               stream: _dhtref.onValue,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData &&
//                     !snapshot.hasError &&
//                     snapshot.data.snapshot.value != null) {
//                   print("${snapshot.data.snapshot.value.toString()}");
//                   var _dht =
//                       DHT.fromJson(snapshot.data.snapshot.value['Node1']);
//                   print(
//                       "DHT: ${_dht.solidTEmp} / ${_dht.humidity} / ${_dht.temp}");
//                   return Text("${_dht.solidTEmp}");
//                 } else {
//                   print("\n\n\n error");
//                   return Text("Error");
//                 }
//                 // return Container(
//                 //     child: Text("${_dht.solidTEmp.toString()}"));
//               },
//             ),

    return StreamBuilder(
        stream: _dhtref.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              !snapshot.hasError &&
              snapshot.data.snapshot.value != null) {
            // print("${snapshot.data.snapshot.value.toString()}");
            var _dht = DHT.fromJson(snapshot.data.snapshot.value['Node1']);
            print("DHT: ${_dht.solidTEmp} / ${_dht.humidity} / ${_dht.temp}");
            return Container(
                child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          color: Colors.blue,
                          // height: 30,
                          child: _dht.humidity == -1
                              ? Text("temperature", textAlign: TextAlign.center)
                              : Card(
                                  child: Text(
                                      "Soil Temperature is ${_dht.solidTEmp}",
                                      textAlign: TextAlign.center)),
                        ),
                        // Text("Humidity"),
                        Container(
                          color: Colors.blue,
                          // height: 30,
                          child: _dht.humidity == -1
                              ? Text("Not Fetched", textAlign: TextAlign.center)
                              : Card(
                                  child: Text("Humidity is ${_dht.humidity}",
                                      textAlign: TextAlign.center)),
                        ),
                        // RecomendsPlants(),
                        // FeaturedPlants(),
                        // Text("Dew Point"),
                        Container(
                          color: Colors.blue,
                          child: _dht.humidity == -1
                              ? Text("Not fetched")
                              : Card(
                                  child: Text(" Temperature is ${_dht.temp}",
                                      textAlign: TextAlign.center)),
                        ),

                        Container(
                          color: Colors.blue,
                          child: _dht.humidity == -1
                              ? Text("Not fetched")
                              : Card(
                                  child: Text("Soil moist is ${_dht.solidTEmp}",
                                      textAlign: TextAlign.center)),
                        ),
                        Container(
                          color: Colors.blue,
                          child: _dht.humidity == -1
                              ? Text("Not fetched")
                              : Card(
                                  child: Text("Soil moist is ${_dht.smoistNow}",
                                      textAlign: TextAlign.center)),
                        ),

                        // RaisedButton(
                        //     color: Colors.green,
                        //     onPressed: () async {
                        //       print("\n\n\n tadaaa$temperature");
                        //       // humidity = await readDate();
                        //       await prov.readDate();
                        //       print("hum,$humidity");
                        //       setState(() {});
                        //     },
                        //     child: Text("fetch values")),
                      ],
                    )));
          } else {
            return Container(child: Text("Fetch ing"));
          }
        });
  }
}

class StreamReal extends StatefulWidget {
  @override
  _StreamRealState createState() => _StreamRealState();
}

class _StreamRealState extends State<StreamReal> {
  // var _firebaseRef = FirebaseDatabase().reference().child('Node1/Ahumid/');
  // TextEditingController _txtCtrl = TextEditingController();
  DatabaseReference _dhtref = FirebaseDatabase.instance.reference().child('');
  @override
  Widget build(BuildContext context) {
    // var comments = _firebaseRef.limitToLast(10);
    return Scaffold(
        body: SafeArea(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
              stream: _dhtref.onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    !snapshot.hasError &&
                    snapshot.data.snapshot.value != null) {
                  print("${snapshot.data.snapshot.value.toString()}");
                  var _dht =
                      DHT.fromJson(snapshot.data.snapshot.value['Node1']);
                  print(
                      "DHT: ${_dht.solidTEmp} / ${_dht.humidity} / ${_dht.temp}");
                  return Text("${_dht.solidTEmp}");
                } else {
                  print("\n\n\n error");
                  return Text("Error");
                }
                // return Container(
                //     child: Text("${_dht.solidTEmp.toString()}"));
              },
            ),
          ],
        ),
      ),
    ));
  }
}

class NodeCollectionPage extends StatefulWidget {
  @override
  NodeCollectionPageState createState() => NodeCollectionPageState();
}

class NodeCollectionPageState extends State<NodeCollectionPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Align(
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RecomendsPlants(),
                  FeaturedPlants(),
                ])));
  }
}
