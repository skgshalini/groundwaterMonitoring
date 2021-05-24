import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'DataInsert.dart';

final _firestore = Firestore.instance;
Map<int,String> mon={1:'JAN',2:'FEB',3:'MAR',4:'APR',5:'MAY',6:'JUN',
  7:'JUL',8:'AUG',9:'SEP',10:'OCT',11:'NOV',12:'DEC'};
var format;
class MyList {
List<double> depth= [];
List<String> month=[];
List<String> timestamp=[];
Future getData(String well_id) async{
  final data =await _firestore.collection('data').where('well_no', isEqualTo: '$well_id').orderBy('timestamp').getDocuments();
  for(var data in data.documents){
    depth.add(double.parse((data.data['depth']).toString()));
    format = new DateFormat('dd-MM-yyyy\nhh:mm a'); // 'hh:mm' for hour & min
    month.add(mon[data.data['timestamp'].toDate().month]);
     timestamp.add(format.format(data.data['timestamp'].toDate()));
  }
}
}
 String getPhone(){
  return loggedInUser.phoneNumber;
}