import 'package:vaiga_farmcare/data.dart';
import 'package:vaiga_farmcare/models/crop.dart';

class Node {
  String nodeName;
  String nodePosition;
  String nodeTemp;
  String nodeHumidity;
  String nodeSoilMoisture;
  String nodeSoilTemp;
  String nodeLightInt;
  String nodeRelativeHumidity;
  Crop crop;
  String nodeCrop;

  Node({
    this.nodeName,
    this.nodePosition,
    this.nodeHumidity,
    this.nodeSoilMoisture,
    this.nodeSoilTemp,
    this.nodeTemp,
    this.nodeLightInt,
    this.nodeRelativeHumidity,
    this.nodeCrop,
  }) {
    cropsList.forEach((element) {
      if (element.cropName == nodeCrop) crop = element;
    });
  }
}
