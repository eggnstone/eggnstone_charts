import 'package:collection/collection.dart';
import 'package:eggnstone_charts/eggnstone_charts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kt_dart/collection.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

// UseCases

@UseCase(path: '', name: 'Normal', type: DateTimeLineChart)
Widget buildDateTimeChart(BuildContext context)
=> _buildChart('Normal', _createSampleData(context));

@UseCase(path: '', name: 'Inverted', type: DateTimeLineChart)
Widget buildDateTimeChartInverted(BuildContext context)
=> _buildChart('Inverted', _createSampleData(context, invert: true));

@UseCase(path: '', name: 'Doc 1', type: DateTimeLineChart)
Widget buildDateTimeChartDocOne(BuildContext context)
=> Center(
    child: SizedBox(
        width: 200,
        height: 300,
        child: _buildChart(
            'DateTime Sample',
            _createDocOneData(context)
        )
    )
);

// Data

DateTimeChartData _createSampleData(BuildContext context, {bool invert = false})
{
    final DateTime now = DateTime.now();
    return _createDateTimeChartData(
        context,
        referenceDateTime: now,
        colors: <Color>[Colors.red],
        lines: <List<DateTimePoint>>[_createLine1(now)],
        invert: invert,
        minX: -8,
        rangeInitialValueX: 2,
        rangeMinX: 2,
        rangeMaxX: 102,
        rangeStepsX: 2
    );
}

DateTimeChartData _createDocOneData(BuildContext context)
{
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    return _createDateTimeChartData(
        context,
        referenceDateTime: today,
        colors: <Color>[Colors.green],
        lines: <List<DateTimePoint>>[_createDocOneLine(today)],
        rangeInitialValueX: 1,
        rangeInitialValueY: 7,
        minX: -8,
        rangeMinX: 1,
        rangeMaxX: 101,
        rangeMinY: 2,
        rangeMaxY: 11,
        rangeStepsX: 2,
        rangeStepsY: 2
    );
}

// Raw data

List<DateTimePoint> _createLine1(DateTime referenceDateTime)
=> <DateTimePoint>
[
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 7)), 0),
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 6)), 1),
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 5)), 2),
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 4)), 3),
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 3)), 4),
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 2)), 3),
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 1)), 1),
    DateTimePoint(referenceDateTime, 7)
];

List<DateTimePoint> _createDocOneLine(DateTime referenceDateTime)
=> <DateTimePoint>
[
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 7)), 1),
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 6)), 2),
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 5)), 3),
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 4)), 2),
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 3)), 3),
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 2)), 4),
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 1)), 5),
    DateTimePoint(referenceDateTime, 6)
];

DateTimeChartData _createDateTimeChartData(
    BuildContext context, {
        required DateTime referenceDateTime,
        required List<Color> colors,
        required List<List<DateTimePoint>> lines,
        int minX = -10,
        double minY = 0,
        int rangeMinX = -5,
        int rangeMaxX = 5,
        int rangeMinY = 10,
        int rangeMaxY = 100,
        int rangeStepsX = 3,
        int rangeStepsY = 3,
        int rangeInitialValueX = 0,
        int rangeInitialValueY = 10,
        bool invert = false
    }
)
{
    final List<DateTimeLineData> convertedDateTimeLines = lines
        .mapIndexed((int index, List<DateTimePoint> points) => DateTimeLineData('Data Series #${index + 1}', points.map((DateTimePoint dp) => invert ? DateTimePoint(dp.x, -dp.y) : dp).toImmutableList()))
        .toList();

    final int rangeX = context.knobs.int.slider(label: 'Range X', initialValue: rangeInitialValueX, min: rangeMinX, max: rangeMaxX, divisions: rangeStepsX);
    final double rangeY = context.knobs.int.slider(label: 'Range Y', initialValue: rangeInitialValueY, min: rangeMinY, max: rangeMaxY, divisions: rangeStepsY).toDouble();
    return DateTimeChartData(
        colors: colors.toImmutableList(),
        lines: convertedDateTimeLines.toImmutableList(),
        toolsX: DateTimeTools(DateTimeFormatter(DateFormat('dd.\nMM.\nyyyy'))),
        toolsY: DoubleTools(DoubleFormatter(0, invert: invert)),
        minMax: DateTimeMinMax(
            minX: referenceDateTime.add(Duration(days: minX)),
            maxX: referenceDateTime.add(Duration(days: rangeX)),
            minY: invert ? -rangeY : minY,
            maxY: invert ? minY : rangeY
        )
    );
}

//

Widget _buildChart(String title, DateTimeChartData data)
{
    final ChartInfo info = ChartInfo(
        title: title
    );

    const ChartStyle style = ChartStyle(
        devicePixelRatio: 1,
        fontSize: 12,
        pointRadius: 4
    );

    return DateTimeLineChart(data: data, info: info, style: style);
}
