// Firebase initialization

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

Future initializeFirebaseApp(BuildContext context) async {
  await Firebase.initializeApp().then((_) {
    print('Firebase gets initialized');
    readFromRTDB();
  });
}

Future readFromRTDB() {
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  databaseReference.once().then((DataSnapshot datasnapshot) {
    print(datasnapshot.value['test string']);
  });
}
