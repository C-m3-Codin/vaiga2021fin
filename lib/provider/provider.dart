import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'userModel.dart';

class UserProvider with ChangeNotifier {
  List<Nodes> _node = [Nodes(temp: "", moisture: "asd")];
  int selectedUser = 0;
  final databaseRef = FirebaseDatabase.instance.reference();
  String humidity = "";
  String temperature = "";
  int temp, humid;
  double td, valu;

  Future<String> readDate() async {
    databaseRef.child("Humidity").once().then((DataSnapshot data) => {
          print("${data.value}"),
          humidity = data.value.toString(),
          humid = int.parse(humidity)
        });
    databaseRef.child("Temperature").once().then((DataSnapshot data) => {
          print("${data.value}"),
          temperature = data.value.toString(),
          temp = int.parse(temperature),
          td = temp - ((100 - humid) / 100),
          valu = 100 - (((temp - td) / temp) * 100)
        });
    var dat = await databaseRef.child("Humidity").once();
    var da = dat.value;

    notifyListeners();
    // return da.toString();
  }

  List<User> get getUser {
    return [..._users];
  }

  get getSelected {
    return selectedUser;
  }

  void addUser(User user) {
    _users.add(user);
    notifyListeners();
  }

  void changeName(User user, String newName) {
    user.name = newName;
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
