import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class chart extends StatelessWidget {
  List<String> mon;
  List<String> timedate;
  List<double> dep;
  List<BarSeries> cs = [];
  List<Graphdata> g = [];
  chart(this.timedate, this.mon, this.dep);
  Widget build(BuildContext context) {
    // TODO: implement build
    return SfCartesianChart(
      plotAreaBackgroundColor: Colors.black,
      legend: Legend(isVisible: true),
      series: chartseries(mon, timedate, dep),
      primaryXAxis: CategoryAxis(isVisible: false),
      primaryYAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          numberFormat: NumberFormat.decimalPattern(),
          title: AxisTitle(
              text: 'Depth in meters of the well',
              textStyle: TextStyle(fontSize: 10))),
      isTransposed: true,
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  BarSeries<Graphdata, String> bar({String name, List<Graphdata> dataSource}) {
    return BarSeries<Graphdata, String>(
        name: name,
        dataSource: dataSource,
        xValueMapper: (Graphdata gd, _) => gd.timestamp,
        yValueMapper: (Graphdata gd, _) => gd.depth,
        dataLabelSettings: DataLabelSettings(isVisible: true),
        enableTooltip: true,
        legendIconType: LegendIconType.rectangle);
  }

  List<ChartSeries> chartseries(
      List<String> mon, List<String> timedate, List<double> dep) {
    if (mon.length != 0) {
      String c = mon.elementAt(0);
      int i = 0;
      for (String v in mon) {
        if (v.compareTo(c) != 0) {
          cs.add(bar(name: mon[i - 1], dataSource: g));
          g = [];
          g.add(Graphdata(dep[i], timedate[i]));
          i++;
          c = mon[i - 1];
        } else {
          g.add(Graphdata(dep[i], timedate[i]));
          i++;
        }
      }
      cs.add(bar(name: mon[i - 1], dataSource: g));
    }
    return cs;
  }
}

class Graphdata {
  Graphdata(this.depth, this.timestamp);
  final String timestamp;
  final double depth;
}
