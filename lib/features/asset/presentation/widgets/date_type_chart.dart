import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget buildChart(List assetList, DateTime maximum) {
  return SfCartesianChart(
    margin: const EdgeInsets.all(0),
    primaryXAxis: DateTimeAxis(
        dateFormat: DateFormat('dd MMM yy'),
        isVisible: true,
        majorGridLines: const MajorGridLines(color: Colors.white),
        visibleMaximum: maximum,
        maximum: maximum,
        maximumLabels: 20,
        labelRotation: -45,
        labelIntersectAction: AxisLabelIntersectAction.rotate45,
        intervalType: DateTimeIntervalType.days,
        desiredIntervals: 15),
    primaryYAxis: NumericAxis(
      isVisible: true,
      majorGridLines: const MajorGridLines(width: .2),
    ),
    series: <SplineAreaSeries>[
      SplineAreaSeries<Data, DateTime>(
          markerSettings: const MarkerSettings(isVisible: true),
          gradient: const LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: <Color>[Colors.blue, Colors.deepPurple],
          ),
          dataSource: getChartData(assetList),
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            showZeroValue: false,
          ),
          dataLabelMapper: (asset, _) => 'R\$ ${asset.y!.toStringAsFixed(2)}',
          xValueMapper: (asset, index) => asset.x,
          yValueMapper: (asset, index) => asset.y)
    ],
  );
}

List<Data> getChartData(List assetList) {
  return assetList.map<Data>((e) {
    return Data(x: e.date, y: e.value);
  }).toList();
}

class Data {
  final DateTime? x;
  final double? y;

  Data({this.x, this.y});
}
