import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaiga_farmcare/firebase.dart';
import 'package:vaiga_farmcare/models/StreamParser.dart';
import 'package:vaiga_farmcare/models/graphModel.dart';
import 'package:vaiga_farmcare/provider/provider.dart';
import 'package:vaiga_farmcare/screens/Graph.dart';
import 'package:vaiga_farmcare/screens/LatestNodes.dart';
import 'package:vaiga_farmcare/screens/cropdata.dart';
import 'package:vaiga_farmcare/tflite/disease_detect.dart';

import 'NodesBar.dart';

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<UserProvider>(context);
    return MaterialApp(
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.arrow_left_sharp)),
                Tab(icon: Icon(Icons.sanitizer)),
                Tab(icon: Icon(Icons.graphic_eq)),
                Tab(
                  icon: Icon(Icons.camera),
                ),
                Tab(icon: Icon(Icons.soap_outlined)),
              ],
            ),
            title: Text('FarmCare'),
          ),
          body: TabBarView(
            children: [
              HomePage(),
              NodeCollectionPage(),
              // Icon(Icons.directions_bike),
              ChangeNotifierProvider(
                  create: (context) => GraphMode(), child: GraphData()),
              DiseaseDetection(), CropData(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                prov.readDate();
              },
              child: Icon(Icons.read_more)),
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
                // color: Colors.blue,
                child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Card(
                                color: _dht.pump == 1.2
                                    ? Colors.green
                                    : Colors.white,
                                elevation: 2,
                                child: InkWell(
                                  onTap: () {
                                    var value = _dht.pump == 1.2 ? -1.2 : 1.2;
                                    print(
                                        "\n\n\n\n\n\n\n\n\n\nturn on sprayer\n\n\n\n\n\n\n");
                                    FirebaseDatabase.instance
                                        .reference()
                                        .child("Node1")
                                        .update({
                                      'irrigation': value,
                                      // 'description': 'Team Lead'
                                    });
                                  },
                                  child: Icon(
                                    Icons.water_damage,
                                    size: 50,
                                    color: Colors.blue,
                                  ),
                                )),
                            Card(
                                elevation: 2,
                                color: _dht.fan == -1.2
                                    ? Colors.green
                                    : Colors.white,
                                child: InkWell(
                                  onTap: () {
                                    var value = _dht.fan == 1.2 ? -1.2 : 1.2;
                                    print(
                                        "\n\n\n\n\n\n\n\n\n\nTurn On Fan\n\n\n\n\n\n\n");
                                    FirebaseDatabase.instance
                                        .reference()
                                        .child("Node1")
                                        .update({
                                      'Fan': value,
                                      // 'description': 'Team Lead'
                                    });
                                  },
                                  child: Icon(
                                    Icons.fire_hydrant,
                                    size: 50,
                                    color: Colors.amber,
                                  ),
                                )),
                            Card(
                              elevation: 2,
                              color: _dht.light == 1.2
                                  ? Colors.white
                                  : Colors.black,
                              child: Icon(
                                  _dht.light == 1.2
                                      ? Icons.wb_sunny
                                      : Icons.lightbulb,
                                  size: 50,
                                  color: Colors.yellow),
                            )
                          ],
                        ),
                        Container(
                          height: 72,
                          color: Colors.blue,
                          child: _dht.humidity == -1
                              ? Text("Not fetched")
                              : Center(
                                  child: Card(
                                      child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.hot_tub),
                                        Text(
                                          "Soil Temperature : ${_dht.solidTEmp}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  )),
                                ),
                        ),
                        // Container(
                        //   color: Colors.blue,
                        //   // height: 30,
                        //   child: _dht.humidity == -1
                        //       ? Text("temperature", textAlign: TextAlign.center)
                        //       : Card(
                        //           child: Text(
                        //               "Soil Temperature is ${_dht.solidTEmp}",
                        //               textAlign: TextAlign.center)),
                        // ),
                        // Text("Humidity"),
                        Container(
                          height: 72,
                          color: Colors.blue,
                          child: _dht.humidity == -1
                              ? Text("Not fetched")
                              : Center(
                                  child: Card(
                                      elevation: 6.0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(Icons.waterfall_chart),
                                            Text(
                                              " Humidity : ${_dht.humidity}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                        ),
                        // Container(
                        //   color: Colors.blue,
                        //   // height: 30,
                        //   child: _dht.humidity == -1
                        //       ? Text("Not Fetched", textAlign: TextAlign.center)
                        //       : Card(
                        //           child: Text("Humidity is ${_dht.humidity}",
                        //               textAlign: TextAlign.center)),
                        // ),
                        // RecomendsPlants(),
                        // FeaturedPlants(),
                        // Text("Dew Point"),
                        Container(
                          height: 72,
                          color: Colors.blue,
                          child: _dht.humidity == -1
                              ? Text("Not fetched")
                              : Center(
                                  child: Card(
                                      child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.thermostat_rounded),
                                        Text(
                                          " Temperature : ${_dht.temp}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  )),
                                ),
                        ),
                        Container(
                          height: 72,
                          color: Colors.blue,
                          child: _dht.humidity == -1
                              ? Text("Not fetched")
                              : Center(
                                  child: Card(
                                      child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.wb_sunny),
                                        Text(
                                          "Light Intensity : ${_dht.light}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  )),
                                ),
                        ),
                        // Container(
                        //   color: Colors.blue,
                        //   child: _dht.humidity == -1
                        //       ? Text("Not fetched")
                        //       : Card(
                        //           child: Text("Soil moist is ${_dht.solidTEmp}",
                        //               textAlign: TextAlign.center)),
                        // ),
                        Container(
                          height: 72,
                          color: Colors.blue,
                          child: _dht.humidity == -1
                              ? Text("Not fetched")
                              : Center(
                                  child: Card(
                                      child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      "Soil moist : ${_dht.smoistNow}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  )),
                                ),
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
