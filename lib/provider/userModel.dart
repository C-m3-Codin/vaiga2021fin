// user Model of the
// import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';

class User {
  String name;
  String userID;
  // String sem;
  User({@required this.name, @required this.userID});
}

class Nodes {
  String temp;
  String moisture;
  String soilTemp;
  String light;

  // V({this.id, this.price, this.name,this.img});
  Nodes({this.light, this.moisture, this.soilTemp, this.temp});

  // Values.fromMap(Map snapshot, String id)
  //     : temp = id ?? '',
  //       moisture = snapshot['price'] ?? '',
  //       soilTemp = snapshot['name'] ?? '',
  //       light = snapshot['img'] ?? '';

  // toJson() {
  //   return {
  //     "temo": temp,
  //     "soilTemp": soilTemp,
  //     "light": light,
  //   };
  // }
}
