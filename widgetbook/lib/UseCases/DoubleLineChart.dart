import 'package:collection/collection.dart';
import 'package:eggnstone_charts/eggnstone_charts.dart';
import 'package:eggnstone_dart/eggnstone_dart.dart';
import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

// UseCases

@UseCase(path: 'Errors', name: 'No data', type: DoubleLineChart)
Widget buildDoubleChartForNoData(BuildContext context)
=> _buildChart(context, 'No Data', _createDoubleChartDataForNoData(context));

@UseCase(path: '', name: '2 dots', type: DoubleLineChart)
Widget buildDoubleChartForTwoDots(BuildContext context)
=> _buildChart(context, '2 dots', _createDoubleChartDataForTwoDots(context));

@UseCase(path: '', name: '1 dot', type: DoubleLineChart)
Widget buildDoubleChartForOneDot(BuildContext context)
=> _buildChart(context, '1 dot', _createDoubleChartDataForOneDot(context));

@UseCase(path: '', name: '2 lines', type: DoubleLineChart)
Widget buildDoubleChartForTwoLines(BuildContext context)
=> _buildChart(context, '2 lines', _createDoubleChartDataForTwoLines(context));

@UseCase(path: '', name: '2 lines, 2 dots', type: DoubleLineChart)
Widget buildDoubleChartForTwoLinesTwoDots(BuildContext context)
=> _buildChart(context, '2 lines, 2 dots', _createDoubleChartDataForTwoLinesTwoDots(context));

@UseCase(path: '', name: '1 line', type: DoubleLineChart)
Widget buildDoubleChartForOneLineStartingAt0(BuildContext context)
=> _buildChart(context, '1 line', _createDoubleChartDataForOneLine(context));

@UseCase(path: '', name: '1 line @ 1', type: DoubleLineChart)
Widget buildDoubleChartForOneLineStartingAt1(BuildContext context)
=> _buildChart(context, '1 line  1', _createDoubleChartDataForOneLine(context, start: 1));

@UseCase(path: '', name: '1 line, 1 dot', type: DoubleLineChart)
Widget buildDoubleChartForOneLineOneDot(BuildContext context)
=> _buildChart(context, '1 line, 1 dot', _createDoubleChartDataForOneLineOneDot(context));

@UseCase(path: '', name: 'Doc 1', type: DoubleLineChart)
Widget buildDoubleChartForDocOne(BuildContext context)
=> Center(
    child: SizedBox(
        width: 200,
        height: 200,
        child: _buildChart(
            context,
            'Double Sample',
            _createDoubleChartDataForDocOne(context)
        )
    )
);

// Data

DoubleChartData _createDoubleChartDataForNoData(BuildContext context)
=> _createDoubleChartData(context, colors: <Color>[], doublePointLists: <List<DoublePoint>>[]);

DoubleChartData _createDoubleChartDataForTwoDots(BuildContext context)
=> _createDoubleChartData(
    context,
    colors: <Color>[Colors.red, Colors.green],
    doublePointLists: <List<DoublePoint>>[_createDoublePointsForDot1(), _createDoublePointsForDot2()]
);

DoubleChartData _createDoubleChartDataForDocOne(BuildContext context)
=> _createDoubleChartData(
    context,
    colors: <Color>[Colors.green],
    doublePointLists: <List<DoublePoint>>[_createDoublePointsForOneLine()],
    rangeInitialValueX: 9,
    rangeInitialValueY: 7,
    rangeMinX: 4,
    rangeMaxX: 14,
    rangeMinY: 2,
    rangeMaxY: 11,
    rangeStepsX: 2,
    rangeStepsY: 2
);

DoubleChartData _createDoubleChartDataForOneDot(BuildContext context)
=> _createDoubleChartData(
    context,
    colors: <Color>[Colors.red],
    doublePointLists: <List<DoublePoint>>[_createDoublePointsForDot1()]
);

DoubleChartData _createDoubleChartDataForTwoLines(BuildContext context)
=> _createDoubleChartData(
    context,
    colors: <Color>[Colors.red, Colors.green],
    doublePointLists: <List<DoublePoint>>[_createDoublePointsForLine1(), _createDoublePointsForLine2()]
);

DoubleChartData _createDoubleChartDataForTwoLinesTwoDots(BuildContext context)
=> _createDoubleChartData(
    context,
    colors: <Color>[Colors.red, Colors.green, Colors.blue, Colors.orange],
    doublePointLists: <List<DoublePoint>>[_createDoublePointsForLine1(), _createDoublePointsForLine2(), _createDoublePointsForDot1(), _createDoublePointsForDot2()]
);

DoubleChartData _createDoubleChartDataForOneLineOneDot(BuildContext context)
=> _createDoubleChartData(
    context,
    colors: <Color>[Colors.red, Colors.green],
    doublePointLists: <List<DoublePoint>>[_createDoublePointsForLine1(), _createDoublePointsForDot1()]
);

DoubleChartData _createDoubleChartDataForOneLine(BuildContext context, {int start = 0})
=> _createDoubleChartData(
    context,
    colors: <Color>[Colors.red],
    doublePointLists: <List<DoublePoint>>[_createDoublePointsForLine1(start: start)],
    minY: start.toDouble(),
    rangeMinY: 10 + start,
    rangeMaxY: 100 + start,
    rangeInitialValueY: 10 + start
);

// Raw data

List<DoublePoint> _createDoublePointsForOneLine()
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

List<DoublePoint> _createDoublePointsForLine1({int start = 0})
=> <DoublePoint>
[
    DoublePoint(1, start.toDouble()),
    DoublePoint(2, start + 1),
    DoublePoint(3, start + 2),
    DoublePoint(4, start + 3),
    DoublePoint(5, start + 4),
    DoublePoint(6, start + 3),
    DoublePoint(7, start + 1),
    DoublePoint(8, start + 7)
];

List<DoublePoint> _createDoublePointsForLine2()
=> <DoublePoint>
[
    const DoublePoint(2, 8),
    const DoublePoint(8, 4)
];

List<DoublePoint> _createDoublePointsForDot1()
=> <DoublePoint>
[
    const DoublePoint(5, 5)
];

List<DoublePoint> _createDoublePointsForDot2()
=> <DoublePoint>
[
    const DoublePoint(6, 6)
];

//

DoubleChartData _createDoubleChartData(
    BuildContext context, {
        required List<Color> colors,
        required List<List<DoublePoint>> doublePointLists,
        double minX = 0,
        double minY = 0,
        int rangeMinX = 10,
        int rangeMaxX = 100,
        int rangeMinY = 10,
        int rangeMaxY = 100,
        int rangeStepsX = 3,
        int rangeStepsY = 3,
        int rangeInitialValueX = 10,
        int rangeInitialValueY = 10
    }
)
{
    final List<DoubleDataSeries> convertedDoubleDataSeriesList = doublePointLists
        .mapIndexed(
            (int index, List<DoublePoint> points) 
            => DoubleDataSeries(
                colors[index],
                'Data Series #${index + 1}', 
                points.toImmutableList()
            )
        )
        .toList();

    final double rangeX = context.knobs.int.slider(label: 'Range X', initialValue: rangeInitialValueX, min: rangeMinX, max: rangeMaxX, divisions: rangeStepsX).toDouble();
    final double rangeY = context.knobs.int.slider(label: 'Range Y', initialValue: rangeInitialValueY, min: rangeMinY, max: rangeMaxY, divisions: rangeStepsY).toDouble();
    return DoubleChartData(
        dataSeriesList: convertedDoubleDataSeriesList.toImmutableList(),
        toolsX: DoubleTools(const DoubleFormatter(0), const DoubleFormatter(0)),
        toolsY: DoubleTools(const DoubleFormatter(0), const DoubleFormatter(0)),
        minMax: DoubleMinMax(
            minX: minX,
            maxX: rangeX,
            minY: minY,
            maxY: rangeY
        )
    );
}

//

Widget _buildChart(BuildContext context, String title, DoubleChartData data)
{
    final bool invertX = context.knobs.boolean(label: 'Invert X');
    final bool invertY = context.knobs.boolean(label: 'Invert Y');

    final bool showLabelBottom = context.knobs.boolean(label: 'Show label bottom', initialValue: true);
    final bool showLabelLeft = context.knobs.boolean(label: 'Show label left', initialValue: true);
    final bool showLabelRight = context.knobs.boolean(label: 'Show label right');
    final bool showLabelTop = context.knobs.boolean(label: 'Show label top');

    final bool showTicksBottom = context.knobs.boolean(label: 'Show ticks bottom', initialValue: true);
    final bool showTicksLeft = context.knobs.boolean(label: 'Show ticks left', initialValue: true);
    final bool showTicksRight = context.knobs.boolean(label: 'Show ticks right');
    final bool showTicksTop = context.knobs.boolean(label: 'Show ticks top');

    final ChartInfo info = ChartInfo(
        title: title,
        labelBottom: showLabelBottom ? 'Bottom Label' : '',
        labelLeft: showLabelLeft ? 'Left Label' : '',
        labelRight: showLabelRight ? 'Right Label' : '',
        labelTop: showLabelTop ? 'Top Label' : ''
    );

    final ChartStyle style = ChartStyle(
        devicePixelRatio: 1,
        fontSize: 12,
        invertX: invertX,
        invertY: invertY,
        pointRadius: 4,
        showTicksBottom: showTicksBottom,
        showTicksLeft: showTicksLeft,
        showTicksRight: showTicksRight,
        showTicksTop: showTicksTop
    );

    return DoubleLineChart(
        data: data,
        info: info,
        style: style,
        onTap: _onTap
    );
}

void _onTap<TX, TY>(Offset location, TX dataX, TY dataY, ClosestLineInfo? closestLine)
{
    logDebug('Tapped at $location, dataX: $dataX, dataY: $dataY');
    logDebug('  closestLine: $closestLine');
}
