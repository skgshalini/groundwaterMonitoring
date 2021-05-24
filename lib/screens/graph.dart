import 'package:flutter/material.dart';
import 'package:groundwater_monitoring/components/chart.dart';
import 'package:groundwater_monitoring/datacontroller//data.dart';
import 'package:groundwater_monitoring/datacontroller/datafetch.dart';

import 'package:intl/intl.dart';
import 'package:dropdown_search/dropdown_search.dart';


fetchdata()async{

}
class Graph extends StatefulWidget {

  @override
  _Graph createState() => _Graph();
}

class _Graph extends State<Graph> {

  MyList m;
  List<String> mon=[];
  List<String> timedate=[];
  List<double> dep=[];
  String well_id='';
  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 1, 15, 8),
            child: DropdownSearch<String>(
                mode: Mode.MENU,
                showSelectedItem: true,
                items: kWells,
                onChanged: (value) async{
                  m = MyList();
                  well_id=value;
                  await m.getData(well_id);
                  setState(() {
                    mon = m.month;
                    timedate = m.timestamp;
                    dep = m.depth;
                  });


                  },
                selectedItem: "Select a well"),
          ),
          Expanded(
              child:chart(timedate,mon,dep)
          ),
        ],
      );
  }}

