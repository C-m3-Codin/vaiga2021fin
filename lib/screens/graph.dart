import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:oscilloscope/oscilloscope.dart';
import 'dart:math';
import 'dart:async';

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
      tempList.add(dataHumidity);
      soilTempList.add(dataHumidity);
    });
  }

  @override
  initState() {
    super.initState();
    // create our timer to generate test values
    _timer = Timer.periodic(Duration(milliseconds: 30000), _generateTrace);
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
      yAxisMax: 60,
      yAxisMin: 30,
      dataSet: tempList,
    );

    Oscilloscope soilTempScope = Oscilloscope(
      showYAxis: false,
      yAxisColor: Colors.orange,
      padding: 20.0,
      backgroundColor: Colors.grey[300],
      traceColor: Colors.blueAccent,
      yAxisMax: 60,
      yAxisMin: 30,
      dataSet: soilTempList,
    );

    Oscilloscope humidityScope = Oscilloscope(
      showYAxis: false,
      yAxisColor: Colors.orange,
      padding: 20.0,
      backgroundColor: Colors.grey[300],
      traceColor: Colors.blueAccent,
      yAxisMax: 60,
      yAxisMin: 30,
      dataSet: humidityList,
    );

    // Generate the Scaffold
    return Scaffold(
      appBar: AppBar(
        title: Text("OscilloScope Demo"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 1, child: humidityScope),
          Expanded(flex: 1, child: tempScope),
          Expanded(flex: 1, child: soilTempScope),
        ],
      ),
    );
  }
}
