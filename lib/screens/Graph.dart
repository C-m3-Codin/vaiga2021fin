import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:vaiga_farmcare/models/graphModel.dart';

class GraphData extends StatefulWidget {
  const GraphData({
    Key key,
  }) : super(key: key);

  @override
  _GraphDataState createState() => _GraphDataState();
}

class _GraphDataState extends State<GraphData> {
  // List<double> humidity = [];
  // List<double> temperature = [];
  // List<double> soilTemperature = [];
  // List<double> soilMoisture = [];
  // Future<void> showTemperature() async {
  //   // making this both a Future and async method
  //   final databaseRefenceshumid = await FirebaseDatabase.instance
  //       .reference()
  //       .child("Node1")
  //       .child("Ahumid");

  //   final databaseRefencesTemp = await FirebaseDatabase.instance
  //       .reference()
  //       .child("Node1")
  //       .child("Atemp");
  //   final databaseRefencesSoilTemp = await FirebaseDatabase.instance
  //       .reference()
  //       .child("Node1")
  //       .child("Stemp");

  //   // databaseRefences.once()

  //   databaseRefenceshumid.once().then((snapshot) {
  //     Map<dynamic, dynamic> values = snapshot.value;
  //     values.forEach((key, values) {
  //       print(values);
  //       humidity.add(values.toDouble());
  //       // omitting "[keys]" from the OPs approach
  //     });
  //   });

  //   databaseRefencesTemp.once().then((snapshot) {
  //     Map<dynamic, dynamic> values = snapshot.value;
  //     values.forEach((key, values) {
  //       print(values);
  //       // humidity.add(values);
  //       temperature.add(values.toDouble());
  //       // omitting "[keys]" from the OPs approach
  //     });
  //   });

  //   databaseRefencesSoilTemp.once().then((snapshot) {
  //     Map<dynamic, dynamic> values = snapshot.value;
  //     values.forEach((key, values) {
  //       print(values);
  //       soilTemperature.add(values.toDouble());
  //       // omitting "[keys]" from the OPs approach
  //     });
  //   });
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<GraphMode>(context);
    prov.showTemperature();
    // prov.showTemperature();
    return Column(
      children: [
        // StaggeredGridView.count(
        //   crossAxisCount: 4,
        //   crossAxisSpacing: 12.0,
        //   mainAxisSpacing: 12.0,
        //   children: [Padding(padding: EdgeInsets.all(8.0))],
        //   staggeredTiles: [StaggeredTile.extent(4, 250.0)],
        // ),
        Container(child: Text("Ch here")),
        // RaisedButton(onPressed: () {
        // print("Entered 85");
        // prov.showTemperature();
        // }),
        prov.humidity.isEmpty
            ? Text("get fetch")
            : Card(
                elevation: 20,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Sparkline(
                    data: prov.humidity.sublist(
                        prov.humidity.length - 100, prov.humidity.length),
                    lineColor: Colors.redAccent,
                    fillColor: Colors.lightGreen[200],
                    pointsMode: PointsMode.all,
                    // pointSize: 8.0,
                  ),
                ),
              ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 20,
            child: Sparkline(
              data: prov.temperature.sublist(
                  prov.temperature.length - 20, prov.temperature.length),
              lineColor: Colors.yellow,
              fillColor: Colors.lightGreen[200],
              pointsMode: PointsMode.all,
              // pointSize: 8.0,
            ),
          ),
        ),

        Card(
          elevation: 20,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Sparkline(
              data: prov.temperature.sublist(prov.soilTemperature.length - 120,
                  prov.soilTemperature.length),
              lineColor: Colors.blueAccent,
              fillColor: Colors.blueAccent,
              pointsMode: PointsMode.all,
              // pointSize: 8.0,
            ),
          ),
        )
      ],
    );
  }
}
