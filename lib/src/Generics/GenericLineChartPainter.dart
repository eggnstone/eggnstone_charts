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
    final GenericChartData<TX, TY> data;
    final DoubleChartData doubleData;

    GenericLineChartPainter({
        required this.chartStyle,
        required this.data,
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
            logDebug('LineChartPainter._paintOrThrow() Size: $size');
            logDebug('  data.minMax:            ${data.minMax}');
            logDebug('  doubleData.minMax:      ${doubleData.minMax}');
        }

        if (data.lines.size != data.colors.size)
            throw ChartsUserException('Mismatch between lines and colors');

        if (data.lines.isEmpty())
            throw ChartsUserException('No data');

        List<PositionedTextPainter<TX>> xAxisPainters = <PositionedTextPainter<TX>>
        [
            PositionedTextPainter<TX>(textPosition: -1, textStart: -1, textEnd: -1, textPainter: _createAndLayoutTextPainter(data.toolsX.format(data.minMax.minX), chartStyle)),
            PositionedTextPainter<TX>(textPosition: -1, textStart: -1, textEnd: -1, textPainter: _createAndLayoutTextPainter(data.toolsX.format(data.minMax.maxX), chartStyle))
        ];

        List<PositionedTextPainter<TY>> yAxisPainters = <PositionedTextPainter<TY>>
        [
            PositionedTextPainter<TY>(textPosition: -1, textStart: -1, textEnd: -1, textPainter: _createAndLayoutTextPainter(data.toolsY.format(data.minMax.minY), chartStyle)),
            PositionedTextPainter<TY>(textPosition: -1, textStart: -1, textEnd: -1, textPainter: _createAndLayoutTextPainter(data.toolsY.format(data.minMax.maxY), chartStyle))
        ];

        final DoubleMinMax graphMinMax = _calcGraphMinMax(size, xAxisPainters, yAxisPainters);

        xAxisPainters = _createXAxisTicks(graphMinMax);
        yAxisPainters = _createYAxisTicks(graphMinMax);

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

    static double _dataToPixelX(GenericMinMax<double, double> dataMinMax, DoubleMinMax graphMinMax, double dataX)
    {
        if (dataMinMax.getWidth() == 0)
            throw ChartsException('dataMinMax.getWidth() == 0');

        if (DEBUG_DATA_TO_PIXEL)
        {
            logDebug('graphMinMax.minX:     ${graphMinMax.minX}');
            logDebug('dataX:                $dataX');
            logDebug('dataMinMax.minX:      ${dataMinMax.minX}');
            logDebug('dataMinMax.getWidth:  ${dataMinMax.getWidth()}');
            logDebug('graphMinMax.getWidth: ${graphMinMax.getWidth()}');
        }

        return graphMinMax.minX + (dataX - dataMinMax.minX) / dataMinMax.getWidth() * graphMinMax.getWidth();
    }

    static double _dataToPixelY(GenericMinMax<double, double> dataMinMax, DoubleMinMax graphMinMax, double dataY)
    {
        if (dataMinMax.getHeight() == 0)
            throw ChartsException('dataMinMax.getHeight() == 0');

        if (DEBUG_DATA_TO_PIXEL)
        {
            logDebug('graphMinMax.minY:      ${graphMinMax.minY}');
            logDebug('dataY:                 $dataY');
            logDebug('dataMinMax.minY:       ${dataMinMax.minY}');
            logDebug('dataMinMax.getHeight:  ${dataMinMax.getHeight()}');
            logDebug('graphMinMax.getHeight: ${graphMinMax.getHeight()}');
        }

        return graphMinMax.maxY - (dataY - dataMinMax.minY) / dataMinMax.getHeight() * graphMinMax.getHeight();
    }

    DoubleMinMax _calcGraphMinMax<T>(Size size, List<PositionedTextPainter<T>> xAxisPainters, List<PositionedTextPainter<T>> yAxisPainters)
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

    double _calcMaxPainterHeight<T>(List<PositionedTextPainter<T>> painters)
    {
        double maxHeight = 0;

        for (int i = 0; i < painters.length; i++)
            maxHeight = max(maxHeight, painters[i].textPainter.height);

        return maxHeight;
    }

    double _calcMaxPainterWidth<T>(List<PositionedTextPainter<T>> painters)
    {
        double maxWidth = 0;

        for (int i = 0; i < painters.length; i++)
            maxWidth = max(maxWidth, painters[i].textPainter.width);

        return maxWidth;
    }

    void _paintTextPaintersLeft<T>(Canvas canvas, Paint paint, DoubleMinMax graphMinMax, List<PositionedTextPainter<T>> painters)
    {
        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter<T> painter = painters[i];
            final double endY = painter.textPosition;//  _dataToPixelYOrThrow(doubleData.minMax, graphMinMax, painter.doubleValue);
            _drawLine(canvas, paint, graphMinMax.minX - tickLineLengthX, endY, graphMinMax.minX, endY);
            painter.textPainter.paint(canvas, Offset(graphMinMax.minX - tickLineLengthX - paddingBetweenTickLabelAndTickLineX - painter.textPainter.width, endY - painter.textPainter.height / 2));
        }
    }

    void _paintTextPaintersTop<T>(Canvas canvas, Paint paint, DoubleMinMax graphMinMax, List<PositionedTextPainter<T>> painters)
    {
        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter<T> painter = painters[i];
            final double endX = painter.textPosition;// _dataToPixelXOrThrow(doubleData.minMax, graphMinMax, painter.doubleValue);
            _drawLine(canvas, paint, endX, graphMinMax.minY - tickLineLengthY, endX, graphMinMax.minY);
            painter.textPainter.paint(canvas, Offset(endX - painter.textPainter.width / 2, graphMinMax.minY - tickLineLengthY - paddingBetweenTickLabelAndTickLineY - painter.textPainter.height));
        }
    }

    void _paintTextPaintersRight<T>(Canvas canvas, Paint paint, DoubleMinMax graphMinMax, List<PositionedTextPainter<T>> painters)
    {
        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter<T> painter = painters[i];
            final double startY = painter.textPosition;// _dataToPixelYOrThrow(doubleData.minMax, graphMinMax, painter.doubleValue);
            _drawLine(canvas, paint, graphMinMax.maxX, startY, graphMinMax.maxX + tickLineLengthX, startY);
            painter.textPainter.paint(canvas, Offset(graphMinMax.maxX + tickLineLengthX + paddingBetweenTickLabelAndTickLineX, startY - painter.textPainter.height / 2));
        }
    }

    void _paintTextPaintersBottom<T>(Canvas canvas, Paint paint, DoubleMinMax graphMinMax, List<PositionedTextPainter<T>> painters)
    {
        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter<T> painter = painters[i];
            final double startX = painter.textPosition;//  _dataToPixelXOrThrow(doubleData.minMax, graphMinMax, painter.doubleValue);
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
        final DoubleMinMax graphMinMax = _calcGraphMinMax(size, <PositionedTextPainter<TX>>[], <PositionedTextPainter<TY>>[]);
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
    => _createAxisTicks<TX>(graphMinMax, data.toolsX, Axis.horizontal);

    List<PositionedTextPainter<TY>> _createYAxisTicks(DoubleMinMax graphMinMax)
    => _createAxisTicks<TY>(graphMinMax, data.toolsY, Axis.vertical);

    List<PositionedTextPainter<T>> _createAxisTicks<T>(DoubleMinMax graphMinMax, GenericTools<T> tools, Axis axis)
    {
        if (DEBUG)
            logDebug('_createAxisTicks(axis: $axis)');

        final List<PositionedTextPainter<T>> tickPainters = <PositionedTextPainter<T>>[];

        final T dataValueMin = axis == Axis.horizontal ? data.minMax.minX as T : data.minMax.minY as T;
        final T dataValueMax = axis == Axis.horizontal ? data.minMax.maxX as T : data.minMax.maxY as T;
        final T dataValueFirst = tools.getNextNiceValueOrSame(dataValueMin);
        final T dataValueLast = tools.getPreviousNiceValueOrSame(dataValueMax);
        logDebug('  dataValueMin:    $dataValueMin');
        logDebug('  dataValueFirst:  $dataValueFirst');
        logDebug('  dataValueLast:   $dataValueLast');
        logDebug('  dataValueMax:    $dataValueMax');

        double textPositionMin = axis == Axis.horizontal ? graphMinMax.minX - additionalSpaceForLabelX : graphMinMax.minY - additionalSpaceForLabelY;
        double textPositionMax = axis == Axis.horizontal ? graphMinMax.maxX + additionalSpaceForLabelX : graphMinMax.maxY + additionalSpaceForLabelY;
        logDebug('  textPositionMin: $textPositionMin');
        logDebug('  textPositionMax: $textPositionMax');

        final PositionedTextPainter<T>? lastPainter = _createNextTickPainter<T>(
            doubleData.minMax,
            graphMinMax,
            chartStyle,
            tools,
            axis: axis,
            textPositionMax: textPositionMax,
            textPositionMin: textPositionMin,
            dataValue: dataValueLast
        );

        if (lastPainter == null)
            return tickPainters;

        logDebug('    Tick painter for $dataValueLast at ${lastPainter.textPosition.toStringAsFixed(1)}');
        tickPainters.add(lastPainter);
        textPositionMax = lastPainter.textStart.floorToDouble();
        T dataValueCurrent = dataValueFirst;

        int count = 0;
        while (true)
        {
            count++;

            if (count > 100)
            {
                logWarning('Too many ticks!');
                break;
            }

            logDebug('Tick #$count: $dataValueCurrent');
            logDebug('  textPositionMin:  ${textPositionMin.toStringAsFixed(1)}');
            logDebug('  textPositionMax:  ${textPositionMax.toStringAsFixed(1)}');

            final PositionedTextPainter<T>? tickPainter = _createNextTickPainter<T>(
                doubleData.minMax,
                graphMinMax,
                chartStyle,
                tools,
                axis: axis,
                textPositionMin: textPositionMin,
                textPositionMax: textPositionMax,
                dataValue: dataValueCurrent
            );

            if (tickPainter == null)
            {
                logDebug('    No tick painter for $dataValueCurrent');
                break;
            }

            logDebug('    Tick painter for $dataValueCurrent at ${tickPainter.textPosition.toStringAsFixed(1)}');
            tickPainters.add(tickPainter);
            textPositionMin = tickPainter.textEnd.ceilToDouble();
            dataValueCurrent = tools.getNextNiceValue(dataValueCurrent);
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
            required T dataValue
        }
    )
    { 
        final double doubleValue = tools.toDouble(dataValue);
        final TextPainter textPainter = _createAndLayoutTextPainter(tools.format(dataValue), chartStyle);
        final double currentTextPosition = (axis == Axis.horizontal ? _dataToPixelX(doubleDataMinMax, graphMinMax, doubleValue) : _dataToPixelY(doubleDataMinMax, graphMinMax, doubleValue));
        final double currentTextPositionMin = currentTextPosition - textPainter.width / 2;
        final double currentTextPositionMax = currentTextPosition + textPainter.width / 2;
        final double doubleValueMin = axis == Axis.horizontal ? doubleDataMinMax.minX : doubleDataMinMax.minY;
        final double doubleValueMax = axis == Axis.horizontal ? doubleDataMinMax.maxX : doubleDataMinMax.maxY;

        if (currentTextPositionMin < textPositionMin || 
            currentTextPositionMax > textPositionMax ||
            doubleValue < doubleValueMin ||
            doubleValue > doubleValueMax)
            return null;

        return PositionedTextPainter<T>(
            textPosition: currentTextPosition,
            textStart: currentTextPositionMin,
            textEnd: currentTextPositionMax, 
            textPainter: textPainter
        );
    }
}
