import 'dart:math';

import 'package:eggnstone_dart/eggnstone_dart.dart';
import 'package:flutter/material.dart';

import '../ChartStyle.dart';
import '../ChartsUserException.dart';
import '../ClosestLineInfo.dart';
import '../ClosestPointInfo.dart';
import '../DataTools.dart';
import '../PaintInfo.dart';
import '../PositionedTextPainter.dart';
import '../Specifics/DoubleChartData.dart';
import '../Specifics/DoubleLineData.dart';
import '../Specifics/DoubleMinMax.dart';
import 'GenericChartData.dart';
import 'GenericLineData.dart';
import 'GenericTools.dart';

typedef ClosestLineCalculatedCallback = void Function(ClosestLineInfo? closestLine);
typedef GraphMinMaxCalculatedCallback = void Function(DoubleMinMax graphMinMax);

class GenericLineChartPainter<TX, TY> extends CustomPainter
{
    static const bool DEBUG = false;
    static const bool DEBUG_DATA_TO_PIXEL = false;

    static const double additionalSpaceForLabelX = paddingBetweenTickLabelAndTickLineX + tickLineLengthX;
    static const double paddingBetweenTickLabelAndTickLineX = 2;
    static const double paddingBetweenTicksX = 2;
    static const double tickLineLengthX = 8;

    static const double additionalSpaceForLabelY = paddingBetweenTickLabelAndTickLineY + tickLineLengthY;
    static const double paddingBetweenTickLabelAndTickLineY = 0;
    static const double paddingBetweenTicksY = 2;
    static const double tickLineLengthY = 8;

    static const double dataTipPaddingX = 6;
    static const double dataTipPaddingY = 4;
    static const double dataTipPointerGapLeft = 2;
    static const double dataTipPointerGapRight = 12;
    static const double dataTipPointerGapTop = 4;
    static const double dataTipPointerGapBottom = 24;

    final ChartStyle chartStyle;
    final GenericChartData<TX, TY> customData;
    final Brightness? brightness;
    final String dataTipFormat;
    final DoubleChartData doubleData;
    final double highlightDistanceX;
    final double highlightDistanceY;
    final Offset? pointerPosition;
    final ClosestLineCalculatedCallback? onClosestLineCalculated;
    final GraphMinMaxCalculatedCallback? onGraphMinMaxCalculated;

    GenericLineChartPainter({
        required this.chartStyle,
        required this.customData,
        required this.doubleData,
        this.brightness,
        this.dataTipFormat = '%s\nX: %x\nY: %y',
        this.highlightDistanceX = 20,
        this.highlightDistanceY = 20,
        this.pointerPosition,
        this.onClosestLineCalculated,
        this.onGraphMinMaxCalculated
    });

    @override
    void paint(Canvas canvas, Size size)
    {
        //logDebug('GenericLineChartPainter.paint() pointerPosition: $pointerPosition');

        try
        {
            _paintOrThrow(canvas, size);
        }
        on ChartsUserException catch (e, stackTrace)
        {
            _showError(canvas, size, e.toString());
            logError('GenericLineChartPainter.paint', e, stackTrace);
        }
        catch (e, stackTrace)
        {
            _showError(canvas, size, 'Internal error: $e');
            logError('GenericLineChartPainter.paint', e, stackTrace);
        }
    }

    void _paintOrThrow(Canvas canvas, Size size)
    {
        if (DEBUG)
        {
            logDebug('GenericLineChartPainter._paintOrThrow() Size: $size');
            logDebug('  customData.minMax: ${customData.minMax}');
            logDebug('  doubleData.minMax: ${doubleData.minMax}');
        }

        if (customData.lines.size != customData.colors.size)
            throw ChartsUserException('Mismatch between lines and colors');

        if (customData.lines.isEmpty())
            throw ChartsUserException('No data');

        final DoubleMinMax graphMinMax = _calcGraphMinMax(
            size, 
            <TextPainter>[
                _createAndLayoutTextPainter(customData.toolsX.format(customData.minMax.minX), chartStyle),
                _createAndLayoutTextPainter(customData.toolsX.format(customData.minMax.maxX), chartStyle)
            ],
            <TextPainter>[
                _createAndLayoutTextPainter(customData.toolsY.format(customData.minMax.minY), chartStyle),
                _createAndLayoutTextPainter(customData.toolsY.format(customData.minMax.maxY), chartStyle)
            ]
        );

        onGraphMinMaxCalculated?.call(graphMinMax);
        if (DEBUG)
            logDebug('  graphMinMax:       $graphMinMax');

        final List<PositionedTextPainter<TX>> xAxisPainters = _createXAxisTicks(graphMinMax);
        final List<PositionedTextPainter<TY>> yAxisPainters = _createYAxisTicks(graphMinMax);

        final PaintInfo paintInfo = PaintInfo(
            canvas: canvas,
            size: size,
            graphMinMax: graphMinMax,
            borderPaint: _createBorderPaint(),
            dataTipBackgroundPaint: _createDataTipBackgroundPaint(),
            gridPaint: _createGridPaint(),
            gridPaint2: _createGridPaint2()
        );

        canvas.drawRect(Rect.fromLTRB(graphMinMax.minX, graphMinMax.minY, graphMinMax.maxX, graphMinMax.maxY), paintInfo.borderPaint);

        _paintTextPaintersLeft(paintInfo, yAxisPainters);
        _paintTextPaintersRight(paintInfo, yAxisPainters);

        _paintTextPaintersTop(paintInfo, xAxisPainters);
        _paintTextPaintersBottom(paintInfo, xAxisPainters);

        final ClosestLineInfo? closestLine = _calcClosestLine(paintInfo);
        onClosestLineCalculated?.call(closestLine);
        _drawLines(paintInfo, closestLine);

        /*
        final TextPainter tpLeft = _createAndLayoutTextPainter('Left');
        final TextPainter tpTop = _createAndLayoutTextPainter('Top');
        final TextPainter tpRight = _createAndLayoutTextPainter('Right');
        final TextPainter tpBottom = _createAndLayoutTextPainter('Bottom');

        tpLeft.paint(canvas, Offset(paddingHorizontalOuter, graphMinMax.maxY / 2));
        tpTop.paint(canvas, Offset(graphMinMax.maxX / 2, paddingVerticalOuter));
        tpRight.paint(canvas, Offset(size.width - paddingHorizontalOuter - tpRight.width, graphMinMax.maxY / 2));
        tpBottom.paint(canvas, Offset(graphMinMax.maxX / 2, size.height - paddingVerticalOuter - tpBottom.height));
        */

        if (closestLine != null && closestLine.closestPoint.distance.dx < highlightDistanceX && closestLine.closestPoint.distance.dy < highlightDistanceY)
        {
            final GenericLineData<TX, TY> line = customData.lines[closestLine.lineIndex];
            _drawDataTip(paintInfo, line.label, closestLine.closestPoint);
        }
    }

    @override
    bool shouldRepaint(covariant CustomPainter oldDelegate)
    {
        //logDebug('GenericLineChartPainter.shouldRepaint() oldDelegate: ${oldDelegate.runtimeType}');

        if (oldDelegate is GenericLineChartPainter<TX, TY>)
        {
            final GenericLineChartPainter<TX, TY> oldPainter = oldDelegate;
            return oldPainter.customData != customData 
                || oldPainter.doubleData != doubleData 
                || oldPainter.chartStyle != chartStyle 
                || oldPainter.pointerPosition != pointerPosition;
        }

        return true;
    }

    void _drawLineSegment(Canvas canvas, Paint paint, double x1, double y1, double x2, double y2) 
    => canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);

    static TextPainter _createAndLayoutTextPainter(String text, ChartStyle style, [double? textScale])
    {
        final TextPainter tp = TextPainter(
            textScaler: textScale == null ? TextScaler.noScaling : TextScaler.linear(textScale),
            text: TextSpan(style: TextStyle(color: style.textColor, fontSize: style.fontSize), text: text),
            textDirection: TextDirection.ltr
        );
        tp.layout();
        return tp;
    }

    DoubleMinMax _calcGraphMinMax(Size size, List<TextPainter> xAxisPainters, List<TextPainter> yAxisPainters)
    {
        final double maxYAxisPainterWidth = _calcMaxPainterWidth(yAxisPainters);
        final double chartStartX = maxYAxisPainterWidth + paddingBetweenTickLabelAndTickLineX + tickLineLengthX;
        final double chartEndX = size.width - maxYAxisPainterWidth - paddingBetweenTickLabelAndTickLineX - tickLineLengthX;

        final double maxXAxisPainterHeight = _calcMaxPainterHeight(xAxisPainters);
        final double chartStartY = maxXAxisPainterHeight + tickLineLengthY + paddingBetweenTickLabelAndTickLineY;
        final double chartEndY = size.height - maxXAxisPainterHeight - tickLineLengthY - paddingBetweenTickLabelAndTickLineY;

        /*logDebug('maxYAxisPainterWidth:  $maxYAxisPainterWidth');
        logDebug('maxXAxisPainterHeight: $maxXAxisPainterHeight');
        logDebug('chartStartX:           $chartStartX');
        logDebug('chartEndX:             $chartEndX');
        logDebug('chartStartY:           $chartStartY');
        logDebug('chartEndY:             $chartEndY');*/

        return DoubleMinMax(
            minX: chartStartX,
            maxX: chartEndX,
            minY: chartStartY,
            maxY: chartEndY
        );
    }

    double _calcMaxPainterHeight<T>(List<TextPainter> painters)
    {
        double maxHeight = 0;

        for (int i = 0; i < painters.length; i++)
            maxHeight = max(maxHeight, painters[i].height);

        return maxHeight;
    }

    double _calcMaxPainterWidth<T>(List<TextPainter> painters)
    {
        double maxWidth = 0;

        for (int i = 0; i < painters.length; i++)
            maxWidth = max(maxWidth, painters[i].width);

        return maxWidth;
    }

    void _paintTextPaintersLeft<T>(PaintInfo paintInfo, List<PositionedTextPainter<T>> painters)
    {
        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter<T> painter = painters[i];
            final TextPainter? textPainter = painter.textPainter;

            if (painter.linePosition > paintInfo.graphMinMax.minY && painter.linePosition < paintInfo.graphMinMax.maxY)
            {
                final Paint gridPaint = textPainter == null ? paintInfo.gridPaint2 : paintInfo.gridPaint;
                _drawLineSegment(paintInfo.canvas, gridPaint, paintInfo.graphMinMax.minX, painter.linePosition, paintInfo.graphMinMax.maxX, painter.linePosition);
            }

            if (textPainter != null)
            {
                _drawLineSegment(paintInfo.canvas, paintInfo.borderPaint, paintInfo.graphMinMax.minX - tickLineLengthX, painter.linePosition, paintInfo.graphMinMax.minX, painter.linePosition);
                textPainter.paint(paintInfo.canvas, Offset(paintInfo.graphMinMax.minX - tickLineLengthX - paddingBetweenTickLabelAndTickLineX - textPainter.width, painter.textPosition - textPainter.height / 2));
            }
        }
    }

    void _paintTextPaintersTop<T>(PaintInfo paintInfo, List<PositionedTextPainter<T>> painters)
    {
        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter<T> painter = painters[i];
            final TextPainter? textPainter = painter.textPainter;
            if (textPainter != null)
            {
                _drawLineSegment(paintInfo.canvas, paintInfo.borderPaint, painter.linePosition, paintInfo.graphMinMax.minY - tickLineLengthY, painter.linePosition, paintInfo.graphMinMax.minY);
                textPainter.paint(paintInfo.canvas, Offset(painter.textPosition - textPainter.width / 2, paintInfo.graphMinMax.minY - tickLineLengthY - paddingBetweenTickLabelAndTickLineY - textPainter.height));
            }
        }
    }

    void _paintTextPaintersRight<T>(PaintInfo paintInfo, List<PositionedTextPainter<T>> painters)
    {
        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter<T> painter = painters[i];
            final TextPainter? textPainter = painter.textPainter;
            if (textPainter != null)
            {
                _drawLineSegment(paintInfo.canvas, paintInfo.borderPaint, paintInfo.graphMinMax.maxX, painter.linePosition, paintInfo.graphMinMax.maxX + tickLineLengthX, painter.linePosition);
                textPainter.paint(paintInfo.canvas, Offset(paintInfo.graphMinMax.maxX + tickLineLengthX + paddingBetweenTickLabelAndTickLineX, painter.textPosition - textPainter.height / 2));
            }
        }
    }

    void _paintTextPaintersBottom<T>(PaintInfo paintInfo, List<PositionedTextPainter<T>> painters)
    {
        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter<T> painter = painters[i];
            final TextPainter? textPainter = painter.textPainter;

            if (painter.linePosition > paintInfo.graphMinMax.minX && painter.linePosition < paintInfo.graphMinMax.maxX)
            {
                final Paint gridPaint = textPainter == null ? paintInfo.gridPaint2 : paintInfo.gridPaint;
                _drawLineSegment(paintInfo.canvas, gridPaint, painter.linePosition, paintInfo.graphMinMax.minY, painter.linePosition, paintInfo.graphMinMax.maxY);
            }

            if (textPainter != null)
            {
                _drawLineSegment(paintInfo.canvas, paintInfo.borderPaint, painter.linePosition, paintInfo.graphMinMax.maxY, painter.linePosition, paintInfo.graphMinMax.maxY + tickLineLengthY);
                textPainter.paint(paintInfo.canvas, Offset(painter.textPosition - textPainter.width / 2, paintInfo.graphMinMax.maxY + tickLineLengthY + paddingBetweenTickLabelAndTickLineY));
            }
        }
    }

    ClosestLineInfo? _calcClosestLine(PaintInfo paintInfo)
    {
        ClosestLineInfo? closestLine;

        for (int lineIndex = 0; lineIndex < doubleData.lines.size; lineIndex++)
        {
            final DoubleLineData currentLine = doubleData.lines[lineIndex];
            final ClosestPointInfo? closestPointOfCurrentLine = _calcClosestPoint(paintInfo, currentLine);
            if (_isCloser(closestPointOfCurrentLine?.distance, closestLine?.closestPoint.distance))
                closestLine = ClosestLineInfo(closestPoint: closestPointOfCurrentLine!, lineIndex: lineIndex);
        }

        return closestLine;
    }

    void _drawLines(PaintInfo paintInfo, ClosestLineInfo? closestLine)
    {
        for (int lineIndex = 0; lineIndex < doubleData.lines.size; lineIndex++)
        {
            final DoubleLineData line = doubleData.lines[lineIndex];

            Color color;
            if (lineIndex < 0 || lineIndex >= doubleData.colors.size)
            {
                logError('GenericLineChartPainter.linePaint() lineIndex: $lineIndex out of range for colors.size: ${doubleData.colors.size}');
                color = Colors.black;
            }
            else
                color = doubleData.colors[lineIndex];

            _drawLine(paintInfo, line, color);
        }

        if (closestLine != null && closestLine.closestPoint.distance.dx < highlightDistanceX && closestLine.closestPoint.distance.dy < highlightDistanceY)
        {
            final DoubleLineData line = doubleData.lines[closestLine.lineIndex];

            Color color;
            if (closestLine.lineIndex < 0 || closestLine.lineIndex >= doubleData.colors.size)
            {
                logError('GenericLineChartPainter.linePaint() lineIndex: ${closestLine.lineIndex} out of range for colors.size: ${doubleData.colors.size}');
                color = Colors.black;
            }
            else
                color = doubleData.colors[closestLine.lineIndex];

            _drawLine(paintInfo, line, color, highlightIndex: closestLine.closestPoint.pointIndex);
        }
    }

    ClosestPointInfo? _calcClosestPoint(PaintInfo paintInfo, DoubleLineData line)
    {
        if (pointerPosition == null)
            return null;

        final DataTools dataTools = DataTools(doubleData.minMax, paintInfo.graphMinMax);
        double lastX = dataTools.dataToPixelX(line.points[0].x);
        double lastY = dataTools.dataToPixelY(line.points[0].y);

        final Offset distance = _calcDistanceToPoint(lastX, lastY, pointerPosition!);
        ClosestPointInfo? closestPoint = ClosestPointInfo(
            distance: distance,
            pointIndex: 0,
            position: Offset(lastX, lastY)
        );

        for (int pointIndex = 1; pointIndex < line.points.size; pointIndex++)
        {
            final double currentX = dataTools.dataToPixelX(line.points[pointIndex].x);
            final double currentY = dataTools.dataToPixelY(line.points[pointIndex].y);

            final Offset distance = _calcDistanceToPoint(currentX, currentY, pointerPosition!);
            if (_isCloser(distance, closestPoint?.distance))
            {
                closestPoint = ClosestPointInfo(
                    distance: distance,
                    pointIndex: pointIndex,
                    position: Offset(currentX, currentY)
                );
            }

            lastX = currentX;
            lastY = currentY;
        }

        return closestPoint;
    }

    void _drawLine(PaintInfo paintInfo, DoubleLineData line, Color color, {int? highlightIndex})
    {
        final DataTools dataTools = DataTools(doubleData.minMax, paintInfo.graphMinMax);
        double lastX = dataTools.dataToPixelX(line.points[0].x);
        double lastY = dataTools.dataToPixelY(line.points[0].y);

        final double lineWidth = highlightIndex == null ? chartStyle.lineWidth : 2 * chartStyle.lineWidth;
        final Paint linePaint = _createPaint(color, strokeWidth: lineWidth, paintingStyle: PaintingStyle.fill);
        final double pointRadius = highlightIndex == null ? chartStyle.pointRadius : highlightIndex == 0 ? 2 * chartStyle.pointRadius : 1.5 * chartStyle.pointRadius;
        paintInfo.canvas.drawCircle(Offset(lastX, lastY), pointRadius, linePaint);

        for (int pointIndex = 1; pointIndex < line.points.size; pointIndex++)
        {
            final double currentX = dataTools.dataToPixelX(line.points[pointIndex].x);
            final double currentY = dataTools.dataToPixelY(line.points[pointIndex].y);

            _drawLineSegment(paintInfo.canvas, linePaint, lastX, lastY, currentX, currentY);

            final double pointRadius = highlightIndex == null ? chartStyle.pointRadius : highlightIndex == pointIndex ? 2 * chartStyle.pointRadius : 1.5 * chartStyle.pointRadius;
            paintInfo.canvas.drawCircle(Offset(currentX, currentY), pointRadius, linePaint);

            lastX = currentX;
            lastY = currentY;
        }
    }

    void _showError(Canvas canvas, Size size, String s)
    {
        final DoubleMinMax graphMinMax = _calcGraphMinMax(size, <TextPainter>[], <TextPainter>[]);
        canvas.drawRect(Rect.fromLTRB(graphMinMax.minX, graphMinMax.minY, graphMinMax.maxX, graphMinMax.maxY), _createBorderPaint());

        final TextPainter tp = _createAndLayoutTextPainter(s, chartStyle, 1.5);
        tp.paint(canvas, Offset(size.width / 2 - tp.width / 2, size.height / 2 - tp.height / 2));
    }

    Paint _createDataTipBackgroundPaint()
    => _createPaint(brightness == Brightness.dark ? chartStyle.dataTipBackgroundColorDark : chartStyle.dataTipBackgroundColor, paintingStyle: PaintingStyle.fill);

    Paint _createBorderPaint()
    => _createPaint(brightness == Brightness.dark ? chartStyle.borderColorDark : chartStyle.borderColor);

    Paint _createGridPaint() 
    => _createPaint((brightness == Brightness.dark ? chartStyle.gridColorDark : chartStyle.gridColor).withAlpha(128));

    Paint _createGridPaint2()
    => _createPaint((brightness == Brightness.dark ? chartStyle.gridColorDark : chartStyle.gridColor).withAlpha(32));

    Paint _createPaint(Color color, {double strokeWidth = 1, PaintingStyle paintingStyle = PaintingStyle.stroke})
    {
        final Paint paint = Paint()
            ..color = color
            //..strokeWidth = 1
            ..strokeWidth = strokeWidth //1 / chartStyle.devicePixelRatio
            ..style = paintingStyle;

        return paint;
    }

    List<PositionedTextPainter<TX>> _createXAxisTicks(DoubleMinMax graphMinMax)
    => _createAxisTicks<TX>(graphMinMax, customData.toolsX, Axis.horizontal);

    List<PositionedTextPainter<TY>> _createYAxisTicks(DoubleMinMax graphMinMax)
    => _createAxisTicks<TY>(graphMinMax, customData.toolsY, Axis.vertical);

    List<PositionedTextPainter<T>> _createAxisTicks<T>(DoubleMinMax graphMinMax, GenericTools<T> tools, Axis axis)
    {
        if (DEBUG)
            logDebug('_createAxisTicks(axis: $axis)');

        final DataTools dataTools = DataTools(doubleData.minMax, graphMinMax);

        final List<PositionedTextPainter<T>> tickPainters = <PositionedTextPainter<T>>[];

        final T customDataMin = axis == Axis.horizontal ? customData.minMax.minX as T : customData.minMax.minY as T;
        final T customDataMax = axis == Axis.horizontal ? customData.minMax.maxX as T : customData.minMax.maxY as T;
        final T customDataFirst = tools.getNextNiceCustomValueOrSame(customDataMin);
        final T customDataLast = tools.getPreviousNiceCustomValueOrSame(customDataMax);
        if (DEBUG)
        {
            logDebug('  customDataMin:   $customDataMin');
            logDebug('  customDataFirst: $customDataFirst');
            logDebug('  customDataLast:  $customDataLast');
            logDebug('  customDataMax:   $customDataMax');
        }

        double textPositionMin = axis == Axis.horizontal ? graphMinMax.minX - additionalSpaceForLabelX : graphMinMax.minY - additionalSpaceForLabelY;
        double textPositionMax = axis == Axis.horizontal ? graphMinMax.maxX + additionalSpaceForLabelX : graphMinMax.maxY + additionalSpaceForLabelY;
        if (DEBUG)
        {
            logDebug('  textPositionMin: $textPositionMin');
            logDebug('  textPositionMax: $textPositionMax');
        }

        final PositionedTextPainter<T>? lastPainter = _createTickPainter<T>(
            dataTools,
            chartStyle,
            tools,
            axis: axis,
            textPositionMin: textPositionMin,
            textPositionMax: textPositionMax,
            customDataValue: customDataLast,
            isLast: true
        );

        if (lastPainter == null)
        {
            if (DEBUG)
                logInfo('    No tick painter for $customDataLast');

            return tickPainters;
        }

        if (lastPainter.textPainter == null)
        {
            if (DEBUG)
                logInfo('    No text-tick painter for $customDataLast');

            tickPainters.add(lastPainter);
        }
        else
        {
            if (DEBUG)
                logDebug('    Tick painter for $customDataLast at ${lastPainter.linePosition.toStringAsFixed(1)} // ${lastPainter.textStart.toStringAsFixed(1)} / ${lastPainter.textPosition.toStringAsFixed(1)} / ${lastPainter.textEnd.toStringAsFixed(1)}');

            tickPainters.add(lastPainter);
            if (axis == Axis.horizontal)
                textPositionMax = lastPainter.textStart.floorToDouble();
            else
                textPositionMin = lastPainter.textEnd.ceilToDouble();
        }

        T customDataValue = customDataFirst;

        int count = 0;
        while (true)
        {
            count++;

            if (count > 100)
            {
                logWarning('Too many ticks!');
                break;
            }

            if (DEBUG)
            {
                logDebug('Tick #$count: $customDataValue');
                logDebug('  textPositionMin:  ${textPositionMin.toStringAsFixed(1)}');
                logDebug('  textPositionMax:  ${textPositionMax.toStringAsFixed(1)}');
            }

            final PositionedTextPainter<T>? tickPainter = _createTickPainter<T>(
                dataTools,
                chartStyle,
                tools,
                axis: axis,
                textPositionMin: textPositionMin,
                textPositionMax: textPositionMax,
                customDataValue: customDataValue,
                isFirst: count == 1
            );

            if (tickPainter == null)
            {
                logInfo('    No tick painter for $customDataValue');
                break;
            }

            if (tickPainter.textPainter == null)
            {
                tickPainters.add(tickPainter);
                if (DEBUG)
                    logInfo('    No text-tick painter for $customDataValue');

                if (axis == Axis.horizontal)
                {
                    if (tickPainter.linePosition >= graphMinMax.maxX)
                        break;
                }
                else
                {
                    if (tickPainter.linePosition <= graphMinMax.minY)
                        break;
                }
            }
            else
            {
                if (DEBUG)
                    logDebug('    Tick painter for $customDataValue at ${tickPainter.linePosition.toStringAsFixed(1)} // ${tickPainter.textStart.toStringAsFixed(1)} / ${tickPainter.textPosition.toStringAsFixed(1)} / ${tickPainter.textEnd.toStringAsFixed(1)}');

                tickPainters.add(tickPainter);
                if (axis == Axis.horizontal)
                    textPositionMin = tickPainter.textEnd.ceilToDouble() + paddingBetweenTicksX;
                else
                    textPositionMax = tickPainter.textStart.floorToDouble() - paddingBetweenTicksY;
            }

            customDataValue = tools.getNextNiceCustomValue(customDataValue);
        }

        return tickPainters;
    }

    static PositionedTextPainter<T>? _createTickPainter<T>(
        DataTools dataTools,
        ChartStyle chartStyle,
        GenericTools<T> tools, {
            required Axis axis,
            required double textPositionMax,
            required double textPositionMin,
            required T customDataValue,
            bool isFirst = false,
            bool isLast = false
        }
    )
    {
        final double doubleDataValue = tools.toDoubleValue(customDataValue);
        final TextPainter textPainter = _createAndLayoutTextPainter(tools.format(customDataValue), chartStyle);
        final double textPosition = axis == Axis.horizontal ? dataTools.dataToPixelX(doubleDataValue) : dataTools.dataToPixelY(doubleDataValue);
        final double textPositionStart = textPosition - (axis == Axis.horizontal ? textPainter.width : textPainter.height) / 2;
        final double textPositionEnd = textPosition + (axis == Axis.horizontal ? textPainter.width : textPainter.height) / 2;

        final double overflowMin = textPositionMin - textPositionStart;
        if (overflowMin > 0)
        {
            if (DEBUG)
                logDebug('textPositionStart ($textPositionStart) < textPositionMin ($textPositionMin)');

            if (!isFirst)
                return PositionedTextPainter<T>(linePosition: textPosition, textPosition: textPosition, textPainter: null);

            return PositionedTextPainter<T>(linePosition: textPosition, textPosition: textPosition + overflowMin, textPainter: textPainter);
        }

        final double overflowMax = textPositionEnd - textPositionMax;
        if (overflowMax > 0)
        {
            if (DEBUG)
                logDebug('textPositionEnd ($textPositionEnd) > textPositionMax ($textPositionMax)');

            if (!isLast)
                return PositionedTextPainter<T>(linePosition: textPosition, textPosition: textPosition, textPainter: null);

            return PositionedTextPainter<T>(linePosition: textPosition, textPosition: textPosition - overflowMax, textPainter: textPainter);
        }

        return PositionedTextPainter<T>(linePosition: textPosition, textPosition: textPosition, textPainter: textPainter);
    }

    void _drawDataTip(PaintInfo paintInfo, String label, ClosestPointInfo closestPoint)
    {
        if (pointerPosition == null)
            return;

        final double closestX = closestPoint.position.dx;
        final double closestY = closestPoint.position.dy;

        final DataTools dataTools = DataTools(doubleData.minMax, paintInfo.graphMinMax);
        if (dataTools.pixelToDataX(pointerPosition!.dx + tickLineLengthX) < doubleData.minMax.minX
            || dataTools.pixelToDataX(pointerPosition!.dx - tickLineLengthX) > doubleData.minMax.maxX
            || dataTools.pixelToDataY(pointerPosition!.dy - tickLineLengthY) < doubleData.minMax.minY
            || dataTools.pixelToDataY(pointerPosition!.dy + tickLineLengthY) > doubleData.minMax.maxY)
            return;

        final TX customDataX = customData.toolsX.toCustomValue(dataTools.pixelToDataX(closestX));
        final TY customDataY = customData.toolsY.toCustomValue(dataTools.pixelToDataY(closestY));
        final String customDataXString = customData.toolsX.formatDataTip(customDataX);
        final String customDataYString = customData.toolsY.formatDataTip(customDataY);

        final String dataTipText = dataTipFormat.replaceFirst('%s', label).replaceFirst('%x', customDataXString).replaceFirst('%y', customDataYString);
        final TextPainter textPainter = _createAndLayoutTextPainter(dataTipText, chartStyle);

        final double dataTipWidth = textPainter.width + 2 * dataTipPaddingX;
        final double dataTipHeight = textPainter.height + 2 * dataTipPaddingY;

        final double candidateLeft = pointerPosition!.dx + dataTipPointerGapRight;
        final double candidateTop = pointerPosition!.dy + dataTipPointerGapBottom;

        double finalDataTipLeft = candidateLeft;
        double finalDataTipTop = candidateTop;

        if (candidateLeft + dataTipWidth > paintInfo.size.width)
            finalDataTipLeft = pointerPosition!.dx - dataTipWidth - dataTipPointerGapLeft;

        if (candidateTop + dataTipHeight > paintInfo.size.height)
            finalDataTipTop = pointerPosition!.dy - dataTipHeight - dataTipPointerGapTop;

        final RRect rRect = RRect.fromRectAndRadius(
            Rect.fromLTWH(finalDataTipLeft, finalDataTipTop, dataTipWidth, dataTipHeight),
            const Radius.circular(4)
        );

        paintInfo.canvas.drawRRect(rRect, paintInfo.borderPaint);
        paintInfo.canvas.drawRRect(rRect, paintInfo.dataTipBackgroundPaint);
        textPainter.paint(paintInfo.canvas, Offset(finalDataTipLeft + dataTipPaddingX, finalDataTipTop + dataTipPaddingY));
    }

    Offset _calcDistanceToPoint(double x, double y, Offset point)
    => Offset((point.dx - x).abs(), (point.dy - y).abs());

    /// Returns true if the first offset is closer to the pointer position than the second offset.
    bool _isCloser(Offset? offset1, Offset? offset2)
    {
        if (offset1 == null)
            return false;

        if (offset2 == null)
            return true;

        return offset1.distanceSquared < offset2.distanceSquared;
    }
}
