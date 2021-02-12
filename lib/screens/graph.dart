import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:oscilloscope/oscilloscope.dart';
import 'dart:async';
import 'dart:math' as math;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Oscilloscope Display Example",
      home: Shell(),
    );
  }
}

class Shell extends StatefulWidget {
  @override
  _ShellState createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  List<double> traceSine = List();
  List<double> traceCosine = List();
  List<double> humidityList = List();
  List<double> tempList = List();
  List<double> soilTempList = List();

  double radians = 0.0;
  Timer _timer;
  double dataHumidity;
  double dataTemp;
  double dataSoilTemp;

  _generateTrace(Timer t) async {
    // generate our  values

    var databaseReference = FirebaseDatabase.instance.reference();

    await databaseReference.child('Node1/AhumidNow').once().then((value) {
      print(value.value);
      dataHumidity = double.parse(value.value.toString());
    });
    await databaseReference.child('Node1/AtempNow').once().then((value) {
      print(value.value);
      dataTemp = double.parse(value.value.toString());
    });
    await databaseReference.child('Node1/StempNow').once().then((value) {
      print(value.value);
      dataSoilTemp = double.parse(value.value.toString());
    });

    // Add to the growing dataset
    setState(() {
      humidityList.add(dataHumidity);
      tempList.add(dataTemp);
      soilTempList.add(dataSoilTemp);
    });
  }

  @override
  initState() {
    super.initState();
    // create our timer to generate test values
    _timer = Timer.periodic(Duration(milliseconds: 3000), _generateTrace);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Create A Scope Display for Sine
    Oscilloscope tempScope = Oscilloscope(
      showYAxis: false,
      yAxisColor: Colors.orange,
      padding: 20.0,
      backgroundColor: Colors.grey[300],
      traceColor: Colors.blueAccent,
      yAxisMax: 50,
      yAxisMin: 30,
      dataSet: tempList,
    );

    Oscilloscope soilTempScope = Oscilloscope(
      showYAxis: false,
      yAxisColor: Colors.orange,
      padding: 20.0,
      backgroundColor: Colors.grey[300],
      traceColor: Colors.blueAccent,
      yAxisMax: 50,
      yAxisMin: 30,
      dataSet: soilTempList,
    );

    Oscilloscope humidityScope = Oscilloscope(
      showYAxis: false,
      yAxisColor: Colors.orange,
      padding: 20.0,
      backgroundColor: Colors.grey[300],
      traceColor: Colors.blueAccent,
      yAxisMax: 50,
      yAxisMin: 30,
      dataSet: humidityList,
    );

    // Generate the Scaffold
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("OscilloScope Demo"),
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Text(
                'HUMIDITY',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: humidityScope,
              height: 180,
            ),
            // Expanded(flex: 1, child: humidityScope),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Text(
                'AMBIENT TEMPERATURE',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: tempScope,
              height: 180,
            ),
            // Expanded(flex: 1, child: tempScope),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Text(
                'SOIL TEMPERATURE',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: soilTempScope,
              height: 180,
            ),
            // Expanded(flex: 1, child: soilTempScope),
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            //   child: Text(
            //     'LIGHT INTENSITY',
            //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //   ),
            // ),
            // Container(
            //   child: soilTempScope,
            //   height: 140,
            // ),
            // Expanded(flex: 1, child: soilTempScope),
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            //   child: Text(
            //     'SOIL MOISTURE',
            //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //   ),
            // ),
            // Container(
            //   child: humidityScope,
            //   height: 140,
            // ),
            // Expanded(flex: 1, child: soilTempScope),
          ],
        ),
      ),
    );
  }
}

// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_sparkline/flutter_sparkline.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:provider/provider.dart';
// import 'package:vaiga_farmcare/models/graphModel.dart';

// import 'package:fl_chart/fl_chart.dart';

// // import 'bar_chart/bar_chart_page.dart';
// // import 'bar_chart/bar_chart_page2.dart';
// // import 'line_chart/line_chart_page.dart';
// // import 'line_chart/line_chart_page2.dart';
// // import 'line_chart/line_chart_page3.dart';
// // import 'line_chart/line_chart_page4.dart';
// // import 'pie_chart/pie_chart_page.dart';
// // import 'scatter_chart/scatter_chart_page.dart';

// class GraphData extends StatefulWidget {
//   const GraphData({
//     Key key,
//   }) : super(key: key);

//   @override
//   _GraphDataState createState() => _GraphDataState();
// }

// class _GraphDataState extends State<GraphData> {
//   // List<double> humidity = [];
//   // List<double> temperature = [];
//   // List<double> soilTemperature = [];
//   // List<double> soilMoisture = [];
//   // Future<void> showTemperature() async {
//   //   // making this both a Future and async method
//   //   final databaseRefenceshumid = await FirebaseDatabase.instance
//   //       .reference()
//   //       .child("Node1")
//   //       .child("Ahumid");

//   //   final databaseRefencesTemp = await FirebaseDatabase.instance
//   //       .reference()
//   //       .child("Node1")
//   //       .child("Atemp");
//   //   final databaseRefencesSoilTemp = await FirebaseDatabase.instance
//   //       .reference()
//   //       .child("Node1")
//   //       .child("Stemp");

//   //   // databaseRefences.once()

//   //   databaseRefenceshumid.once().then((snapshot) {
//   //     Map<dynamic, dynamic> values = snapshot.value;
//   //     values.forEach((key, values) {
//   //       print(values);
//   //       humidity.add(values.toDouble());
//   //       // omitting "[keys]" from the OPs approach
//   //     });
//   //   });

//   //   databaseRefencesTemp.once().then((snapshot) {
//   //     Map<dynamic, dynamic> values = snapshot.value;
//   //     values.forEach((key, values) {
//   //       print(values);
//   //       // humidity.add(values);
//   //       temperature.add(values.toDouble());
//   //       // omitting "[keys]" from the OPs approach
//   //     });
//   //   });

//   //   databaseRefencesSoilTemp.once().then((snapshot) {
//   //     Map<dynamic, dynamic> values = snapshot.value;
//   //     values.forEach((key, values) {
//   //       print(values);
//   //       soilTemperature.add(values.toDouble());
//   //       // omitting "[keys]" from the OPs approach
//   //     });
//   //   });
//   //   setState(() {});
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final prov = Provider.of<GraphMode>(context);
//     prov.showTemperature();
//     // prov.showTemperature();
//     return Column(
//       children: [
//         // StaggeredGridView.count(
//         //   crossAxisCount: 4,
//         //   crossAxisSpacing: 12.0,
//         //   mainAxisSpacing: 12.0,
//         //   children: [Padding(padding: EdgeInsets.all(8.0))],
//         //   staggeredTiles: [StaggeredTile.extent(4, 250.0)],
//         // ),
//         Container(child: Text("Ch here")),
//         // RaisedButton(onPressed: () {
//         // print("Entered 85");
//         // prov.showTemperature();
//         // }),
//         prov.humidity.isEmpty
//             ? Text("get fetch")
//             : Card(
//                 elevation: 20,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Sparkline(
//                     data: prov.humidity,
//                     lineColor: Colors.redAccent,
//                     fillColor: Colors.lightGreen[200],
//                     pointsMode: PointsMode.all,
//                     // pointSize: 8.0,
//                   ),
//                 ),
//               ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Card(
//             elevation: 20,
//             child:
//                 // LineChartPage(),

//                 Sparkline(
//               data: prov.temperature.sublist(
//                   prov.temperature.length - 20, prov.temperature.length),
//               // data: prov.temperature,
//               lineColor: Colors.yellow,
//               fillColor: Colors.lightGreen[200],
//               pointsMode: PointsMode.all,
//               // pointSize: 8.0,
//             ),
//           ),
//         ),

//         Card(
//           elevation: 20,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Sparkline(
//               // data: prov.temperature.sublist(prov.soilTemperature.length - 120,
//               // prov.soilTemperature.length),
//               data: prov.soilMoisture,
//               lineColor: Colors.blueAccent,
//               fillColor: Colors.blueAccent,
//               pointsMode: PointsMode.all,
//               // pointSize: 8.0,
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
