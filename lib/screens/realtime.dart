import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:vaiga_farmcare/firebase.dart';
import 'package:vaiga_farmcare/models/crop.dart';
import 'package:vaiga_farmcare/models/node.dart';

class RealTime extends StatefulWidget {
  @override
  _RealTimeState createState() => _RealTimeState();
}

class _RealTimeState extends State<RealTime> {
  // var data;

  // getData() async {
  //   data = (await FirebaseDatabase.instance.reference().child("Atemp").once())
  //       .value
  //       .toString();
  // }

  @override
  void initState() {
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text(
              'yehao',
              style: TextStyle(fontSize: 24),
            ),
            RaisedButton(
              onPressed: () {
                nodeToFirestore(Node(
                    nodeName: 'N1',
                    nodePosition: 'GT1',
                    nodeCrop: 'Spinach',
                    nodeHumidity: '48',
                    nodeLightInt: '52',
                    nodeRelativeHumidity: '41',
                    nodeSoilMoisture: '65',
                    nodeSoilTemp: '84',
                    nodeTemp: '65'));

                nodeToFirestore(Node(
                    nodeName: 'N2',
                    nodePosition: 'GT1',
                    nodeCrop: 'Tomato',
                    nodeHumidity: '18',
                    nodeLightInt: '52',
                    nodeRelativeHumidity: '51',
                    nodeSoilMoisture: '61',
                    nodeSoilTemp: '74',
                    nodeTemp: '61'));
              },
              child: Text('Set Nodes'),
            ),
            RaisedButton(
              onPressed: nodesFromFirestore,
              child: Text('Fetch Nodes'),
            ),
            RaisedButton(
              onPressed: () {
                cropToFirestore(Crop(
                    cropHumidity: '65',
                    cropLigtInt: '65',
                    cropName: 'Spinach',
                    cropRelativeHumidity: '98',
                    cropSoilMoisture: '54',
                    cropSoilTemp: '48',
                    cropTemp: '45',
                    cropType: 'Leafy'));
                cropToFirestore(Crop(
                    cropHumidity: '45',
                    cropLigtInt: '65',
                    cropName: 'Tomato',
                    cropRelativeHumidity: '98',
                    cropSoilMoisture: '54',
                    cropSoilTemp: '48',
                    cropTemp: '45',
                    cropType: 'Vegetable'));
              },
              child: Text('Set Crops'),
            ),
            RaisedButton(
              onPressed: cropsFromFirestore,
              child: Text('Fetch Crops'),
            )
          ],
        ),
      ),
    );
  }
}
