import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:vaiga_farmcare/models/crop.dart';
import 'package:vaiga_farmcare/models/node.dart';
// import 'userModel.dart';

class UserProvider with ChangeNotifier {
  List<Node> _node = [
    Node(
        nodeName: "Node1",
        nodePosition: "Row1",
        nodeTemp: "12",
        nodeHumidity: "32",
        nodeSoilMoisture: "12",
        nodeSoilTemp: "13",
        nodeLightInt: "54",
        nodeRelativeHumidity: "25",
        // crop: Crop(
        //   cropHumidity: "26",
        //   cropLigtInt: "45",
        //   cropName: "58",
        //   cropSoilMoisture: "45",
        //   cropSoilTemp: "89",
        //   cropTemp: "82",
        //   cropType: "agri",
        //   cropRelativeHumidity: "82",
        // ),
        nodeCrop: "")
  ];
  int selectedUser = 0;
  final databaseRef = FirebaseDatabase.instance.reference();
  String humidity = "";
  String temperature = "";
  String soilMoisture = "";
  int temp, humid;
  double td, valu;
  int noOFNodes;
  String no;

  // var strmValues = databaseRef.child("Node").once()

  Future<String> readDate() async {
    databaseRef.child("numbOfNodes").once().then((DataSnapshot data) => {
          print("${data.value}"),
          no = data.value.toString(),
          noOFNodes = int.parse(temperature),
        });
    databaseRef
        .child("Node1")
        .child("AhumidNow")
        .once()
        .then((DataSnapshot data) {
      print("${data.value}");
      humidity = data.value.toString();
      print("here lies your shit \n\n\n\n $humidity");
      humid = int.parse(humidity);
    });
    databaseRef.child("Atemp").once().then((DataSnapshot data) => {
          print("${data.value}"),
          temperature = data.value.toString(),
          temp = int.parse(temperature),
          td = temp - ((100 - humid) / 100),
          valu = 100 - (((temp - td) / temp) * 100)
        });

    databaseRef.child("Stemp").once().then((DataSnapshot data) => {
          print("${data.value}"),
          soilMoisture = data.value.toString(),
          temp = int.parse(temperature),
          td = temp - ((100 - humid) / 100),
          valu = 100 - (((temp - td) / temp) * 100)
        });
    var dat = await databaseRef.child("Humidity").once();
    var da = dat.value;

    // get List of Nodes

    // update each crop

    notifyListeners();
    // return da.toString();
  }

  // Stream<DataSnapshot> get realData {
  //   return databaseRef.child('Node1').once().asStream();
  // }

  List<Node> get getUser {
    return [..._node];
  }

  get getSelected {
    return selectedUser;
  }

  void addNode(Node node) {
    // _users.add(user);
    notifyListeners();
  }

  void changeName(Node node, String newName) {
    node.nodeName = newName;
    notifyListeners();
  }

  void updateSelectedUser(int n) {
    selectedUser = n;
    notifyListeners();
  }

  Future readFromRTDBTemperature() {
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
    databaseReference.once().then((DataSnapshot datasnapshot) {
      print(datasnapshot.value['Temperature']);
      return datasnapshot.value['Temperature'].toString();
    });
  }
}
