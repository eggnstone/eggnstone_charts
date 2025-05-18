import 'package:eggnstone_charts/eggnstone_charts.dart';
import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook_annotation;

@widgetbook_annotation.UseCase(path: '', name: 'Double', type: GenericLineChart)
Widget buildDoubleTimeChart(BuildContext context)
=> buildChart();

Widget buildChart()
{
    final List<Color> colors = <Color>[Colors.red];
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
        )
    ];

    final DoubleChartData data =
        DoubleChartData(
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
