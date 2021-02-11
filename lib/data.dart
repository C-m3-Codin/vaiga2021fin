import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vaiga_farmcare/models/crop.dart';
import 'package:vaiga_farmcare/models/node.dart';

List<Crop> cropsList = [];
List<Node> nodesList = [];

Node nodeFromQuerySnapshot(QueryDocumentSnapshot nodeFromFirestore) {
  return Node(
      nodeCrop: nodeFromFirestore.data()['nodeCrop'],
      nodeHumidity: nodeFromFirestore.data()['nodeHumidity'],
      nodeLightInt: nodeFromFirestore.data()['nodeLightInt'],
      nodeName: nodeFromFirestore.data()['nodeName'],
      nodePosition: nodeFromFirestore.data()['nodePosition'],
      nodeRelativeHumidity: nodeFromFirestore.data()['nodeRelativeHumidity'],
      nodeSoilMoisture: nodeFromFirestore.data()['nodeSoilMoisture'],
      nodeSoilTemp: nodeFromFirestore.data()['nodeSoilTemp'],
      nodeTemp: nodeFromFirestore.data()['nodeTemp']);
}

Crop cropFromQuerySnapshot(QueryDocumentSnapshot cropFromFirestore) {
  return Crop(
    cropHumidity: cropFromFirestore.data()['cropHumidity'],
    cropLigtInt: cropFromFirestore.data()['cropLigtInt'],
    cropName: cropFromFirestore.data()['cropName'],
    cropRelativeHumidity: cropFromFirestore.data()['cropRelativeHumidity'],
    cropSoilMoisture: cropFromFirestore.data()['cropSoilMoisture'],
    cropSoilTemp: cropFromFirestore.data()['cropSoilTemp'],
    cropTemp: cropFromFirestore.data()['cropTemp'],
    cropType: cropFromFirestore.data()['cropType'],
  );
}
