import 'package:eggnstone_dart/eggnstone_dart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'ChartStyle.dart';
import 'DataTools.dart';
import 'Generics/GenericChartData.dart';
import 'Generics/GenericMinMax.dart';
import 'Specifics/DoubleChartData.dart';
import 'Specifics/DoubleMinMax.dart';

class ChartOverlay<TX, TY> extends StatefulWidget
{
    final DoubleMinMax? graphMinMax;
    final ChartStyle chartStyle;
    final GenericChartData<TX, TY> customData;
    final DoubleChartData doubleData;

    const ChartOverlay({
        required this.graphMinMax,
        required this.chartStyle,
        required this.customData,
        required this.doubleData,
        super.key
    });

    @override
    State<ChartOverlay<TX, TY>> createState() => _ChartOverlayState<TX, TY>();
}

class _ChartOverlayState<TX, TY> extends State<ChartOverlay<TX, TY>>
{
    Offset? _dataTipPosition;
    String _dataTipText = '';

    @override
    Widget build(BuildContext context)
    {
        //logDebug('ChartOverlay.build()');

        final Brightness brightness = Theme.of(context).brightness;
        final Color textColor = brightness == Brightness.dark ? Colors.black : Colors.white;
        final Color backgroundColor = brightness == Brightness.dark ? Colors.white : Colors.black;

        return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints)
            {
                final Widget? dataTip = _createDataTip(backgroundColor, textColor, constraints);

                return Stack(
                    children: <Widget>[
                        MouseRegion(
                            child: GestureDetector(
                                child: AbsorbPointer(child: Container()),
                                onTap: _onTap,
                                onTapCancel: _onTapCancel,
                                onTapDown: _onTapDown,
                                onTapMove: _onTapMove,
                                onTapUp: _onTapUp,
                                onPanCancel: _onPanCancel,
                                onPanDown: _onPanDown,
                                onPanEnd: _onPanEnd,
                                onPanStart: _onPanStart,
                                onPanUpdate: _onPanUpdate,
                                onSecondaryTap: _onSecondaryTap,
                                onSecondaryTapCancel: _onSecondaryTapCancel,
                                onSecondaryTapDown: _onSecondaryTapDown,
                                onSecondaryTapUp: _onSecondaryTapUp
                            ),
                            /*onEnter: _onEnter,
                            */
                            onExit: _onExit,
                            onHover: _onHover
                        ),
                        if (dataTip != null) dataTip
                    ]
                );
            }
        );
    }

    /*void _onEnter(PointerEnterEvent event)
    => _updatePosition(event.localPosition, 'onEnter');*/

    void _onExit(PointerExitEvent event)
    {
        //logDebug('ChartOverlay: Exited at ${event.localPosition}');
        //_lastPosition = null;
        setState(() => _dataTipPosition = null);
    }

    void _onHover(PointerHoverEvent event)
    => _updatePosition(event.localPosition, 'onHover');

    void _onTap()
    {
        logDebug('ChartOverlay: Tapped');
    }

    void _onSecondaryTap()
    {
        logDebug('ChartOverlay: Secondary tapped');
    }

    void _onTapDown(TapDownDetails details)
    => _updatePosition(details.localPosition, 'onTapDown');

    void _onTapUp(TapUpDetails details)
    => _updatePosition(details.localPosition, 'onTapUp');

    void _onSecondaryTapDown(TapDownDetails details)
    => _updatePosition(details.localPosition, 'onSecondaryTapDown');

    void _onSecondaryTapUp(TapUpDetails details)
    => _updatePosition(details.localPosition, 'onSecondaryTapUp');

    void _onTapCancel()
    {
        logDebug('ChartOverlay: Tap cancelled');
    }

    void _onTapMove(TapMoveDetails details)
    => _updatePosition(details.localPosition, 'onTapMove');

    void _onPanCancel()
    {
        logDebug('ChartOverlay: Pan cancelled');
    }

    void _onPanStart(DragStartDetails details)
    => _updatePosition(details.localPosition, 'onPanStart');

    void _onPanDown(DragDownDetails details)
    => _updatePosition(details.localPosition, 'onPanDown');

    void _onPanEnd(DragEndDetails details)
    => _updatePosition(details.primaryVelocity != null ? details.localPosition : Offset.zero, 'onPanEnd');

    void _onPanUpdate(DragUpdateDetails details)
    => _updatePosition(details.localPosition, 'onPanUpdate');

    void _onSecondaryTapCancel()
    {
        logDebug('ChartOverlay: Secondary tap cancelled');
    }

    void _updatePosition(Offset localPosition, String source)
    {
        //logDebug('$localPosition from $source');
        //_lastPosition = localPosition;

        if (widget.graphMinMax == null)
            return;

        final GenericMinMax<double, double> doubleDataMinMax = widget.doubleData.minMax;
        final DataTools dataTools = DataTools(doubleDataMinMax, widget.graphMinMax!);

        final double pixelX = localPosition.dx;
        final double pixelY = localPosition.dy;

        final double doubleDataX = dataTools.pixelToDataX(pixelX);
        final double doubleDataY = dataTools.pixelToDataY(pixelY);

        final TX customDataX = widget.customData.toolsX.toCustomValue(doubleDataX);
        final TY customDataY = widget.customData.toolsY.toCustomValue(doubleDataY);

        final String customDataXString = widget.customData.toolsX.format(customDataX).replaceAll('\n', '');
        final String customDataYString = widget.customData.toolsY.format(customDataY).replaceAll('\n', '');

        /*logDebug('[${pixelX.toStringAsFixed(1)} , ${pixelY.toStringAsFixed(1)}]'
            ' => [${doubleDataX.toStringAsFixed(2)} , ${doubleDataY.toStringAsFixed(2)}]'
            ' => [$customDataXString , $customDataYString]');*/

        setState(()
            {
                _dataTipPosition = localPosition;
                _dataTipText = 'X: $customDataXString\nY: $customDataYString';
            }
        );
    }

    Widget? _createDataTip(Color backgroundColor, Color textColor, BoxConstraints constraints)
    {
        if (_dataTipPosition == null || _dataTipText.isEmpty)
            return null;

        const EdgeInsets dataTipPadding = EdgeInsets.all(4);
        final TextStyle dataTipTextStyle = TextStyle(color: textColor, fontSize: 12);
        const double cursorGapLeft = 2;
        const double cursorGapRight = 12;
        const double cursorGapTop = 4;
        const double cursorGapBottom = 24;

        // Measure text to get dataTip size
        final TextSpan textSpan = TextSpan(text: _dataTipText, style: dataTipTextStyle);
        final TextPainter textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr);

        // Constrain the text width to fit within the overlay, accounting for padding
        final double maxTextWidth = constraints.maxWidth - dataTipPadding.horizontal;
        textPainter.layout(maxWidth: maxTextWidth > 0 ? maxTextWidth : 0);

        final double dataTipContentWidth = textPainter.width;
        final double dataTipContentHeight = textPainter.height;
        final double dataTipWidth = dataTipContentWidth + dataTipPadding.horizontal;
        final double dataTipHeight = dataTipContentHeight + dataTipPadding.vertical;

        final double overlayWidth = constraints.maxWidth;
        final double overlayHeight = constraints.maxHeight;

        // Default position: bottom-right of the cursor
        final double candidateLeft = _dataTipPosition!.dx + cursorGapRight;
        final double candidateTop = _dataTipPosition!.dy + cursorGapBottom;

        // Check if default position fits
        final bool defaultFits = (candidateLeft + dataTipWidth <= overlayWidth) &&
            (candidateTop + dataTipHeight <= overlayHeight);

        double finalDataTipLeft;
        double finalDataTipTop;

        if (defaultFits)
        {
            finalDataTipLeft = candidateLeft;
            finalDataTipTop = candidateTop;
        }
        else
        {
            // Alternative position: top-left of the cursor
            // (DataTip's bottom-right corner is to the top-left of the cursor)
            finalDataTipLeft = _dataTipPosition!.dx - dataTipWidth - cursorGapLeft;
            finalDataTipTop = _dataTipPosition!.dy - dataTipHeight - cursorGapTop;
        }

        // Clamp position to ensure dataTip stays within overlay boundaries
        // Ensure left edge is not < 0
        if (finalDataTipLeft < 0)
            finalDataTipLeft = 0;

        // Ensure right edge does not exceed overlay width
        if (finalDataTipLeft + dataTipWidth > overlayWidth)
            finalDataTipLeft = overlayWidth - dataTipWidth;

        // Recalculate if dataTip is wider than overlay (pin to left)
        if (finalDataTipLeft < 0) 
            finalDataTipLeft = 0;

        // Ensure top edge is not < 0
        if (finalDataTipTop < 0)
            finalDataTipTop = 0;

        // Ensure bottom edge does not exceed overlay height
        if (finalDataTipTop + dataTipHeight > overlayHeight)
            finalDataTipTop = overlayHeight - dataTipHeight;

        // Recalculate if dataTip is taller than overlay (pin to top)
        if (finalDataTipTop < 0)
            finalDataTipTop = 0;

        return Positioned(
            left: finalDataTipLeft,
            top: finalDataTipTop,
            child: Container(
                padding: dataTipPadding,
                decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(4)),
                child: Text(_dataTipText, style: dataTipTextStyle)
            )
        );
    }
}
