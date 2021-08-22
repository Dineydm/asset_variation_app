import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '/features/asset/models/asset.dart';
import '/features/asset/presentation/widgets/date_type_chart.dart';

class LineChartPage extends StatefulWidget {
  final List<Asset> assetList;
  const LineChartPage(this.assetList);

  @override
  _LineChartPage createState() => _LineChartPage();
}

class _LineChartPage extends State<LineChartPage> {
  DateTime? _endDate;
  SfRangeValues? _values;
  Map<int, String> mapKm = {};

  bool showAvg = false;
  String? _startDate;
  List<Asset>? _assetList;

  @override
  void initState() {
    _assetList = widget.assetList;
    _getDateInterval();
    super.initState();
  }

  void _getDateInterval() {
    _startDate = _assetList![0].date.toString();
    _endDate = _assetList![_assetList!.length - 1].date;
    _values = SfRangeValues(DateTime.parse(_startDate!), _endDate);
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: RotatedBox(
            quarterTurns: 1,
            child: Container(
              padding: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
              width: MediaQuery.of(context).size.height * .83,
              height: MediaQuery.of(context).size.width * .85,
              child: SfRangeSelector(
                child: buildChart(_assetList!, _endDate!),
                initialValues: _values,
                min: DateTime.parse(_startDate!),
                max: _endDate,
                labelPlacement: LabelPlacement.betweenTicks,
                dateIntervalType: DateIntervalType.days,
                trackShape: _SfTrackShape(),
                tooltipShape: const SfPaddleTooltipShape(),
                enableTooltip: false,
                onChanged: (newValues) {
                  print(newValues);
                },
              ),
            )),
      ),
    );
  }
}

class _SfTrackShape extends SfTrackShape {
  Rect getPreferredRect(
      RenderBox parentBox, SfSliderThemeData themeData, Offset offset,
      {bool? isActive}) {
    return const Rect.fromLTRB(-50, 0, -50, 0);
  }
}

List<DateTime> getDateIntervalWeeks(DateTime start) {
  var currentDate = start;
  final weeksDay = <DateTime>[];
  for (var i = 0; i < 30; i++) {
    weeksDay.add(currentDate);
    currentDate = currentDate.add(const Duration(days: 1));
  }
  return weeksDay;
}
