import 'package:eggnstone_charts/eggnstone_charts.dart';
import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook_annotation;

@widgetbook_annotation.UseCase(path: '', name: 'No lines', type: DoubleLineChart)
Widget buildDoubleTimeChartNoLines(BuildContext context)
=> buildChart(_createNoLines());

@widgetbook_annotation.UseCase(path: '', name: 'Mismatch of lines and colors', type: DoubleLineChart)
Widget buildDoubleTimeChartMismatchOfLinesAndColors(BuildContext context)
=> buildChart(_createMismatchOfLinesAndColors());

@widgetbook_annotation.UseCase(path: '', name: '2 lines, single entry each', type: DoubleLineChart)
Widget buildDoubleTimeChartTwoLinesOneEntryEach(BuildContext context)
=> buildChart(_createTwoLinesOneEntryEach());

@widgetbook_annotation.UseCase(path: '', name: '2 lines, single and multiple entries', type: DoubleLineChart)
Widget buildDoubleTimeChartTwoLinesSingleAndMultipleEntries(BuildContext context)
=> buildChart(_createTwoLinesSingleAndMultipleEntries());

DoubleChartData _createNoLines()
=> DoubleChartData(
    colors: <Color>[].toImmutableList(),
    lines: <DoubleLineData>[].toImmutableList(),
    toolsX: DoubleTools(const DoubleFormatter(2)),
    toolsY: DoubleTools(const DoubleFormatter(2)),
    minMax: DoubleMinMax(
        minX: 0,
        maxX: 10,
        minY: 0,
        maxY: 10
    )
);

DoubleChartData _createMismatchOfLinesAndColors()
{
    final List<Color> colors = <Color>[Colors.red, Colors.green];
    final List<DoubleLineData> doubleLines = <DoubleLineData>
    [
        DoubleLineData(
            <DoublePoint>
            [
                const DoublePoint(1, 0),
                const DoublePoint(2, 1)
            ].toImmutableList()
        )
    ];

    return DoubleChartData(
        colors: colors.toImmutableList(),
        lines: doubleLines.toImmutableList(),
        toolsX: DoubleTools(const DoubleFormatter(2)),
        toolsY: DoubleTools(const DoubleFormatter(2)),
        minMax: DoubleMinMax(
            minX: 0,
            maxX: 10,
            minY: 0,
            maxY: 10
        )
    );
}

DoubleChartData _createTwoLinesOneEntryEach()
{
    final List<Color> colors = <Color>[Colors.red, Colors.green];
    final List<DoubleLineData> doubleLines = <DoubleLineData>
    [
        DoubleLineData(
            <DoublePoint>
            [
                const DoublePoint(1, 0)
            ].toImmutableList()
        ),
        DoubleLineData(
            <DoublePoint>
            [
                const DoublePoint(2, 1)
            ].toImmutableList()
        )
    ];

    return DoubleChartData(
        colors: colors.toImmutableList(),
        lines: doubleLines.toImmutableList(),
        toolsX: DoubleTools(const DoubleFormatter(2)),
        toolsY: DoubleTools(const DoubleFormatter(2)),
        minMax: DoubleMinMax(
            minX: 0,
            maxX: 10,
            minY: 0,
            maxY: 10
        )
    );
}

DoubleChartData _createTwoLinesSingleAndMultipleEntries()
{
    final List<Color> colors = <Color>[Colors.red, Colors.green];
    final List<DoubleLineData> doubleLines = <DoubleLineData>
    [
        DoubleLineData(
            <DoublePoint>
            [
                const DoublePoint(1, 0),
                const DoublePoint(2, 1),
                const DoublePoint(3, 2),
                const DoublePoint(4, 3),
                const DoublePoint(5, 4),
                const DoublePoint(6, 3),
                const DoublePoint(7, 1),
                const DoublePoint(8, 7)
            ].toImmutableList()
        ),
        DoubleLineData(
            <DoublePoint>
            [
                const DoublePoint(5, 5)
            ].toImmutableList()
        )
    ];

    return DoubleChartData(
        colors: colors.toImmutableList(),
        lines: doubleLines.toImmutableList(),
        toolsX: DoubleTools(const DoubleFormatter(2)),
        toolsY: DoubleTools(const DoubleFormatter(2)),
        minMax: DoubleMinMax(
            minX: 0,
            maxX: 10,
            minY: 0,
            maxY: 10
        )
    );
}

Widget buildChart(DoubleChartData data)
{
    const ChartInfo info = ChartInfo(
        title: 'Test'
    );

    const ChartStyle style = ChartStyle(
        devicePixelRatio: 1,
        fontSize: 12,
        radius: 4
    );

    return DoubleLineChart(
        data: data,
        info: info,
        style: style
    );
}
