import 'package:flutter/material.dart';

import '../ChartInfo.dart';
import '../ChartOverlay.dart';
import '../ChartStyle.dart';
import '../Specifics/DoubleChartData.dart';
import '../Specifics/DoubleMinMax.dart';
import 'GenericChartData.dart';
import 'GenericLineChartPainter.dart';

class GenericLineChart<TX, TY, TD extends GenericChartData<TX, TY>> extends StatefulWidget
{
    final TD data;
    final ChartInfo info;
    final ChartStyle chartStyle;

    const GenericLineChart({
        required this.data,
        required this.info,
        required this.chartStyle,
        super.key
    });

    @override
    State<GenericLineChart<TX, TY, TD>> createState() => _GenericLineChartState<TX, TY, TD>();
}

class _GenericLineChartState<TX, TY, TD extends GenericChartData<TX, TY>> extends State<GenericLineChart<TX, TY, TD>>
{
    DoubleMinMax? _graphMinMax;

    @override
    Widget build(BuildContext context)
    {
        //logDebug('GenericLineChart.build()');

        final DoubleChartData doubleData = widget.data.getDoubleChartData();
        final Color borderColor = widget.chartStyle.borderColor ?? (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black);
        final Color textColor = widget.chartStyle.textColor ?? (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black);

        return Column(
            children: <Widget>[
                if (widget.info.title.isNotEmpty) Text(widget.info.title),
                Expanded(
                    child: Stack(
                        children: <Widget>[
                            RepaintBoundary(
                                child: CustomPaint(
                                    size: Size.infinite,
                                    painter: GenericLineChartPainter<TX, TY>(
                                        customData: widget.data,
                                        doubleData: doubleData,
                                        chartStyle: widget.chartStyle.copyWith(borderColor: borderColor, textColor: textColor),
                                        onGraphMinMaxCalculated: _onGraphMinMaxCalculated
                                    )
                                )
                            ),
                            ChartOverlay<TX, TY>(
                                customData: widget.data,
                                doubleData: doubleData,
                                chartStyle: widget.chartStyle.copyWith(borderColor: borderColor, textColor: textColor),
                                graphMinMax: _graphMinMax
                            )
                        ]
                    )
                )
            ]
        );
    }

    void _onGraphMinMaxCalculated(DoubleMinMax graphMinMax)
    {
        if (_graphMinMax == graphMinMax)
            return;

        //logDebug('GenericLineChart.onGraphMinMaxCalculated: $graphMinMax');
        Future<void>.delayed(Duration.zero, () => setState(() => _graphMinMax = graphMinMax));
    }
}
