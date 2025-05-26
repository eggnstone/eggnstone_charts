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
    Offset? _popupPosition;
    String _popupText = '';

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
                final Widget? popup = _createPopup(backgroundColor, textColor, constraints);

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
                        if (popup != null) popup
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
        setState(() => _popupPosition = null);
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
        logDebug('$localPosition from $source');
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
                _popupPosition = localPosition;
                _popupText = 'X: $customDataXString\nY: $customDataYString';
            }
        );
    }

    Widget? _createPopup(Color backgroundColor, Color textColor, BoxConstraints constraints)
    {
        if (_popupPosition == null || _popupText.isEmpty)
            return null;

        const EdgeInsets popupPadding = EdgeInsets.all(4);
        final TextStyle popupTextStyle = TextStyle(color: textColor, fontSize: 12);
        const double cursorGapLeft = 2;
        const double cursorGapRight = 12;
        const double cursorGapTop = 4;
        const double cursorGapBottom = 24;

        // Measure text to get popup size
        final TextSpan textSpan = TextSpan(text: _popupText, style: popupTextStyle);
        final TextPainter textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr);

        // Constrain the text width to fit within the overlay, accounting for padding
        final double maxTextWidth = constraints.maxWidth - popupPadding.horizontal;
        textPainter.layout(maxWidth: maxTextWidth > 0 ? maxTextWidth : 0);

        final double popupContentWidth = textPainter.width;
        final double popupContentHeight = textPainter.height;
        final double popupWidth = popupContentWidth + popupPadding.horizontal;
        final double popupHeight = popupContentHeight + popupPadding.vertical;

        final double overlayWidth = constraints.maxWidth;
        final double overlayHeight = constraints.maxHeight;

        // Default position: bottom-right of the cursor
        final double candidateLeft = _popupPosition!.dx + cursorGapRight;
        final double candidateTop = _popupPosition!.dy + cursorGapBottom;

        // Check if default position fits
        final bool defaultFits = (candidateLeft + popupWidth <= overlayWidth) &&
            (candidateTop + popupHeight <= overlayHeight);

        double finalPopupLeft;
        double finalPopupTop;

        if (defaultFits)
        {
            finalPopupLeft = candidateLeft;
            finalPopupTop = candidateTop;
        }
        else
        {
            // Alternative position: top-left of the cursor
            // (Popup's bottom-right corner is to the top-left of the cursor)
            finalPopupLeft = _popupPosition!.dx - popupWidth - cursorGapLeft;
            finalPopupTop = _popupPosition!.dy - popupHeight - cursorGapTop;
        }

        // Clamp position to ensure popup stays within overlay boundaries
        // Ensure left edge is not < 0
        if (finalPopupLeft < 0)
            finalPopupLeft = 0;

        // Ensure right edge does not exceed overlay width
        if (finalPopupLeft + popupWidth > overlayWidth)
            finalPopupLeft = overlayWidth - popupWidth;

        // Recalculate if popup is wider than overlay (pin to left)
        if (finalPopupLeft < 0) 
            finalPopupLeft = 0;

        // Ensure top edge is not < 0
        if (finalPopupTop < 0)
            finalPopupTop = 0;

        // Ensure bottom edge does not exceed overlay height
        if (finalPopupTop + popupHeight > overlayHeight)
            finalPopupTop = overlayHeight - popupHeight;

        // Recalculate if popup is taller than overlay (pin to top)
        if (finalPopupTop < 0)
            finalPopupTop = 0;

        return Positioned(
            left: finalPopupLeft,
            top: finalPopupTop,
            child: Container(
                padding: popupPadding,
                decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(4)),
                child: Text(_popupText, style: popupTextStyle)
            )
        );
    }
}
