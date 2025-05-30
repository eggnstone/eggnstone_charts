import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../ChartInfo.dart';
import '../ChartStyle.dart';
import '../Specifics/DoubleChartData.dart';
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
    Offset? _lastPosition;

    @override
    Widget build(BuildContext context)
    {
        //logDebug('GenericLineChart.build()');

        final DoubleChartData doubleData = widget.data.getDoubleChartData();
        final Brightness brightness = Theme.of(context).brightness;
        final Color borderColor = brightness == Brightness.dark ? widget.style.borderColorDark : widget.style.borderColor;
        final Color textColor = brightness == Brightness.dark ? widget.style.textColorDark : widget.style.textColor;

        final Widget? titleWidget = widget.info.title.isNotEmpty
            ? Text(widget.info.title, style: TextStyle(color: textColor, fontSize: widget.style.fontSize), textScaler: const TextScaler.linear(1.5))
            : null;

        return Column(
            children: <Widget>[
                if (titleWidget != null) titleWidget,
                if (titleWidget != null) const SizedBox(height: 8),
                Expanded(
                    child: MouseRegion(
                        child: CustomPaint(
                            size: Size.infinite,
                            painter: GenericLineChartPainter<TX, TY>(
                                customData: widget.data,
                                dataTipFormat: widget.info.dataTipFormat,
                                doubleData: doubleData,
                                chartStyle: widget.style.copyWith(borderColor: borderColor, textColor: textColor),
                                brightness: brightness,
                                pointerPosition: _lastPosition
                            )
                        ),
                        onHover: _onHover,
                        onExit: _onExit
                    )
                )
            ]
        );
    }

    void _onExit(PointerExitEvent event)
    => _updatePosition(null, 'onExit');

    void _onHover(PointerHoverEvent event)
    => _updatePosition(event.localPosition, 'onHover');

    void _updatePosition(Offset? localPosition, String source)
    {
        //logDebug('$localPosition from $source');
        setState(() => _lastPosition = localPosition);
    }
}
