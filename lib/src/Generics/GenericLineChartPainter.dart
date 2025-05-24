import 'dart:math';

import 'package:eggnstone_dart/eggnstone_dart.dart';
import 'package:flutter/material.dart';

import '../ChartStyle.dart';
import '../ChartsException.dart';
import '../ChartsUserException.dart';
import '../PositionedTextPainter.dart';
import '../Specifics/DoubleChartData.dart';
import '../Specifics/DoubleLineData.dart';
import '../Specifics/DoubleMinMax.dart';
import 'GenericChartData.dart';
import 'GenericMinMax.dart';
import 'GenericTools.dart';

class GenericLineChartPainter<TX, TY> extends CustomPainter
{
    static const bool DEBUG = true;
    static const bool DEBUG_DATA_TO_PIXEL = false;

    static const double additionalSpaceForLabelX = paddingBetweenTickLabelAndTickLineX + tickLineLengthX;
    static const double outerPaddingX = 4;
    static const double paddingBetweenTickLabelAndTickLineX = 2;
    static const double tickLineLengthX = 8;

    static const double additionalSpaceForLabelY = paddingBetweenTickLabelAndTickLineY + tickLineLengthY;
    static const double outerPaddingY = 4;
    static const double paddingBetweenTickLabelAndTickLineY = 0;
    static const double tickLineLengthY = 8;

    final ChartStyle chartStyle;
    final GenericChartData<TX, TY> customData;
    final DoubleChartData doubleData;

    GenericLineChartPainter({
        required this.chartStyle,
        required this.customData,
        required this.doubleData
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

        if (DEBUG)
            logDebug('  graphMinMax:       $graphMinMax');

        final List<PositionedTextPainter<TX>> xAxisPainters = _createXAxisTicks(graphMinMax);
        final List<PositionedTextPainter<TY>> yAxisPainters = _createYAxisTicks(graphMinMax);

        if (DEBUG)
        {
            xAxisPainters.add(
                PositionedTextPainter<TX>(
                    textPosition: graphMinMax.minX,
                    textStart: -1,
                    textEnd: -1,
                    textPainter: _createAndLayoutTextPainter(customData.toolsX.format(customData.minMax.minX), chartStyle.copyWith(textColor: Colors.lightGreenAccent))
                )
            );

            xAxisPainters.add(
                PositionedTextPainter<TX>(
                    textPosition: graphMinMax.maxX,
                    textStart: -1,
                    textEnd: -1,
                    textPainter: _createAndLayoutTextPainter(customData.toolsX.format(customData.minMax.maxX), chartStyle.copyWith(textColor: Colors.lightGreenAccent))
                )
            );

            yAxisPainters.add(
                PositionedTextPainter<TY>(
                    textPosition: graphMinMax.minY,
                    textStart: -1,
                    textEnd: -1,
                    textPainter: _createAndLayoutTextPainter(customData.toolsY.format(customData.minMax.minY), chartStyle.copyWith(textColor: Colors.lightGreenAccent))
                )
            );

            yAxisPainters.add(
                PositionedTextPainter<TY>(
                    textPosition: graphMinMax.maxY,
                    textStart: -1,
                    textEnd: -1,
                    textPainter: _createAndLayoutTextPainter(customData.toolsY.format(customData.minMax.maxY), chartStyle.copyWith(textColor: Colors.lightGreenAccent))
                )
            );
        }

        final Paint borderPaint = _createBorderPaint();
        canvas.drawRect(Rect.fromLTRB(graphMinMax.minX, graphMinMax.minY, graphMinMax.maxX, graphMinMax.maxY), borderPaint);

        _paintTextPaintersLeft(canvas, borderPaint, graphMinMax, yAxisPainters);
        _paintTextPaintersRight(canvas, borderPaint, graphMinMax, yAxisPainters);

        _paintTextPaintersTop(canvas, borderPaint, graphMinMax, xAxisPainters);
        _paintTextPaintersBottom(canvas, borderPaint, graphMinMax, xAxisPainters);

        _drawLines(canvas, graphMinMax);

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
    }

    @override
    bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

    void _drawLine(Canvas canvas, Paint paint, double x1, double y1, double x2, double y2) => canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);

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

    static double _dataToPixelX(GenericMinMax<double, double> doubleDataMinMax, DoubleMinMax graphMinMax, double doubleData)
    {
        if (doubleDataMinMax.getWidth() == 0)
            throw ChartsException('doubleDataMinMax.getWidth() == 0');

        if (DEBUG_DATA_TO_PIXEL)
        {
            logDebug('graphMinMax.getWidth:      ${graphMinMax.getWidth()}');
            logDebug('graphMinMax.minX:          ${graphMinMax.minX}');
            logDebug('doubleDataMinMax.getWidth: ${doubleDataMinMax.getWidth()}');
            logDebug('doubleDataMinMax.minX:     ${doubleDataMinMax.minX}');
            logDebug('doubleData:                $doubleData');
        }

        return graphMinMax.minX + (doubleData - doubleDataMinMax.minX) / doubleDataMinMax.getWidth() * graphMinMax.getWidth();
    }

    static double _dataToPixelY(GenericMinMax<double, double> doubleDataMinMax, DoubleMinMax graphMinMax, double doubleData)
    {
        if (doubleDataMinMax.getHeight() == 0)
            throw ChartsException('doubleDataMinMax.getHeight() == 0');

        if (DEBUG_DATA_TO_PIXEL)
        {
            logDebug('graphMinMax.getHeight:      ${graphMinMax.getHeight()}');
            logDebug('graphMinMax.minY:           ${graphMinMax.minY}');
            logDebug('doubleDataMinMax.getHeight: ${doubleDataMinMax.getHeight()}');
            logDebug('doubleDataMinMax.minY:      ${doubleDataMinMax.minY}');
            logDebug('doubleData:                 $doubleData');
        }

        return graphMinMax.maxY - (doubleData - doubleDataMinMax.minY) / doubleDataMinMax.getHeight() * graphMinMax.getHeight();
    }

    DoubleMinMax _calcGraphMinMax(Size size, List<TextPainter> xAxisPainters, List<TextPainter> yAxisPainters)
    {
        final double maxYAxisPainterWidth = _calcMaxPainterWidth(yAxisPainters);
        final double chartStartX = outerPaddingX + maxYAxisPainterWidth + paddingBetweenTickLabelAndTickLineX + tickLineLengthX;
        final double chartEndX = size.width - outerPaddingX - maxYAxisPainterWidth - paddingBetweenTickLabelAndTickLineX - tickLineLengthX;

        final double maxXAxisPainterHeight = _calcMaxPainterHeight(xAxisPainters);
        final double chartStartY = outerPaddingY + maxXAxisPainterHeight + tickLineLengthY + paddingBetweenTickLabelAndTickLineY;
        final double chartEndY = size.height - outerPaddingY - maxXAxisPainterHeight - tickLineLengthY - paddingBetweenTickLabelAndTickLineY;

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

    void _paintTextPaintersLeft<T>(Canvas canvas, Paint paint, DoubleMinMax graphMinMax, List<PositionedTextPainter<T>> painters)
    {
        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter<T> painter = painters[i];
            final double endY = painter.textPosition;
            _drawLine(canvas, paint, graphMinMax.minX - tickLineLengthX, endY, graphMinMax.minX, endY);
            painter.textPainter.paint(canvas, Offset(graphMinMax.minX - tickLineLengthX - paddingBetweenTickLabelAndTickLineX - painter.textPainter.width, endY - painter.textPainter.height / 2));
        }
    }

    void _paintTextPaintersTop<T>(Canvas canvas, Paint paint, DoubleMinMax graphMinMax, List<PositionedTextPainter<T>> painters)
    {
        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter<T> painter = painters[i];
            final double endX = painter.textPosition;
            _drawLine(canvas, paint, endX, graphMinMax.minY - tickLineLengthY, endX, graphMinMax.minY);
            painter.textPainter.paint(canvas, Offset(endX - painter.textPainter.width / 2, graphMinMax.minY - tickLineLengthY - paddingBetweenTickLabelAndTickLineY - painter.textPainter.height));
        }
    }

    void _paintTextPaintersRight<T>(Canvas canvas, Paint paint, DoubleMinMax graphMinMax, List<PositionedTextPainter<T>> painters)
    {
        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter<T> painter = painters[i];
            final double startY = painter.textPosition;
            _drawLine(canvas, paint, graphMinMax.maxX, startY, graphMinMax.maxX + tickLineLengthX, startY);
            painter.textPainter.paint(canvas, Offset(graphMinMax.maxX + tickLineLengthX + paddingBetweenTickLabelAndTickLineX, startY - painter.textPainter.height / 2));
        }
    }

    void _paintTextPaintersBottom<T>(Canvas canvas, Paint paint, DoubleMinMax graphMinMax, List<PositionedTextPainter<T>> painters)
    {
        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter<T> painter = painters[i];
            final double startX = painter.textPosition;
            _drawLine(canvas, paint, startX, graphMinMax.maxY, startX, graphMinMax.maxY + tickLineLengthY);
            painter.textPainter.paint(canvas, Offset(startX - painter.textPainter.width / 2, graphMinMax.maxY + tickLineLengthY + paddingBetweenTickLabelAndTickLineY));
        }
    }

    void _drawLines(Canvas canvas, DoubleMinMax graphMinMax)
    {
        for (int lineIndex = 0; lineIndex < doubleData.lines.size; lineIndex++)
        {
            final DoubleLineData line = doubleData.lines[lineIndex];

            Color color;
            if (lineIndex < 0 || lineIndex >= doubleData.colors.size)
            {
                logError('LineChartPainter.linePaint() lineIndex: $lineIndex out of range for colors.size: ${doubleData.colors.size}');
                color = Colors.black;
            }
            else
                color = doubleData.colors[lineIndex];

            final Paint linePaint = Paint()
                ..color = color
                ..strokeWidth = 2
                ..style = PaintingStyle.fill;

            double lastX = graphMinMax.minX + (line.points[0].x - doubleData.minMax.minX) / doubleData.minMax.getWidth() * graphMinMax.getWidth();
            double lastY = graphMinMax.maxY - (line.points[0].y - doubleData.minMax.minY) / doubleData.minMax.getHeight() * graphMinMax.getHeight();
            canvas.drawCircle(Offset(lastX, lastY), chartStyle.pointRadius, linePaint);

            for (int i = 1; i < line.points.size; i++)
            {
                final double currentX = graphMinMax.minX + (line.points[i].x - doubleData.minMax.minX) / doubleData.minMax.getWidth() * graphMinMax.getWidth();
                final double currentY = graphMinMax.maxY - (line.points[i].y - doubleData.minMax.minY) / doubleData.minMax.getHeight() * graphMinMax.getHeight();

                _drawLine(canvas, linePaint, lastX, lastY, currentX, currentY);
                canvas.drawCircle(Offset(currentX, currentY), chartStyle.pointRadius, linePaint);
                lastX = currentX;
                lastY = currentY;
            }
        }
    }

    void _showError(Canvas canvas, Size size, String s)
    {
        final DoubleMinMax graphMinMax = _calcGraphMinMax(size, <TextPainter>[], <TextPainter>[]);
        canvas.drawRect(Rect.fromLTRB(graphMinMax.minX, graphMinMax.minY, graphMinMax.maxX, graphMinMax.maxY), _createBorderPaint());

        final TextPainter tp = _createAndLayoutTextPainter(s, chartStyle, 1.5);
        tp.paint(canvas, Offset(size.width / 2 - tp.width / 2, size.height / 2 - tp.height / 2));
    }

    Paint _createBorderPaint()
    {
        final Paint borderPaint = Paint()
            ..color = chartStyle.lineColor ?? Colors.black
            ..strokeWidth = 1 // / style.devicePixelRatio;
            ..style = PaintingStyle.stroke;

        return borderPaint;
    }

    List<PositionedTextPainter<TX>> _createXAxisTicks(DoubleMinMax graphMinMax)
    => _createAxisTicks<TX>(graphMinMax, customData.toolsX, Axis.horizontal);

    List<PositionedTextPainter<TY>> _createYAxisTicks(DoubleMinMax graphMinMax)
    => _createAxisTicks<TY>(graphMinMax, customData.toolsY, Axis.vertical);

    List<PositionedTextPainter<T>> _createAxisTicks<T>(DoubleMinMax graphMinMax, GenericTools<T> tools, Axis axis)
    {
        if (DEBUG)
            logDebug('_createAxisTicks(axis: $axis)');

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

        final PositionedTextPainter<T>? lastPainter = _createNextTickPainter<T>(
            doubleData.minMax,
            graphMinMax,
            chartStyle,
            tools,
            axis: axis,
            textPositionMax: textPositionMax,
            textPositionMin: textPositionMin,
            customDataValue: customDataLast
        );

        if (lastPainter == null)
        {
            logWarning('    No tick painter for $customDataLast');
            //return tickPainters;
        }
        else
        {
            if (DEBUG)
                logDebug('    Tick painter for $customDataLast at ${lastPainter.textPosition.toStringAsFixed(1)}');

            tickPainters.add(lastPainter);
            textPositionMax = lastPainter.textStart.floorToDouble();
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

            final PositionedTextPainter<T>? tickPainter = _createNextTickPainter<T>(
                doubleData.minMax,
                graphMinMax,
                chartStyle,
                tools,
                axis: axis,
                textPositionMin: textPositionMin,
                textPositionMax: textPositionMax,
                customDataValue: customDataValue
            );

            if (tickPainter == null)
            {
                logInfo('    No tick painter for $customDataValue');
                break;
            }

            if (DEBUG)
                logDebug('    Tick painter for $customDataValue at ${tickPainter.textPosition.toStringAsFixed(1)}');

            tickPainters.add(tickPainter);
            textPositionMin = tickPainter.textEnd.ceilToDouble();
            customDataValue = tools.getNextNiceCustomValue(customDataValue);
        }

        return tickPainters;
    }

    static PositionedTextPainter<T>? _createNextTickPainter<T>(
        GenericMinMax<double, double> doubleDataMinMax,
        DoubleMinMax graphMinMax,
        ChartStyle chartStyle,
        GenericTools<T> tools, {
            required Axis axis,
            required double textPositionMax,
            required double textPositionMin,
            required T customDataValue
        }
    )
    { 
        final double doubleDataValue = tools.toDoubleValue(customDataValue);
        final TextPainter textPainter = _createAndLayoutTextPainter(tools.format(customDataValue), chartStyle);
        final double textPosition = (axis == Axis.horizontal ? _dataToPixelX(doubleDataMinMax, graphMinMax, doubleDataValue) : _dataToPixelY(doubleDataMinMax, graphMinMax, doubleDataValue));
        final double textPositionStart = textPosition - textPainter.width / 2;
        final double textPositionEnd = textPosition + textPainter.width / 2;
        final double doubleDataMin = axis == Axis.horizontal ? doubleDataMinMax.minX : doubleDataMinMax.minY;
        final double doubleDataMax = axis == Axis.horizontal ? doubleDataMinMax.maxX : doubleDataMinMax.maxY;

        if (textPositionStart < textPositionMin)
        {
            logInfo('textPositionStart ($textPositionStart) < textPositionMin ($textPositionMin)');
            return null;
        }

        if (textPositionEnd > textPositionMax)
        {
            logInfo('textPositionEnd ($textPositionEnd) > textPositionMax ($textPositionMax)');
            return null;
        }

        if (doubleDataValue < doubleDataMin)
        {
            logInfo('doubleDataValue( $doubleDataValue) < doubleDataMin ($doubleDataMin)');
            return null;
        }

        if (doubleDataValue > doubleDataMax)
        {
            logInfo('doubleDataValue ($doubleDataValue) > doubleDataMax ($doubleDataMax)');
            return null;
        }

        return PositionedTextPainter<T>(
            textPosition: textPosition,
            textStart: textPositionStart,
            textEnd: textPositionEnd,
            textPainter: textPainter
        );
    }
}
