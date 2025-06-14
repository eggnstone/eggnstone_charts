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
import '../Specifics/DoubleDataSeries.dart';
import '../Specifics/DoubleMinMax.dart';
import 'GenericChartData.dart';
import 'GenericDataSeries.dart';
import 'GenericTools.dart';

typedef ClosestLineCalculatedCallback = void Function(ClosestLineInfo? closestLine);
typedef DataToolsAvailableCallback = void Function(DataTools dataTools);

/// A painter for drawing a generic line chart with customizable data types.
class GenericLineChartPainter<TX, TY> extends CustomPainter
{
    static const bool DEBUG = false;
    static const bool DEBUG_DATA_TO_PIXEL = false;
    static const bool DEBUG_TICKS = false;
    static const bool DEBUG_TICKS_INTERVAL = false;
    static const bool DEBUG_TICKS_CLEAN_UP = false;

    static const double additionalSpaceForLabelX = paddingBetweenTickLabelAndTickLineX + tickLineLengthX;
    static const double paddingBetweenTickLabelAndTickLineX = 2;
    static const double paddingBetweenTicksX = 6;
    static const double tickLineLengthX = 8;

    static const double additionalSpaceForLabelY = paddingBetweenTickLabelAndTickLineY + tickLineLengthY;
    static const double paddingBetweenTickLabelAndTickLineY = 0;
    static const double paddingBetweenTicksY = 4;
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
    final String dataTipFormat2;
    final DoubleChartData doubleData;
    final double highlightDistance;
    final bool invertXAxis;
    final bool invertYAxis;
    final Offset? pointerPosition;
    final bool showTicksBottom;
    final bool showTicksLeft;
    final bool showTicksRight;
    final bool showTicksTop;
    final ClosestLineCalculatedCallback? onClosestLineCalculated;
    final DataToolsAvailableCallback? onDataToolsAvailable;

    GenericLineChartPainter({
        required this.chartStyle,
        required this.customData,
        required this.doubleData,
        this.brightness,
        this.dataTipFormat = '%s\nX: %x\nY: %y',
        this.dataTipFormat2 = '%s',
        this.highlightDistance = 20,
        this.invertXAxis = false,
        this.invertYAxis = false,
        this.pointerPosition,
        this.showTicksBottom = true,
        this.showTicksLeft = true,
        this.showTicksRight = false,
        this.showTicksTop = false,
        this.onClosestLineCalculated,
        this.onDataToolsAvailable
    });

    @override
    void paint(Canvas canvas, Size size)
    {
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

    ClosestPointInfo? _calcClosestDataPoint(PaintInfo paintInfo, DataTools dataTools, DoubleDataSeries dataSeries)
    {
        if (dataSeries.points.isEmpty())
            return null;

        double lastX = dataTools.dataToPixelX(dataSeries.points[0].x);
        double lastY = dataTools.dataToPixelY(dataSeries.points[0].y);

        final double distance = _calcDistanceToPoint(lastX, lastY, pointerPosition!);
        ClosestPointInfo closestPoint = ClosestPointInfo(
            distance: distance,
            pointIndex: 0,
            position: Offset(lastX, lastY)
        );

        for (int pointIndex = 1; pointIndex < dataSeries.points.size; pointIndex++)
        {
            final double currentX = dataTools.dataToPixelX(dataSeries.points[pointIndex].x);
            final double currentY = dataTools.dataToPixelY(dataSeries.points[pointIndex].y);

            final double distance = _calcDistanceToPoint(currentX, currentY, pointerPosition!);
            if (distance < closestPoint.distance)
                closestPoint = ClosestPointInfo(
                    distance: distance,
                    pointIndex: pointIndex,
                    position: Offset(currentX, currentY)
                );

            lastX = currentX;
            lastY = currentY;
        }

        return closestPoint;
    }

    double _calcDistanceBetweenPoints(double x1, double y1, double x2, double y2)
    => sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));

    double _calcDistanceToPoint(double x, double y, Offset point)
    => Offset((point.dx - x).abs(), (point.dy - y).abs()).distance;

    ClosestLineInfo? _calcClosestLine(PaintInfo paintInfo, DataTools dataTools)
    {
        if (pointerPosition == null)
            return null;

        ClosestLineInfo? closestLineByDataPoints;
        ClosestLineInfo? closestLineByLinePoints;

        for (int lineIndex = 0; lineIndex < doubleData.dataSeriesList.size; lineIndex++)
        {
            closestLineByDataPoints = _calcClosestLineByDataPoints(paintInfo, dataTools, closestLineSoFar: closestLineByDataPoints, currentLine: doubleData.dataSeriesList[lineIndex], lineIndex: lineIndex);
            closestLineByLinePoints = _calcClosestLineByLinePoints(paintInfo, dataTools, closestLineSoFar: closestLineByLinePoints, currentLine: doubleData.dataSeriesList[lineIndex], lineIndex: lineIndex);
        }

        if (closestLineByDataPoints == null)
            return null;

        if (closestLineByDataPoints.closestPoint.distance < highlightDistance)
            return closestLineByDataPoints;

        if (closestLineByLinePoints == null)
            return null;

        if (closestLineByLinePoints.closestPoint.distance < highlightDistance)
            return closestLineByLinePoints;

        return null;
    }

    ClosestLineInfo? _calcClosestLineByDataPoints(PaintInfo paintInfo, DataTools dataTools, {required ClosestLineInfo? closestLineSoFar, required DoubleDataSeries currentLine, required int lineIndex})
    {
        final ClosestPointInfo? closestPointOfCurrentLine = _calcClosestDataPoint(paintInfo, dataTools, currentLine);
        if (closestPointOfCurrentLine == null)
            return closestLineSoFar;

        if (closestLineSoFar == null || closestPointOfCurrentLine.distance < closestLineSoFar.closestPoint.distance)
            return ClosestLineInfo(
                closestPoint: closestPointOfCurrentLine,
                lineIndex: lineIndex
            );

        return closestLineSoFar;
    }

    ClosestLineInfo? _calcClosestLineByLinePoints(PaintInfo paintInfo, DataTools dataTools, {required ClosestLineInfo? closestLineSoFar, required DoubleDataSeries currentLine, required int lineIndex})
    {
        final ClosestPointInfo? closestPointOfCurrentLine = _calcClosestLinePoint(paintInfo, dataTools, currentLine);
        if (closestPointOfCurrentLine == null)
            return closestLineSoFar;

        if (closestLineSoFar == null || closestPointOfCurrentLine.distance < closestLineSoFar.closestPoint.distance)
            return ClosestLineInfo(
                closestPoint: closestPointOfCurrentLine,
                lineIndex: lineIndex
            );

        return closestLineSoFar;
    }

    ClosestPointInfo? _calcClosestLinePoint(PaintInfo paintInfo, DataTools dataTools, DoubleDataSeries dataSeries)
    {
        double lastX = dataTools.dataToPixelX(dataSeries.points[0].x);
        double lastY = dataTools.dataToPixelY(dataSeries.points[0].y);

        ClosestPointInfo? closestPoint;
        for (int pointIndex = 1; pointIndex < dataSeries.points.size; pointIndex++)
        {
            final double currentX = dataTools.dataToPixelX(dataSeries.points[pointIndex].x);
            final double currentY = dataTools.dataToPixelY(dataSeries.points[pointIndex].y);

            final Offset? intersection = _projectFromPointOnLine(pointerPosition!.dx, pointerPosition!.dy, lastX, lastY, currentX, currentY);
            if (intersection != null)
            {
                final double distance = _calcDistanceBetweenPoints(pointerPosition!.dx, pointerPosition!.dy, intersection.dx, intersection.dy);
                if (closestPoint == null || distance < closestPoint.distance)
                    closestPoint = ClosestPointInfo(
                        distance: distance,
                        pointIndex: null,
                        position: intersection
                    );
            }

            lastX = currentX;
            lastY = currentY;
        }

        return closestPoint;
    }

    static DoubleMinMax _calcGraphMinMax(
        Size size,
        List<TextPainter> xAxisPainters,
        List<TextPainter> yAxisPainters, {
            bool showTicksBottom = false,
            bool showTicksLeft = false,
            bool showTicksRight = false,
            bool showTicksTop = false
        }
    )
    {
        double chartStartX = showTicksBottom || showTicksTop ? additionalSpaceForLabelX : 1;
        double chartEndX = showTicksBottom || showTicksTop ? size.width - additionalSpaceForLabelX : size.width - 1;
        if (showTicksLeft || showTicksRight)
        {
            final double maxYAxisPainterWidth = _calcMaxPainterWidth(yAxisPainters);

            if (showTicksLeft)
                chartStartX = maxYAxisPainterWidth + additionalSpaceForLabelX;

            if (showTicksRight)
                chartEndX = size.width - maxYAxisPainterWidth - additionalSpaceForLabelX;
        }

        double chartStartY = showTicksLeft || showTicksRight ? additionalSpaceForLabelY : 1;
        double chartEndY = showTicksLeft || showTicksRight ? size.height - additionalSpaceForLabelY : size.height - 1;
        if (showTicksBottom || showTicksTop)
        {
            final double maxXAxisPainterHeight = _calcMaxPainterHeight(xAxisPainters);

            if (showTicksTop)
                chartStartY = maxXAxisPainterHeight + additionalSpaceForLabelY;

            if (showTicksBottom)
                chartEndY = size.height - maxXAxisPainterHeight - additionalSpaceForLabelY;
        }

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

    static double _calcMaxPainterHeight<T>(List<TextPainter> painters)
    {
        double maxHeight = 0;

        for (int i = 0; i < painters.length; i++)
            maxHeight = max(maxHeight, painters[i].height);

        return maxHeight;
    }

    static double _calcMaxPainterWidth<T>(List<TextPainter> painters)
    {
        double maxWidth = 0;

        for (int i = 0; i < painters.length; i++)
            maxWidth = max(maxWidth, painters[i].width);

        return maxWidth;
    }

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

    List<PositionedTextPainter<T>> _createAxisTicks<T>(DataTools dataTools, DoubleMinMax graphMinMax, GenericTools<T> tools, Axis axis)
    {
        if (DEBUG_TICKS || DEBUG_TICKS_INTERVAL || DEBUG_TICKS_CLEAN_UP)
            logDebug('_createAxisTicks(axis: $axis)');

        final bool invertLoop = axis == Axis.horizontal && invertXAxis || axis == Axis.vertical && invertYAxis;
        final T customDataMin = axis == Axis.horizontal ? customData.minMax.minX as T : customData.minMax.minY as T;
        final T customDataMax = axis == Axis.horizontal ? customData.minMax.maxX as T : customData.minMax.maxY as T;
        final T customDataFirst = tools.getNextNiceCustomValueOrSame(customDataMin);
        final T customDataLast = tools.getPreviousNiceCustomValueOrSame(customDataMax);
        if (DEBUG_TICKS)
        {
            logDebug('  customDataMin:   $customDataMin');
            logDebug('  customDataFirst: $customDataFirst');
            logDebug('  customDataLast:  $customDataLast');
            logDebug('  customDataMax:   $customDataMax');
        }

        double textPositionMin = axis == Axis.horizontal
            ? graphMinMax.minX - additionalSpaceForLabelX
            : graphMinMax.minY - additionalSpaceForLabelY;

        double textPositionMax = axis == Axis.horizontal
            ? graphMinMax.maxX + additionalSpaceForLabelX
            : graphMinMax.maxY + additionalSpaceForLabelY;

        if (DEBUG_TICKS)
        {
            logDebug('  textPositionMin: $textPositionMin');
            logDebug('  textPositionMax: $textPositionMax');
        }

        final PositionedTextPainter<T> lastPainter = _createTickPainter<T>(
            dataTools,
            chartStyle,
            tools,
            axis: axis,
            textPositionMin: textPositionMin,
            textPositionMax: textPositionMax,
            customDataValue: customDataLast,
            isLast: true
        );

        if (DEBUG_TICKS)
            logDebug('    Last tick painter for $customDataLast at ${lastPainter.linePosition.toStringAsFixed(1)} / ${lastPainter.textPosition.toStringAsFixed(1)}');

        T customDataValue = customDataFirst;
        if (axis == Axis.horizontal)
            textPositionMax = lastPainter.textStartX.floorToDouble() - paddingBetweenTicksX;
        else
            textPositionMin = lastPainter.textEndY.ceilToDouble() + paddingBetweenTicksY;

        final List<PositionedTextPainter<T>> tickPainters = <PositionedTextPainter<T>>[];
        for (int count = 0; count < 1000; count++)
        {
            if (DEBUG_TICKS)
            {
                logDebug('Tick #$count: $customDataValue');
                logDebug('  textPositionMin:  ${textPositionMin.toStringAsFixed(1)}');
                logDebug('  textPositionMax:  ${textPositionMax.toStringAsFixed(1)}');
            }

            final PositionedTextPainter<T> tickPainter = _createTickPainter<T>(
                dataTools,
                chartStyle,
                tools,
                axis: axis,
                textPositionMin: textPositionMin,
                textPositionMax: textPositionMax,
                customDataValue: customDataValue,
                isFirst: count == 0
            );

            if (DEBUG_TICKS)
                logDebug('    Tick painter for $customDataValue at ${tickPainter.linePosition.toStringAsFixed(1)} / ${tickPainter.textPosition.toStringAsFixed(1)}');

            if (axis == Axis.horizontal)
            {
                if (tickPainter.linePosition >= graphMinMax.maxX)
                    break;

                textPositionMin = tickPainter.textEndX.ceilToDouble() + paddingBetweenTicksX;
            }
            else
            {
                if (tickPainter.linePosition <= graphMinMax.minY)
                    break;

                textPositionMax = tickPainter.textStartY.floorToDouble() - paddingBetweenTicksY;
            }

            tickPainters.add(tickPainter);
            customDataValue = tools.getNextNiceCustomValue(customDataValue);
        }

        // Add the last tick painter after the loop
        tickPainters.add(lastPainter);

        if (tickPainters.length <= 2)
            return tickPainters;

        final double finalTextPositionMin = axis == Axis.horizontal
            ? tickPainters.first.textEndX + paddingBetweenTicksX
            : tickPainters.last.textEndY + paddingBetweenTicksY;

        final double finalTextPositionMax = axis == Axis.horizontal
            ? tickPainters.last.textStartX - paddingBetweenTicksX
            : tickPainters.first.textStartY - paddingBetweenTicksY;

        if (DEBUG_TICKS_INTERVAL)
            logDebug('  Checking intervals');

        // Find an interval that yields no overlaps and remove non-fitting text painters
        bool foundInterval = false;
        int interval;
        for (interval = 1; interval <= 100; interval++)
        {
            if (DEBUG_TICKS_INTERVAL)
                logDebug('    Checking interval: $interval');

            double currentTextPositionMin = finalTextPositionMin;
            double currentTextPositionMax = finalTextPositionMax;
            bool overlaps = false;
            for (int i = interval; i < tickPainters.length - 1; i += interval)
            {
                final int actualIndex = invertLoop ? tickPainters.length - 1 - i : i;
                final PositionedTextPainter<T> currentPainter = tickPainters[actualIndex];

                if (axis == Axis.horizontal)
                {
                    if (currentPainter.textStartX < currentTextPositionMin || currentPainter.textEndX > currentTextPositionMax)
                    {
                        overlaps = true;
                        break;
                    }
                }
                else
                {
                    if (currentPainter.textStartY < currentTextPositionMin || currentPainter.textEndY > currentTextPositionMax)
                    {
                        overlaps = true;
                        break;
                    }
                }

                // TODO: what about invert?
                if (axis == Axis.horizontal && !invertXAxis)
                    currentTextPositionMin = currentPainter.textEndX.ceilToDouble() + paddingBetweenTicksX;
                else if (axis == Axis.vertical && !invertYAxis)
                    currentTextPositionMax = currentPainter.textStartY.floorToDouble() - paddingBetweenTicksY;
            }

            if (!overlaps)
            {
                foundInterval = true;
                break;
            }
        }

        if (!foundInterval)
            return <PositionedTextPainter<T>>[tickPainters.first, tickPainters.last];

        if (DEBUG_TICKS_CLEAN_UP)
            logDebug('  Cleaning up ticks with interval: $interval');

        for (int i = 1; i < tickPainters.length - 1; i++)
        {
            final int actualIndex = invertLoop ? tickPainters.length - 1 - i : i;
            if (actualIndex % interval != 0)
                tickPainters[actualIndex] = tickPainters[actualIndex].copyWith(textPainter: null);
        }

        return tickPainters;
    }

    Paint _createBorderPaint()
    => _createPaint(brightness == Brightness.dark ? chartStyle.borderColorDark : chartStyle.borderColor);

    Paint _createDataTipBackgroundPaint()
    => _createPaint(brightness == Brightness.dark ? chartStyle.dataTipBackgroundColorDark : chartStyle.dataTipBackgroundColor, paintingStyle: PaintingStyle.fill);

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

    static PositionedTextPainter<T> _createTickPainter<T>(
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
        final double textPosition = axis == Axis.horizontal ? dataTools.dataToPixelX(doubleDataValue, useInvert: false) : dataTools.dataToPixelY(doubleDataValue, useInvert: false);
        final double textPositionStart = textPosition - (axis == Axis.horizontal ? textPainter.width : textPainter.height) / 2;
        final double textPositionEnd = textPosition + (axis == Axis.horizontal ? textPainter.width : textPainter.height) / 2;

        final double overflowMin = textPositionMin - textPositionStart;
        if (isFirst && overflowMin > 0)
            return PositionedTextPainter<T>(linePosition: textPosition, textPosition: textPosition + overflowMin, textPainter: textPainter);

        final double overflowMax = textPositionEnd - textPositionMax;
        if (isLast && overflowMax > 0)
            return PositionedTextPainter<T>(linePosition: textPosition, textPosition: textPosition - overflowMax, textPainter: textPainter);

        return PositionedTextPainter<T>(linePosition: textPosition, textPosition: textPosition, textPainter: textPainter);
    }

    List<PositionedTextPainter<TX>> _createXAxisTicks(DataTools dataTools, DoubleMinMax graphMinMax)
    => _createAxisTicks<TX>(dataTools, graphMinMax, customData.toolsX, Axis.horizontal);

    List<PositionedTextPainter<TY>> _createYAxisTicks(DataTools dataTools, DoubleMinMax graphMinMax)
    => _createAxisTicks<TY>(dataTools, graphMinMax, customData.toolsY, Axis.vertical);

    void _drawDataTip(PaintInfo paintInfo, DataTools dataTools, String label, ClosestPointInfo closestPoint)
    {
        if (pointerPosition == null)
            return;

        String dataTipText;
        if (closestPoint.pointIndex == null)
        {
            dataTipText = dataTipFormat2.replaceFirst('%s', label);
        }
        else
        {
            final double closestX = closestPoint.position.dx;
            final double closestY = closestPoint.position.dy;
            final TX customDataX = customData.toolsX.toCustomValue(dataTools.pixelToDataX(closestX));
            final TY customDataY = customData.toolsY.toCustomValue(dataTools.pixelToDataY(closestY));
            final String customDataXString = customData.toolsX.formatDataTip(customDataX);
            final String customDataYString = customData.toolsY.formatDataTip(customDataY);

            dataTipText = dataTipFormat.replaceFirst('%s', label).replaceFirst('%x', customDataXString).replaceFirst('%y', customDataYString);
        }

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

    void _drawLine(PaintInfo paintInfo, DataTools dataTools, DoubleDataSeries dataSeries, {required bool highlight, ClosestPointInfo? highlightPoint})
    {
        double lastX = dataTools.dataToPixelX(dataSeries.points[0].x);
        double lastY = dataTools.dataToPixelY(dataSeries.points[0].y);

        double lineWidth = chartStyle.lineWidth;
        if (highlight)
            if (highlightPoint == null)
                lineWidth *= 0.5;
            else
                lineWidth *= 2;

        final Paint linePaint = _createPaint(dataSeries.color, strokeWidth: lineWidth, paintingStyle: PaintingStyle.fill);

        double pointRadius = chartStyle.pointRadius;
        if (highlight)
            if (highlightPoint == null)
                pointRadius *= 0.5;
            else if (highlightPoint.pointIndex == 0)
                pointRadius *= 2;
            else
                pointRadius *= 1.5;

        paintInfo.canvas.drawCircle(Offset(lastX, lastY), pointRadius, linePaint);

        for (int pointIndex = 1; pointIndex < dataSeries.points.size; pointIndex++)
        {
            final double currentX = dataTools.dataToPixelX(dataSeries.points[pointIndex].x);
            final double currentY = dataTools.dataToPixelY(dataSeries.points[pointIndex].y);

            _drawLineSegment(paintInfo.canvas, linePaint, lastX, lastY, currentX, currentY);

            double pointRadius = chartStyle.pointRadius;
            if (highlight)
                if (highlightPoint == null)
                    pointRadius *= 0.5;
                else if (highlightPoint.pointIndex == pointIndex)
                    pointRadius *= 2;
                else
                    pointRadius *= 1.5;

            paintInfo.canvas.drawCircle(Offset(currentX, currentY), pointRadius, linePaint);

            lastX = currentX;
            lastY = currentY;
        }
    }

    void _drawLines(PaintInfo paintInfo, DataTools dataTools, ClosestLineInfo? closestLine)
    {
        int? highlightLineIndex;
        ClosestPointInfo? highlightPoint;

        final bool highlight = closestLine != null;
        if (highlight)
        {
            highlightLineIndex = closestLine.lineIndex;
            highlightPoint = closestLine.closestPoint;
        }

        for (int lineIndex = 0; lineIndex < doubleData.dataSeriesList.size; lineIndex++)
        {
            final DoubleDataSeries dataSeries = doubleData.dataSeriesList[lineIndex];
            if (lineIndex != highlightLineIndex)
                _drawLine(paintInfo, dataTools, dataSeries, highlight: highlight);
        }

        if (highlightLineIndex != null)
        {
            final DoubleDataSeries dataSeries = doubleData.dataSeriesList[highlightLineIndex];
            _drawLine(paintInfo, dataTools, dataSeries, highlight: highlight, highlightPoint: highlightPoint);
        }
    }

    void _drawLineSegment(Canvas canvas, Paint paint, double x1, double y1, double x2, double y2)
    => canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);

    void _paintHorizontalGridLines<T>(PaintInfo paintInfo, List<PositionedTextPainter<T>> painters)
    {
        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter<T> painter = painters[i];
            final TextPainter? textPainter = painter.textPainter;

            if (painter.linePosition > paintInfo.graphMinMax.minY && painter.linePosition < paintInfo.graphMinMax.maxY)
            {
                final Paint gridPaint = textPainter == null ? paintInfo.gridPaint2 : paintInfo.gridPaint;

                final double lineY = invertYAxis
                    ? paintInfo.graphMinMax.minY + paintInfo.graphMinMax.maxY - painter.linePosition 
                    : painter.linePosition;

                _drawLineSegment(paintInfo.canvas, gridPaint, paintInfo.graphMinMax.minX, lineY, paintInfo.graphMinMax.maxX, lineY);
            }
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

        if (customData.dataSeriesList.isEmpty())
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
            ],
            showTicksBottom: showTicksBottom,
            showTicksLeft: showTicksLeft,
            showTicksRight: showTicksRight,
            showTicksTop: showTicksTop
        );

        if (DEBUG)
            logDebug('  graphMinMax:       $graphMinMax');

        final DataTools dataTools = DataTools(doubleData.minMax, graphMinMax, invertXAxis: invertXAxis, invertYAxis: invertYAxis);
        onDataToolsAvailable?.call(dataTools);

        final List<PositionedTextPainter<TX>> xAxisPainters = _createXAxisTicks(dataTools, graphMinMax);
        final List<PositionedTextPainter<TY>> yAxisPainters = _createYAxisTicks(dataTools, graphMinMax);

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

        _paintTextPaintersTop(paintInfo, xAxisPainters, showTicks: showTicksTop);
        _paintTextPaintersBottom(paintInfo, xAxisPainters, showTicks: showTicksBottom);
        _paintVerticalGridLines(paintInfo, xAxisPainters);

        _paintTextPaintersLeft(paintInfo, yAxisPainters, showTicks: showTicksLeft);
        _paintTextPaintersRight(paintInfo, yAxisPainters, showTicks: showTicksRight);
        _paintHorizontalGridLines(paintInfo, yAxisPainters);

        final ClosestLineInfo? closestLine = _calcClosestLine(paintInfo, dataTools);
        onClosestLineCalculated?.call(closestLine);
        _drawLines(paintInfo, dataTools, closestLine);

        if (closestLine == null)
            return;

        final GenericDataSeries<TX, TY> dataSeries = customData.dataSeriesList[closestLine.lineIndex];
        _drawDataTip(paintInfo, dataTools, dataSeries.label, closestLine.closestPoint);
    }

    void _paintTextPaintersBottom<T>(PaintInfo paintInfo, List<PositionedTextPainter<T>> painters, {required bool showTicks})
    {
        if (!showTicks)
            return;

        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter<T> painter = painters[i];
            final TextPainter? textPainter = painter.textPainter;
            if (textPainter == null)
                continue;

            final double lineX = invertXAxis
                ? paintInfo.graphMinMax.minX + paintInfo.graphMinMax.maxX - painter.linePosition 
                : painter.linePosition;

            final double lineY = paintInfo.graphMinMax.maxY;

            _drawLineSegment(paintInfo.canvas, paintInfo.borderPaint, lineX, lineY, lineX, lineY + tickLineLengthY);

            final double textPainterX = invertXAxis
                ? paintInfo.graphMinMax.minX + paintInfo.graphMinMax.maxX - painter.textEndX 
                : painter.textStartX;

            final double textPainterY = paintInfo.graphMinMax.maxY + additionalSpaceForLabelY;

            textPainter.paint(paintInfo.canvas, Offset(textPainterX, textPainterY));
        }
    }

    void _paintTextPaintersLeft<T>(PaintInfo paintInfo, List<PositionedTextPainter<T>> painters, {required bool showTicks})
    {
        if (!showTicks)
            return;

        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter<T> painter = painters[i];
            final TextPainter? textPainter = painter.textPainter;
            if (textPainter == null)
                continue;

            final double lineX = paintInfo.graphMinMax.minX;

            final double lineY = invertYAxis
                ? paintInfo.graphMinMax.minY + paintInfo.graphMinMax.maxY - painter.linePosition 
                : painter.linePosition;

            _drawLineSegment(paintInfo.canvas, paintInfo.borderPaint, lineX - tickLineLengthX, lineY, lineX, lineY);

            final double textPainterX = paintInfo.graphMinMax.minX - additionalSpaceForLabelX - textPainter.width;

            final double textPainterY = invertYAxis
                ? paintInfo.graphMinMax.minY + paintInfo.graphMinMax.maxY - painter.textEndY
                : painter.textStartY;

            textPainter.paint(paintInfo.canvas, Offset(textPainterX, textPainterY));
        }
    }

    void _paintTextPaintersRight<T>(PaintInfo paintInfo, List<PositionedTextPainter<T>> painters, {required bool showTicks})
    {
        if (!showTicks)
            return;

        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter<T> painter = painters[i];
            final TextPainter? textPainter = painter.textPainter;
            if (textPainter == null)
                continue;

            final double lineX = paintInfo.graphMinMax.maxX;

            final double lineY = invertYAxis
                ? paintInfo.graphMinMax.minY + paintInfo.graphMinMax.maxY - painter.linePosition
                : painter.linePosition;

            _drawLineSegment(paintInfo.canvas, paintInfo.borderPaint, lineX, lineY, lineX + tickLineLengthX, lineY);

            final double textPainterX = paintInfo.graphMinMax.maxX + additionalSpaceForLabelX;

            final double textPainterY = invertYAxis
                ? paintInfo.graphMinMax.minY + paintInfo.graphMinMax.maxY - painter.textEndY
                : painter.textStartY;

            textPainter.paint(paintInfo.canvas, Offset(textPainterX, textPainterY));
        }
    }

    void _paintTextPaintersTop<T>(PaintInfo paintInfo, List<PositionedTextPainter<T>> painters, {required bool showTicks})
    {
        if (!showTicks)
            return;

        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter<T> painter = painters[i];
            final TextPainter? textPainter = painter.textPainter;
            if (textPainter == null)
                continue;

            final double lineX = invertXAxis
                ? paintInfo.graphMinMax.minX + paintInfo.graphMinMax.maxX - painter.linePosition 
                : painter.linePosition;

            final double lineY = paintInfo.graphMinMax.minY;

            _drawLineSegment(paintInfo.canvas, paintInfo.borderPaint, lineX, lineY, lineX, lineY - tickLineLengthY);

            final double textPainterX = invertXAxis
                ? paintInfo.graphMinMax.minX + paintInfo.graphMinMax.maxX - painter.textEndX 
                : painter.textStartX;

            final double textPainterY = paintInfo.graphMinMax.minY - additionalSpaceForLabelY - textPainter.height;

            textPainter.paint(paintInfo.canvas, Offset(textPainterX, textPainterY));
        }
    }

    void _paintVerticalGridLines<T>(PaintInfo paintInfo, List<PositionedTextPainter<T>> painters)
    {
        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter<T> painter = painters[i];
            final TextPainter? textPainter = painter.textPainter;

            if (painter.linePosition > paintInfo.graphMinMax.minX && painter.linePosition < paintInfo.graphMinMax.maxX)
            {
                final Paint gridPaint = textPainter == null ? paintInfo.gridPaint2 : paintInfo.gridPaint;

                final double lineX = invertXAxis
                    ? paintInfo.graphMinMax.minX + paintInfo.graphMinMax.maxX - painter.linePosition 
                    : painter.linePosition;

                _drawLineSegment(paintInfo.canvas, gridPaint, lineX, paintInfo.graphMinMax.minY, lineX, paintInfo.graphMinMax.maxY);
            }
        }
    }

    Offset? _projectFromPointOnLine(double pointX, double pointY, double lineX1, double lineY1, double lineX2, double lineY2)
    {
        final double dx = lineX2 - lineX1;
        final double dy = lineY2 - lineY1;
        final double lengthSquared = dx * dx + dy * dy;
        if (lengthSquared == 0)
            return null;

        // Vector from (x1, y1) to the point
        final double t = ((pointX - lineX1) * dx + (pointY - lineY1) * dy) / lengthSquared;

        // The closest point is outside the segment
        if (t < 0 || t > 1)
            return null;

        final double intersectionX = lineX1 + t * dx;
        final double intersectionY = lineY1 + t * dy;

        return Offset(intersectionX, intersectionY);
    }

    void _showError(Canvas canvas, Size size, String s)
    {
        final DoubleMinMax graphMinMax = _calcGraphMinMax(size, <TextPainter>[], <TextPainter>[]);
        canvas.drawRect(Rect.fromLTRB(graphMinMax.minX, graphMinMax.minY, graphMinMax.maxX, graphMinMax.maxY), _createBorderPaint());

        final TextPainter tp = _createAndLayoutTextPainter(s, chartStyle, 1.5);
        tp.paint(canvas, Offset(size.width / 2 - tp.width / 2, size.height / 2 - tp.height / 2));
    }
}
