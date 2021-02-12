import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class GraphMode with ChangeNotifier {
  List<double> humidity = [];
  List<double> temperature = [];
  List<double> soilTemperature = [];
  List<double> soilMoisture = [];
  Future<void> showTemperature() async {
    print("Entered");
    // making this both a Future and async method
    final databaseRefenceshumid = await FirebaseDatabase.instance
        .reference()
        .child("Node1")
        .child("Ahumid");

    final databaseRefencesTemp = await FirebaseDatabase.instance
        .reference()
        .child("Node1")
        .child("Atemp");
    final databaseRefencesSoilTemp = await FirebaseDatabase.instance
        .reference()
        .child("Node1")
        .child("Stemp");

    // databaseRefences.once()

    databaseRefenceshumid.once().then((snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        print(values);
        humidity.add(values.toDouble());
        // omitting "[keys]" from the OPs approach
      });
    });

    databaseRefencesTemp.once().then((snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        print(values);
        // humidity.add(values);
        temperature.add(values.toDouble());
        // omitting "[keys]" from the OPs approach
      });
    });

    databaseRefencesSoilTemp.once().then((snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        print(values);
        soilTemperature.add(values.toDouble());
        // omitting "[keys]" from the OPs approach
      });
    });
    notifyListeners();
  }
}
