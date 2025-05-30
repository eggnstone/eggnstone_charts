import 'package:collection/collection.dart';
import 'package:eggnstone_charts/eggnstone_charts.dart';
import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

// UseCases

@UseCase(path: 'Errors', name: 'No data', type: DoubleLineChart)
Widget buildDoubleChartNoData(BuildContext context)
=> _buildChart('No Data', _createNoData(context));

@UseCase(path: 'Errors', name: 'Mismatch of lines and colors', type: DoubleLineChart)
Widget buildDoubleChartMismatchOfLinesAndColors(BuildContext context)
=> _buildChart('Mismatch of lines and colors', _createMismatchOfLinesAndColorsData(context));

@UseCase(path: '', name: '2 dots', type: DoubleLineChart)
Widget buildDoubleChartTwoDots(BuildContext context)
=> _buildChart('2 dots', _createTwoDotsData(context));

@UseCase(path: '', name: '1 dot', type: DoubleLineChart)
Widget buildDoubleChartOneDot(BuildContext context)
=> _buildChart('1 dot', _createOneDotData(context));

@UseCase(path: '', name: '2 lines', type: DoubleLineChart)
Widget buildDoubleChartTwoLines(BuildContext context)
=> _buildChart('2 lines', _createTwoLinesData(context));

@UseCase(path: '', name: '2 lines, 2 dots', type: DoubleLineChart)
Widget buildDoubleChartTwoLinesTwoDots(BuildContext context)
=> _buildChart('2 lines, 2 dots', _createTwoLinesTwoDotsData(context));

@UseCase(path: '', name: '1 line', type: DoubleLineChart)
Widget buildDoubleChartOneLine(BuildContext context)
=> _buildChart('1 line', _createOneLineData(context));

@UseCase(path: '', name: '1 line, inverted', type: DoubleLineChart)
Widget buildDoubleChartOneLineInverted(BuildContext context)
=> _buildChart('1 line, inverted', _createOneLineData(context, invert: true));

@UseCase(path: '', name: '1 line, 1 dot', type: DoubleLineChart)
Widget buildDoubleChartOneLineOneDot(BuildContext context)
=> _buildChart('1 line, 1 dot', _createOneLineOneDotData(context));

@UseCase(path: '', name: 'Doc 1', type: DoubleLineChart)
Widget buildDoubleChartDocOne(BuildContext context)
=> Center(
    child: SizedBox(
        width: 200,
        height: 200,
        child: _buildChart(
            'Double Sample',
            _createDocOneData(context)
        )
    )
);

// Data

DoubleChartData _createNoData(BuildContext context)
=> _createDoubleChartData(context, colors: <Color>[], lines: <List<DoublePoint>>[]);

DoubleChartData _createMismatchOfLinesAndColorsData(BuildContext context)
=> _createDoubleChartData(
    context,
    colors: <Color>[Colors.red, Colors.green],
    lines: <List<DoublePoint>>[_createLine1()]
);

DoubleChartData _createTwoDotsData(BuildContext context)
=> _createDoubleChartData(
    context,
    colors: <Color>[Colors.red, Colors.green],
    lines: <List<DoublePoint>>[_createDot1(), _createDot2()]
);

DoubleChartData _createDocOneData(BuildContext context)
=> _createDoubleChartData(
    context,
    colors: <Color>[Colors.green],
    lines: <List<DoublePoint>>[_createDocOneLine()],
    rangeInitialValueX: 9,
    rangeInitialValueY: 7,
    rangeMinX: 4,
    rangeMaxX: 14,
    rangeMinY: 2,
    rangeMaxY: 11,
    rangeStepsX: 2,
    rangeStepsY: 2
);

DoubleChartData _createOneDotData(BuildContext context)
=> _createDoubleChartData(
    context,
    colors: <Color>[Colors.red],
    lines: <List<DoublePoint>>[_createDot1()]
);

DoubleChartData _createTwoLinesData(BuildContext context)
=> _createDoubleChartData(
    context,
    colors: <Color>[Colors.red, Colors.green],
    lines: <List<DoublePoint>>[_createLine1(), _createLine2()]
);

DoubleChartData _createTwoLinesTwoDotsData(BuildContext context)
=> _createDoubleChartData(
    context,
    colors: <Color>[Colors.red, Colors.green, Colors.blue, Colors.orange],
    lines: <List<DoublePoint>>[_createLine1(), _createLine2(), _createDot1(), _createDot2()]
);

DoubleChartData _createOneLineOneDotData(BuildContext context)
=> _createDoubleChartData(
    context,
    colors: <Color>[Colors.red, Colors.green],
    lines: <List<DoublePoint>>[_createLine1(), _createDot1()]
);

DoubleChartData _createOneLineData(BuildContext context, {bool invert = false})
=> _createDoubleChartData(
    context,
    colors: <Color>[Colors.red],
    lines: <List<DoublePoint>>[_createLine1()],
    invert: invert
);

// Raw data

List<DoublePoint> _createDocOneLine()
=> <DoublePoint>
[
    const DoublePoint(1, 1),
    const DoublePoint(2, 2),
    const DoublePoint(3, 3),
    const DoublePoint(4, 2),
    const DoublePoint(5, 3),
    const DoublePoint(6, 4),
    const DoublePoint(7, 5),
    const DoublePoint(8, 6)
];

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

//

DoubleChartData _createDoubleChartData(
    BuildContext context, {
        required List<Color> colors,
        required List<List<DoublePoint>> lines,
        double minX = 0,
        double minY = 0,
        int rangeMinX = 10,
        int rangeMaxX = 100,
        int rangeMinY = 10,
        int rangeMaxY = 100,
        int rangeStepsX = 3,
        int rangeStepsY = 3,
        int rangeInitialValueX = 10,
        int rangeInitialValueY = 10,
        bool invert = false
    }
)
{
    final List<DoubleLineData> convertedDoubleLines = lines
        .mapIndexed((int index, List<DoublePoint> points) => DoubleLineData('Data Series #${index + 1}', points.map((DoublePoint dp) => invert ? DoublePoint(dp.x, -dp.y) : dp).toImmutableList()))
        .toList();

    final double rangeX = context.knobs.int.slider(label: 'Range X', initialValue: rangeInitialValueX, min: rangeMinX, max: rangeMaxX, divisions: rangeStepsX).toDouble();
    final double rangeY = context.knobs.int.slider(label: 'Range Y', initialValue: rangeInitialValueY, min: rangeMinY, max: rangeMaxY, divisions: rangeStepsY).toDouble();
    return DoubleChartData(
        colors: colors.toImmutableList(),
        lines: convertedDoubleLines.toImmutableList(),
        toolsX: DoubleTools(const DoubleFormatter(0), const DoubleFormatter(0)),
        toolsY: DoubleTools(DoubleFormatter(0, invert: invert), DoubleFormatter(0, invert: invert)),
        minMax: DoubleMinMax(
            minX: minX,
            maxX: rangeX,
            minY: invert ? -rangeY : minY,
            maxY: invert ? minY : rangeY
        )
    );
}

//

Widget _buildChart(String title, DoubleChartData data)
{
    final ChartInfo info = ChartInfo(
        title: title
    );

    const ChartStyle style = ChartStyle(
        devicePixelRatio: 1,
        fontSize: 12,
        pointRadius: 4
    );

    return DoubleLineChart(data: data, info: info, style: style);
}
