import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../ChartInfo.dart';
import '../ChartStyle.dart';
import '../ClosestLineInfo.dart';
import '../DataTools.dart';
import '../Specifics/DoubleChartData.dart';
import '../Specifics/DoubleMinMax.dart';
import 'GenericChartData.dart';
import 'GenericLineChartPainter.dart';

typedef TapCallback = void Function<TX, TY>(Offset location, TX dataX, TY dataY, ClosestLineInfo? closestLine);

class GenericLineChart<TX, TY, TD extends GenericChartData<TX, TY>> extends StatefulWidget
{
    final TD data;
    final ChartInfo info;
    final ChartStyle style;
    final TapCallback? onTap;

    const GenericLineChart({
        required this.data,
        required this.info,
        required this.style,
        this.onTap,
        super.key
    });

    @override
    State<GenericLineChart<TX, TY, TD>> createState() => _GenericLineChartState<TX, TY, TD>();
}

class _GenericLineChartState<TX, TY, TD extends GenericChartData<TX, TY>> extends State<GenericLineChart<TX, TY, TD>>
{
    late TD _customData;
    late DoubleChartData _doubleData;

    DataTools? _dataTools;
    Offset? _lastPosition;
    ClosestLineInfo? _closestLine;

    @override
    void initState()
    {
        super.initState();
        _customData = widget.data;
        _doubleData = widget.data.createDoubleChartData();
    }

    @override
    Widget build(BuildContext context)
    {
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
                    child: GestureDetector(
                        child: MouseRegion(
                            child: CustomPaint(
                                size: Size.infinite,
                                painter: GenericLineChartPainter<TX, TY>(
                                    customData: _customData,
                                    dataTipFormat: widget.info.dataTipFormat,
                                    doubleData: _doubleData,
                                    chartStyle: widget.style.copyWith(borderColor: borderColor, textColor: textColor),
                                    brightness: brightness,
                                    pointerPosition: _lastPosition,
                                    onClosestLineCalculated: _onClosestLineCalculated,
                                    onGraphMinMaxCalculated: _onGraphMinMaxCalculated
                                )
                            ),
                            onHover: _onHover,
                            onExit: _onExit
                        ),
                        onPanEnd: _onPanEnd,
                        onPanUpdate: _onPanUpdate,
                        onPanStart: _onPanStart,
                        onTapDown: _onTapDown,
                        onTapUp: _onTapUp
                    )
                )
            ]
        );
    }

    void _onExit(PointerExitEvent event)
    => _updatePosition(null);

    void _onHover(PointerHoverEvent event)
    => _updatePosition(event.localPosition);

    void _updatePosition(Offset? localPosition)
    => setState(() => _lastPosition = localPosition);

    void _onTap(String source)
    {
        //logDebug('onTap($source)');
        if (widget.onTap == null || _lastPosition == null || _dataTools == null)
        {
            /*logDebug('  No onTap callback or last position or data tools available');
            logDebug('  widget.onTap: ${widget.onTap}, _lastPosition: $_lastPosition, _dataTools: $_dataTools');*/
            return;
        }

        final TX customDataX = _customData.toolsX.toCustomValue(_dataTools!.pixelToDataX(_lastPosition!.dx));
        final TY customDataY = _customData.toolsY.toCustomValue(_dataTools!.pixelToDataY(_lastPosition!.dy));

        //logDebug('  $_lastPosition => $customDataX, $customDataY');
        widget.onTap!.call(_lastPosition!, customDataX, customDataY, _closestLine);
    }

    void _onTapDown(TapDownDetails details)
    {
        //logDebug('onTapDown(${details.localPosition})');
        _updatePosition(details.localPosition);
    }

    void _onTapUp(TapUpDetails details)
    {
        //logDebug('onTapUp(${details.localPosition})');
        _updatePosition(details.localPosition);
        _onTap('onTapUp');
    }

    void _onGraphMinMaxCalculated(DoubleMinMax graphMinMax)
    {
        //logDebug('onGraphMinMaxCalculated($graphMinMax)');
        _dataTools = DataTools(_doubleData.minMax, graphMinMax);
    }

    void _onPanEnd(DragEndDetails details)
    {
        //logDebug('onPanEnd(${details.velocity})');
        _onTap('onPanEnd');
    }

    void _onPanUpdate(DragUpdateDetails details)
    {
        //logDebug('onPanUpdate(${details.localPosition})');
        _updatePosition(details.localPosition);
    }

    void _onPanStart(DragStartDetails details)
    {
        //logDebug('onPanStart(${details.localPosition})');
        _updatePosition(details.localPosition);
    }

    // ignore: use_setters_to_change_properties
    void _onClosestLineCalculated(ClosestLineInfo? closestLine)
    => _closestLine = closestLine;
}
