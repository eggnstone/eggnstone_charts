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
    {
        final Color lineColor = widget.style.lineColor ?? (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black);
        final Color textColor = widget.style.textColor ?? (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black);
        return Column(
            children: <Widget>[
                if (widget.info.title.isNotEmpty) Text(widget.info.title),
                Expanded(child: _createChart(lineColor: lineColor, textColor: textColor))
            ]
        );
    }

    Widget _createChart({required Color lineColor, required Color textColor})
    => CustomPaint(
        size: Size.infinite,
        painter: GenericLineChartPainter<TX, TY>(
            data: widget.data,
            style: widget.style.copyWith(lineColor: lineColor, textColor: textColor),
        )
    );
}
