import 'package:collection/collection.dart';
import 'package:eggnstone_charts/eggnstone_charts.dart';
import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(path: 'Errors', name: 'No data', type: DoubleLineChart)
Widget buildDoubleChartNoData(BuildContext context)
=> _buildChart(_createNoData(context));

@UseCase(path: 'Errors', name: 'Mismatch of lines and colors', type: DoubleLineChart)
Widget buildDoubleChartMismatchOfLinesAndColors(BuildContext context)
=> _buildChart(_createMismatchOfLinesAndColors(context));

@UseCase(path: '', name: '2 dots', type: DoubleLineChart)
Widget buildDoubleChartTwoDots(BuildContext context)
=> _buildChart(_createTwoDots(context));

@UseCase(path: '', name: '1 dot', type: DoubleLineChart)
Widget buildDoubleChartOneDot(BuildContext context)
=> _buildChart(_createOneDot(context));

@UseCase(path: '', name: '2 lines', type: DoubleLineChart)
Widget buildDoubleChartTwoLines(BuildContext context)
=> _buildChart(_createTwoLines(context));

@UseCase(path: '', name: '2 lines, 2 dots', type: DoubleLineChart)
Widget buildDoubleChartTwoLinesTwoDots(BuildContext context)
=> _buildChart(_createTwoLinesTwoDots(context));

@UseCase(path: '', name: '1 line', type: DoubleLineChart)
Widget buildDoubleChartOneLine(BuildContext context)
=> _buildChart(_createOneLine(context));

@UseCase(path: '', name: '1 line, inverted', type: DoubleLineChart)
Widget buildDoubleChartOneLineInverted(BuildContext context)
=> _buildChart(_createOneLine(context, invert: true));

@UseCase(path: '', name: '1 line, 1 dot', type: DoubleLineChart)
Widget buildDoubleChartOneLineOneDot(BuildContext context)
=> _buildChart(_createOneLineOneDot(context));

DoubleChartData _createNoData(BuildContext context)
=> _createDoubleChartData(context, <Color>[], <List<DoublePoint>>[]);

DoubleChartData _createMismatchOfLinesAndColors(BuildContext context)
=> _createDoubleChartData(
    context,
    <Color>[Colors.red, Colors.green],
    <List<DoublePoint>>[_createLine1()]
);

DoubleChartData _createTwoDots(BuildContext context)
=> _createDoubleChartData(
    context,
    <Color>[Colors.red, Colors.green],
    <List<DoublePoint>>[_createDot1(), _createDot2()]
);

DoubleChartData _createOneDot(BuildContext context)
=> _createDoubleChartData(
    context,
    <Color>[Colors.red],
    <List<DoublePoint>>[_createDot1()]
);

DoubleChartData _createTwoLines(BuildContext context)
=> _createDoubleChartData(
    context,
    <Color>[Colors.red, Colors.green],
    <List<DoublePoint>>[_createLine1(), _createLine2()]
);

DoubleChartData _createTwoLinesTwoDots(BuildContext context)
=> _createDoubleChartData(
    context,
    <Color>[Colors.red, Colors.green, Colors.blue, Colors.orange],
    <List<DoublePoint>>[_createLine1(), _createLine2(), _createDot1(), _createDot2()]
);

DoubleChartData _createOneLineOneDot(BuildContext context)
=> _createDoubleChartData(
    context,
    <Color>[Colors.red, Colors.green],
    <List<DoublePoint>>[_createLine1(), _createDot1()]
);

DoubleChartData _createOneLine(BuildContext context, {bool invert = false})
=> _createDoubleChartData(
    context,
    <Color>[Colors.red],
    <List<DoublePoint>>[_createLine1()],
    invert: invert
);

List<DoublePoint> _createLine1()
=> <DoublePoint>
[
    const DoublePoint(1, 0),
    const DoublePoint(2, 1),
    const DoublePoint(3, 2),
    const DoublePoint(4, 3),
    const DoublePoint(5, 4),
    const DoublePoint(6, 3),
    const DoublePoint(7, 1),
    const DoublePoint(8, 7)
];

List<DoublePoint> _createLine2()
=> <DoublePoint>
[
    const DoublePoint(2, 8),
    const DoublePoint(8, 4)
];

List<DoublePoint> _createDot1()
=> <DoublePoint>
[
    const DoublePoint(5, 5)
];

List<DoublePoint> _createDot2()
=> <DoublePoint>
[
    const DoublePoint(6, 6)
];

Widget _buildChart(DoubleChartData data)
{
    const ChartInfo info = ChartInfo(
        title: 'Test'
    );

    const ChartStyle style = ChartStyle(
        devicePixelRatio: 1,
        fontSize: 12,
        pointRadius: 4
    );

    return DoubleLineChart(
        data: data,
        info: info,
        chartStyle: style
    );
}

DoubleChartData _createDoubleChartData(BuildContext context, List<Color> colors, List<List<DoublePoint>> doubleLines, {bool invert = false})
{
    final List<DoubleLineData> convertedDoubleLines = doubleLines
        .mapIndexed((int index, List<DoublePoint> points) => DoubleLineData('Data Series #${index + 1}', points.map((DoublePoint dp) => invert ? DoublePoint(dp.x, -dp.y) : dp).toImmutableList()))
        .toList();

    final double rangeX = context.knobs.int.slider(label: 'Range X', initialValue: 10, min: 10, max: 100, divisions: 3).toDouble();
    final double rangeY = context.knobs.int.slider(label: 'Range Y', initialValue: 10, min: 10, max: 100, divisions: 3).toDouble();
    return DoubleChartData(
        colors: colors.toImmutableList(),
        lines: convertedDoubleLines.toImmutableList(),
        toolsX: DoubleTools(const DoubleFormatter(0)),
        toolsY: DoubleTools(DoubleFormatter(0, invert: invert)),
        minMax: DoubleMinMax(
            minX: 0,
            maxX: rangeX,
            minY: invert ? -rangeY : 0,
            maxY: invert ? 0 : rangeY
        )
    );
}
