import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:groundwater_monitoring/components/RoundedButton.dart';
import 'package:groundwater_monitoring/constants.dart';
import 'package:groundwater_monitoring/datacontroller/DataInsert.dart';
import 'package:groundwater_monitoring/datacontroller/data.dart';


final nameHolder = TextEditingController();
clearTextInput() {
  nameHolder.clear();
}

class dataInputScreen extends StatefulWidget {
  static String id = 'data_input_screen';

  @override
  _dataInputScreenState createState() => _dataInputScreenState();
}

class _dataInputScreenState extends State<dataInputScreen> {
  String well_id;
  double depth;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }
  @override
  Widget build(BuildContext context) {
    return
        //Scaffold(
        // appBar: AppBar(
        // title: Text("Data Input"),
        // backgroundColor: Colors.blueAccent,
        //  ),
        // backgroundColor: Colors.white,
        Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DropdownSearch<String>(
              mode: Mode.MENU,
              showSelectedItem: true,
              items: kWells,
              onChanged: (value) {
                well_id = value;
              },
              selectedItem: "Well_1"),
          SizedBox(
            height: 28.0,
          ),
          TextField(
              onChanged: (value) {
                //Do something with the user input.
                depth = double.parse(value);
              },
              controller: nameHolder,
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter Depth')),
          SizedBox(
            height: 12.0,
          ),
          RoundedButton(
              onPressed: () async {
                final DateTime datetime = DateTime.now();
                Timestamp timestamp = Timestamp.fromDate(datetime);
                addData(phone:loggedInUser.phoneNumber,timestamp:timestamp, depth:depth,well_id:well_id,context:context);
              },
              colour: Colors.black,
              title: 'Save'),
        ],
      ),
    );
    //  );
  }
}
