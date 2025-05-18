import 'package:flutter/material.dart';

import '../ChartInfo.dart';
import '../ChartStyle.dart';
import 'GenericChartData.dart';
import 'GenericLineChartPainter.dart';

class GenericLineChart<TX, TY, TD extends GenericChartData<TX, TY>> extends StatefulWidget
{
    final TD data;
    final ChartInfo info;
    final ChartStyle style;

    const GenericLineChart({
        required this.data,
        required this.info,
        required this.style,
        super.key
    });

    @override
    State<GenericLineChart<TX, TY, TD>> createState() => _GenericLineChartState<TX, TY, TD>();
}

class _GenericLineChartState<TX, TY, TD extends GenericChartData<TX, TY>> extends State<GenericLineChart<TX, TY, TD>>
{
    @override
    Widget build(BuildContext context)
    => Column(
        children: <Widget>[
            if (widget.info.title.isNotEmpty) Text(widget.info.title),
            Expanded(child: _createChart())
        ]
    );

    Widget _createChart()
    => CustomPaint(
        size: Size.infinite,
        painter: GenericLineChartPainter<TX, TY>(
            data: widget.data,
            style: widget.style
        )
    );
}
