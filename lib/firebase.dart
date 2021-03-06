import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vaiga_farmcare/data.dart';
import 'package:vaiga_farmcare/models/crop.dart';
import 'package:vaiga_farmcare/models/node.dart';

Future initializeFirebaseApp(BuildContext context) async {
  await Firebase.initializeApp().then((_) {
    print('Firebase gets initialized');
    cropsFromFirestore().then((_) => nodesFromFirestore());

    readFromRTDB();
  });
}

readFromRTDB() {
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child('Node1/AhumidNow');
  databaseReference.once().then((DataSnapshot datasnapshot) {
    print(datasnapshot.value);
    return datasnapshot.value;
  });
}

class DatabaseServices {
  final databaseRef = FirebaseDatabase.instance.reference();

  Stream<DataSnapshot> get realData {
    return databaseRef.child('Node1').once().asStream();
  }
}

nodeToFirestore(Node node) {
  FirebaseFirestore.instance.collection('nodes').doc(node.nodeName).set({
    'nodeName': node.nodeName,
    'nodePosition': node.nodePosition,
    'nodeHumidity': node.nodeHumidity,
    'nodeSoilMoisture': node.nodeSoilMoisture,
    'nodeSoilTemp': node.nodeSoilTemp,
    'nodeTemp': node.nodeTemp,
    'nodeLightInt': node.nodeLightInt,
    'nodeRelativeHumidity': node.nodeRelativeHumidity,
    'nodeCrop': node.nodeCrop,
  });
}

cropToFirestore(Crop crop) {
  FirebaseFirestore.instance.collection('crops').doc(crop.cropName).set({
    'cropName': crop.cropName,
    'cropHumidity': crop.cropHumidity,
    'cropLigtInt': crop.cropLigtInt,
    'cropSoilMoisture': crop.cropSoilMoisture,
    'cropSoilTemp': crop.cropSoilTemp,
    'cropTemp': crop.cropTemp,
    'cropType': crop.cropType,
    'cropRelativeHumidity': crop.cropRelativeHumidity,
  });
}

Future nodesFromFirestore() async {
  nodesList = [];
  await FirebaseFirestore.instance
      .collection('nodes')
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((nodeFromFirestore) {
      Node node = nodeFromQuerySnapshot(nodeFromFirestore);
      print(node.nodeLightInt);
      nodesList.add(node);
    });
  });
  print(nodesList.toString());
}

Future cropsFromFirestore() async {
  cropsList = [];
  await FirebaseFirestore.instance
      .collection('crops')
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((cropFromFirestore) {
      Crop crop = cropFromQuerySnapshot(cropFromFirestore);
      print(crop.cropLigtInt);

      cropsList.add(crop);
    });
  });
  print(cropsList.toString());
}

readFromRTDBTemperature() {
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  databaseReference.once().then((DataSnapshot datasnapshot) {
    print(datasnapshot.value['test string']);
    return datasnapshot.value['test string'];
  });
}
