import 'package:eggnstone_charts/eggnstone_charts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kt_dart/collection.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook_annotation;

@widgetbook_annotation.UseCase(path: '', name: 'Normal', type: DateTimeLineChart)
Widget buildDateTimeChart(BuildContext context)
=> buildChart();

@widgetbook_annotation.UseCase(path: '', name: 'Inverted', type: DateTimeLineChart)
Widget buildDateTimeChartInverted(BuildContext context)
=> buildChart(invert: true);

Widget buildChart({bool invert = false})
{
    final List<Color> colors = <Color>[Colors.red];
    final List<DateTimeLineData> dateTimeLines = <DateTimeLineData>
    [
        DateTimeLineData(
            <DateTimePoint>
            [
                DateTimePoint(DateTime.now().subtract(const Duration(days: 7)), 0),
                DateTimePoint(DateTime.now().subtract(const Duration(days: 6)), invert ? -1 : 1),
                DateTimePoint(DateTime.now().subtract(const Duration(days: 5)), invert ? -2 : 2),
                DateTimePoint(DateTime.now().subtract(const Duration(days: 4)), invert ? -3 : 3),
                DateTimePoint(DateTime.now().subtract(const Duration(days: 3)), invert ? -4 : 4),
                DateTimePoint(DateTime.now().subtract(const Duration(days: 2)), invert ? -3 : 3),
                DateTimePoint(DateTime.now().subtract(const Duration(days: 1)), invert ? -1 : 1),
                DateTimePoint(DateTime.now(), invert ? -7 : 7)
            ].toImmutableList()
        )
    ];

    final DateTimeChartData data =
        DateTimeChartData(
            colors: colors.toImmutableList(),
            lines: dateTimeLines.toImmutableList(),
            toolsX: DateTimeTools(DateTimeFormatter(DateFormat('dd.\nMM.\nyyyy'))),
            toolsY: DoubleTools(DoubleFormatter(0, invert: invert)),
            minMax: DateTimeMinMax(
                minX: DateTime.now().subtract(const Duration(days: 8)),
                maxX: DateTime.now().add(const Duration(days: 2)),
                minY: invert ? -10 : 0,
                maxY: invert ? 0 : 10
            )
        );

    const ChartInfo info = ChartInfo(
        title: 'Test'
    );

    const ChartStyle style = ChartStyle(
        devicePixelRatio: 1,
        fontSize: 12,
        pointRadius: 4
    );

    return DateTimeLineChart(
        data: data,
        info: info,
        style: style
    );
}
