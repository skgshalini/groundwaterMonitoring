import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groundwater_monitoring/components/customdialog.dart';
import 'package:groundwater_monitoring/screens/data_input_screen.dart';
final _auth = FirebaseAuth.instance;
final _firestore = Firestore.instance;

FirebaseUser loggedInUser;
void getCurrentUser() async {
  try {
    final user = await _auth.currentUser();
    if (user != null) {
      loggedInUser = user;
    }
  } catch (e) {
    print(e);
  }
}
addData({phone:String,timestamp:Timestamp,depth:double,well_id:String,context:BuildContext}) async {
  await _firestore.collection('data').add({
    'phone': phone,
    'timestamp': timestamp,
    'depth': depth,
    'well_no': well_id
  }).then((result) {
    nameHolder.clear();
    print("Success!");
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: "Success",
        description: "Data uploaded successfully!",
        buttonText: "Okay",
      ),
    );
  }).catchError((error) {
    print("Error!");
  });
}