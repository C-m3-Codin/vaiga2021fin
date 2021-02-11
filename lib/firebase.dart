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
    readFromRTDB();
  });
}

String readFromRTDB() {
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  databaseReference.once().then((DataSnapshot datasnapshot) {
    print(datasnapshot.value['test string']);
    return datasnapshot.value['test string'];
  });
}

nodeToFirestore(Node node) {
  FirebaseFirestore.instance.collection('nodes').doc().set({
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
  FirebaseFirestore.instance.collection('crops').doc().set({
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

nodesFromFirestore() async {
  nodesList = [];
  await FirebaseFirestore.instance
      .collection('nodes')
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((nodeFromFirestore) {
      Node node = nodeFromQuerySnapshot(nodeFromFirestore);
      nodesList.add(node);
    });
  });
  print(nodesList.toString());
}

cropsFromFirestore() async {
  cropsList = [];
  await FirebaseFirestore.instance
      .collection('crops')
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((cropFromFirestore) {
      Crop crop = cropFromQuerySnapshot(cropFromFirestore);
      cropsList.add(crop);
    });
  });
}
