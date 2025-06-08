import 'package:eggnstone_charts/eggnstone_charts.dart';
import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';

void main()
{
    runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) 
    => MaterialApp(
        title: 'eggnstone_charts Demo',
        home: Scaffold(
            appBar: AppBar(
                title: const Text('eggnstone_charts Demo'),
                backgroundColor: Theme.of(context).colorScheme.inversePrimary
            ),
            body: DoubleLineChart(
                data: DoubleChartData(
                    lines: KtList<DoubleLineData>.from(
                        <DoubleLineData>[
                            DoubleLineData(
                                Colors.green,
                                'Data Series #1',
                                KtList<DoublePoint>.from(
                                    <DoublePoint>[
                                        const DoublePoint(1, 1),
                                        const DoublePoint(9, 9)
                                    ]
                                )
                            )
                        ]
                    ),
                    toolsX: DoubleTools(const DoubleFormatter(0), const DoubleFormatter(0)),
                    toolsY: DoubleTools(const DoubleFormatter(0), const DoubleFormatter(0)),
                    minMax: DoubleMinMax(minX: 0, maxX: 10, minY: 0, maxY: 10)
                ),
                info: const ChartInfo(
                    title: 'Sample Chart',
                    labelBottom: 'X Axis',
                    labelLeft: 'Y Axis'
                ),
                style: ChartStyle(
                    devicePixelRatio: View.of(context).devicePixelRatio,
                    fontSize: 12,
                    pointRadius: 4,
                    showTicksBottom: true,
                    showTicksLeft: true,
                    showTicksRight: true,
                    showTicksTop: true
                )
            )
        )
    );
}
