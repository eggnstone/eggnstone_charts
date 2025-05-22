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

    static const double outerPaddingX = 4;
    static const double paddingBetweenTickLabelAndTickLineX = 2;
    static const double tickLineLengthX = 8;

    static const double outerPaddingY = 4;
    static const double paddingBetweenTickLabelAndTickLineY = 0;
    static const double tickLineLengthY = 8;

    final GenericChartData<TX, TY> data;
    final DoubleChartData doubleData;
    final ChartStyle style;

    GenericLineChartPainter({
        required this.data,
        required this.doubleData,
        required this.style
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
        on Exception catch (e, stackTrace)
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

        final List<PositionedTextPainter> xAxisPainters = <PositionedTextPainter>
        [
            PositionedTextPainter(doubleData.minMax.minX, _createAndLayoutTextPainter(data.toolsX.format(data.minMax.minX))),
            PositionedTextPainter(doubleData.minMax.maxX, _createAndLayoutTextPainter(data.toolsX.format(data.minMax.maxX)))
        ];

        final List<PositionedTextPainter> yAxisPainters = <PositionedTextPainter>
        [
            PositionedTextPainter(doubleData.minMax.minY, _createAndLayoutTextPainter(data.toolsY.format(data.minMax.minY))),
            PositionedTextPainter(doubleData.minMax.maxY, _createAndLayoutTextPainter(data.toolsY.format(data.minMax.maxY)))
        ];

        final DoubleMinMax graphMinMax = _calcGraphMinMax(size, xAxisPainters, yAxisPainters);

        xAxisPainters.clear();
        _addXAxisTicks(xAxisPainters, graphMinMax, data.toolsX);

        yAxisPainters.clear();
        _addYAxisTicks(yAxisPainters, graphMinMax, data.toolsY);

        final Paint borderPaint = _createBorderPaint();
        canvas.drawRect(Rect.fromLTRB(graphMinMax.minX, graphMinMax.minY, graphMinMax.maxX, graphMinMax.maxY), borderPaint);

        _paintTextPaintersLeft(canvas, borderPaint, yAxisPainters, graphMinMax);
        _paintTextPaintersRight(canvas, borderPaint, yAxisPainters, graphMinMax);

        _paintTextPaintersTop(canvas, borderPaint, xAxisPainters, graphMinMax);
        _paintTextPaintersBottom(canvas, borderPaint, xAxisPainters, graphMinMax);

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

    TextPainter _createAndLayoutTextPainter(String text, [double? textScale])
    {
        final TextPainter tp = TextPainter(
            textScaler: textScale == null ? TextScaler.noScaling : TextScaler.linear(textScale),
            text: TextSpan(style: TextStyle(color: style.textColor, fontSize: style.fontSize), text: text),
            textDirection: TextDirection.ltr
        );
        tp.layout();
        return tp;
    }

    double _dataToPixelX(GenericMinMax<double, double> dataMinMax, DoubleMinMax graphMinMax, double dataX)
    {
        if (dataMinMax.getWidth() == 0)
            return graphMinMax.minX;

        if (DEBUG_DATA_TO_PIXEL)
        {
            logDebug('graphMinMax.minX: ${graphMinMax.minX}');
            logDebug('dataX: $dataX');
            logDebug('dataMinMax.minX: ${dataMinMax.minX}');
            logDebug('dataMinMax.minX: ${dataMinMax.getWidth()}');
            logDebug('dataMinMax.minX: ${graphMinMax.getWidth()}');
        }

        final double result = graphMinMax.minX + (dataX - dataMinMax.minX) / dataMinMax.getWidth() * graphMinMax.getWidth();

        if (result < graphMinMax.minX)
            throw ChartsException('result < graphMinMax.minX');

        if (result > graphMinMax.maxX)
            throw ChartsException('result > graphMinMax.maxX');

        return result;
    }

    double _dataToPixelY(GenericMinMax<double, double> dataMinMax, DoubleMinMax graphMinMax, double dataY)
    {
        if (dataMinMax.getHeight() == 0)
            return graphMinMax.minY;

        if (DEBUG_DATA_TO_PIXEL)
        {
            logDebug('graphMinMax.minX: ${graphMinMax.minY}');
            logDebug('dataX: $dataY');
            logDebug('dataMinMax.minY: ${dataMinMax.minY}');
            logDebug('dataMinMax.minY: ${dataMinMax.getHeight()}');
            logDebug('dataMinMax.minY: ${graphMinMax.getHeight()}');
        }

        final double result = graphMinMax.maxY - (dataY - dataMinMax.minY) / dataMinMax.getHeight() * graphMinMax.getHeight();

        if (result < graphMinMax.minY)
            throw ChartsException('result < graphMinMax.minY');

        if (result > graphMinMax.maxY)
            throw ChartsException('result > graphMinMax.maxY');

        return result;
    }

    DoubleMinMax _calcGraphMinMax(Size size, List<PositionedTextPainter> xAxisPainters, List<PositionedTextPainter> yAxisPainters)
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

    double _calcMaxPainterHeight(List<PositionedTextPainter> painters)
    {
        double maxHeight = 0;

        for (int i = 0; i < painters.length; i++)
            maxHeight = max(maxHeight, painters[i].textPainter.height);

        return maxHeight;
    }

    double _calcMaxPainterWidth(List<PositionedTextPainter> painters)
    {
        double maxWidth = 0;

        for (int i = 0; i < painters.length; i++)
            maxWidth = max(maxWidth, painters[i].textPainter.width);

        return maxWidth;
    }

    void _paintTextPaintersLeft(Canvas canvas, Paint paint, List<PositionedTextPainter> painters, DoubleMinMax graphMinMax)
    {
        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter painter = painters[i];
            final double endY = _dataToPixelY(doubleData.minMax, graphMinMax, painter.position);
            _drawLine(canvas, paint, graphMinMax.minX - tickLineLengthX, endY, graphMinMax.minX, endY);
            painter.textPainter.paint(canvas, Offset(graphMinMax.minX - tickLineLengthX - paddingBetweenTickLabelAndTickLineX - painter.textPainter.width, endY - painter.textPainter.height / 2));
        }
    }

    void _paintTextPaintersTop(Canvas canvas, Paint paint, List<PositionedTextPainter> painters, DoubleMinMax graphMinMax)
    {
        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter painter = painters[i];
            final double endX = _dataToPixelX(doubleData.minMax, graphMinMax, painter.position);
            _drawLine(canvas, paint, endX, graphMinMax.minY - tickLineLengthY, endX, graphMinMax.minY);
            painter.textPainter.paint(canvas, Offset(endX - painter.textPainter.width / 2, graphMinMax.minY - tickLineLengthY - paddingBetweenTickLabelAndTickLineY - painter.textPainter.height));
        }
    }

    void _paintTextPaintersRight(Canvas canvas, Paint paint, List<PositionedTextPainter> painters, DoubleMinMax graphMinMax)
    {
        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter painter = painters[i];
            final double startY = _dataToPixelY(doubleData.minMax, graphMinMax, painter.position);
            _drawLine(canvas, paint, graphMinMax.maxX, startY, graphMinMax.maxX + tickLineLengthX, startY);
            painter.textPainter.paint(canvas, Offset(graphMinMax.maxX + tickLineLengthX + paddingBetweenTickLabelAndTickLineX, startY - painter.textPainter.height / 2));
        }
    }

    void _paintTextPaintersBottom(Canvas canvas, Paint paint, List<PositionedTextPainter> painters, DoubleMinMax graphMinMax)
    {
        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter painter = painters[i];
            final double startX = _dataToPixelX(doubleData.minMax, graphMinMax, painter.position);
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
            canvas.drawCircle(Offset(lastX, lastY), style.pointRadius, linePaint);

            for (int i = 1; i < line.points.size; i++)
            {
                final double currentX = graphMinMax.minX + (line.points[i].x - doubleData.minMax.minX) / doubleData.minMax.getWidth() * graphMinMax.getWidth();
                final double currentY = graphMinMax.maxY - (line.points[i].y - doubleData.minMax.minY) / doubleData.minMax.getHeight() * graphMinMax.getHeight();

                _drawLine(canvas, linePaint, lastX, lastY, currentX, currentY);
                canvas.drawCircle(Offset(currentX, currentY), style.pointRadius, linePaint);
                lastX = currentX;
                lastY = currentY;
            }
        }
    }

    /*void _addTicksY(List<PositionedTextPainter> painters, GenericMinMax<double, double> dataMinMax, DoubleMinMax graphMinMax, GenericTools<TX> toolsX)
    {
        while (true)
            if (!_addTickY(painters, dataMinMax, graphMinMax, toolsX))
                return;
    }*/

    /*bool _addTickY(List<PositionedTextPainter> painters, GenericMinMax<double, double> dataMinMax, DoubleMinMax graphMinMax, GenericTools<TX> toolsX)
    {
        logDebug('START LineChartPainter._addTicksX()');
        logDebug('  graphMinMax:     $graphMinMax');

        final PositionedTextPainter previousPainter = painters[painters.length - 2];
        final PositionedTextPainter lastPainter = painters.last;

        logDebug('  previousPainter: ${previousPainter.position}  ${previousPainter.textPainter.width}');
        logDebug('  lastPainter:     ${lastPainter.position}  ${lastPainter.textPainter.width}');

        final double dataX = previousPainter.position;
        logDebug('  dataX:           $dataX');
        final double graphX = _dataToPixelX(dataMinMax, graphMinMax, dataX);
        logDebug('  graphX:          $graphX');

        final double nextGraphX1 = painters.length == 2
            ? graphMinMax.minX - paddingHorizontalInner + previousPainter.textPainter.width + paddingHorizontalTicks
            : graphX + previousPainter.textPainter.width / 2 + paddingHorizontalTicks;

        logDebug('  nextGraphX:      $nextGraphX1');
        final double nextDataX1 = doubleData.minMax.minX + (nextGraphX1 - graphMinMax.minX) / graphMinMax.getWidth() * doubleData.minMax.getWidth();
        logDebug('  nextDataX:       $nextDataX1');

        final TextPainter tp1 = _createAndLayoutTextPainter(toolsX.format(toolsX.toT(nextDataX1)));

        final double nextGraphX2 = nextGraphX1 + tp1.width / 2;
        logDebug('  nextGraphX2:     $nextGraphX2');
        final double nextDataX2 = doubleData.minMax.minX + (nextGraphX2 - graphMinMax.minX) / graphMinMax.getWidth() * doubleData.minMax.getWidth();
        logDebug('  nextDataX2:      $nextDataX2');

        final double nextDataX3 = toolsX.getNextDoubleValue(nextDataX2);
        logDebug('  nextDataX3:      $nextDataX3');

        final TextPainter tp3 = _createAndLayoutTextPainter(toolsX.format(toolsX.toT(nextDataX3)));

        final double lastPainterStartX = graphMinMax.maxX + paddingHorizontalInner - lastPainter.textPainter.width - paddingHorizontalTicks;
        if (nextGraphX2 + tp3.width / 2 >= lastPainterStartX)
        {
            logDebug('END LineChartPainter._addTicksX: NOT OK');
            return false;
        }

        painters.insert(painters.length - 1,
            PositionedTextPainter(
                nextDataX3,
                tp3
            )
        );

        //logDebug('  painters.middle: ${painters[painters.length - 2].position}  ${painters[painters.length - 2].textPainter.width}');
        logDebug('END LineChartPainter._addTicksX: OK');
        return true;
    }*/

    void _showError(Canvas canvas, Size size, String s)
    {
        final DoubleMinMax graphMinMax = _calcGraphMinMax(size, <PositionedTextPainter>[], <PositionedTextPainter>[]);
        canvas.drawRect(Rect.fromLTRB(graphMinMax.minX, graphMinMax.minY, graphMinMax.maxX, graphMinMax.maxY), _createBorderPaint());

        final TextPainter tp = _createAndLayoutTextPainter(s, 1.5);
        tp.paint(canvas, Offset(size.width / 2 - tp.width / 2, size.height / 2 - tp.height / 2));
    }

    Paint _createBorderPaint()
    {
        final Paint borderPaint = Paint()
            ..color = style.lineColor ?? Colors.black
            ..strokeWidth = 1 // / style.devicePixelRatio;
            ..style = PaintingStyle.stroke;

        return borderPaint;
    }

    void _addXAxisTicks(List<PositionedTextPainter> tickPainters, DoubleMinMax graphMinMax, GenericTools<TX> tools)
    {
        if (DEBUG)
            logDebug('_addXAxisTicks');

        _addEdgeTick<TX>(tickPainters, graphMinMax, tools, isXAxis: true, isFirst: true);
        _addEdgeTick<TX>(tickPainters, graphMinMax, tools, isXAxis: true, isFirst: false);
    }

    void _addYAxisTicks(List<PositionedTextPainter> tickPainters, DoubleMinMax graphMinMax, GenericTools<TY> tools)
    {
        if (DEBUG)
            logDebug('_addYAxisTicks');

        _addEdgeTick<TY>(tickPainters, graphMinMax, tools, isXAxis: false, isFirst: true);
        _addEdgeTick<TY>(tickPainters, graphMinMax, tools, isXAxis: false, isFirst: false);
    }

    void _addEdgeTick<T>(
        List<PositionedTextPainter> tickPainters,
        DoubleMinMax graphMinMax,
        GenericTools<T> tools, {
            required bool isXAxis,
            required bool isFirst
        }
    )
    {
        if (DEBUG)
            logDebug('_addEdgeTick');

        final T minMax = isXAxis ? data.minMax.minX as T : data.minMax.minY as T;
        final T maxMax = isXAxis ? data.minMax.maxX as T : data.minMax.maxY as T;
        final double doubleMin = isXAxis ? doubleData.minMax.minX : doubleData.minMax.minY;
        final double doubleMax = isXAxis ? doubleData.minMax.maxX : doubleData.minMax.maxY;
        final double tickLineLength = isXAxis ? tickLineLengthX : tickLineLengthY;

        T value = isFirst ? tools.getNextNiceValueOrSame(minMax) : tools.getPreviousNiceValueOrSame(maxMax);
        double doubleValue = tools.toDouble(value);
        TextPainter painter = _createAndLayoutTextPainter(tools.format(value));
        double positionMiddle = (isXAxis ? _dataToPixelX(doubleData.minMax, graphMinMax, doubleValue) : _dataToPixelY(doubleData.minMax, graphMinMax, doubleValue));
        double positionMin = positionMiddle - painter.width / 2;
        double positionMax = positionMiddle + painter.width / 2;

        if (DEBUG)
        {
            logDebug('  value:             $value');
            logDebug('  doubleValue:       $doubleValue');
            logDebug('  painter:           ${painter.width} x ${painter.height}');
            logDebug('  positionMiddle:    $positionMiddle');
        }

        if (doubleValue < doubleMin)
            throw ChartsException('doubleValue ($doubleValue) is ${doubleMin - doubleValue} lower than min ($doubleMin)\n'
                '  value: $value  min: $minMax\n'
                '  value: ${tools.formatter.format(value).replaceAll('\n', '')}  min: ${tools.formatter.format(minMax).replaceAll('\n', '')}');

        if (doubleValue > doubleMax)
            throw ChartsException('doubleValue ($doubleValue) is ${doubleValue - doubleMax} greater than max ($doubleMax)\n'
                '  value: $value  max: $maxMax\n'
                '  value: ${tools.formatter.format(value).replaceAll('\n', '')}  max: ${tools.formatter.format(maxMax).replaceAll('\n', '')}');

        bool outOfBounds() => isFirst
            ? positionMiddle - painter.width / 2 < (isXAxis ? graphMinMax.minX - paddingBetweenTickLabelAndTickLineX : graphMinMax.minY - paddingBetweenTickLabelAndTickLineY) - tickLineLength
            : positionMiddle + painter.width / 2 > (isXAxis ? graphMinMax.maxX + paddingBetweenTickLabelAndTickLineX : graphMinMax.maxY + paddingBetweenTickLabelAndTickLineY) + tickLineLength;

        while (outOfBounds())
        {
            if (DEBUG)
                logWarning(isFirst
                        ? (isXAxis
                            ? '  Correcting to next value because $positionMin too far to the left of ${graphMinMax.minX - paddingBetweenTickLabelAndTickLineX - tickLineLength}'
                            : '  Correcting to next value because $positionMin is  too far to the top of ${graphMinMax.minY - paddingBetweenTickLabelAndTickLineY - tickLineLength}')
                        : (isXAxis
                            ? '  Correcting to previous value because $positionMax too far to the right of ${graphMinMax.maxX + paddingBetweenTickLabelAndTickLineX + tickLineLength}'
                            : '  Correcting to previous value because $positionMax too far to the bottom of ${graphMinMax.maxY + paddingBetweenTickLabelAndTickLineY + tickLineLength}'));

            value = isFirst
                ? tools.getNextNiceValue(value)
                : tools.getPreviousNiceValue(value);
            doubleValue = tools.toDouble(value);

            if (DEBUG)
            {
                logDebug('  value:             $value');
                logDebug('  doubleValue:       $doubleValue');
            }

            if (doubleValue < doubleMin)
                throw ChartsException('doubleValue ($doubleValue) is ${doubleMin - doubleValue} lower than min ($doubleMin)\n'
                    '  value: $value  min: $minMax\n'
                    '  value: ${tools.formatter.format(value).replaceAll('\n', '')}  min: ${tools.formatter.format(minMax).replaceAll('\n', '')}');

            if (doubleValue > doubleMax)
                throw ChartsException('doubleValue ($doubleValue) is ${doubleValue - doubleMax} greater than max ($doubleMax)\n'
                    '  value: $value  max: $maxMax\n'
                    '  value: ${tools.formatter.format(value).replaceAll('\n', '')}  max: ${tools.formatter.format(maxMax).replaceAll('\n', '')}');

            painter = _createAndLayoutTextPainter(tools.format(value));
            positionMiddle = (isXAxis ? _dataToPixelX(doubleData.minMax, graphMinMax, doubleValue) : _dataToPixelY(doubleData.minMax, graphMinMax, doubleValue));
            positionMin = positionMiddle - painter.width / 2;
            positionMax = positionMiddle + painter.width / 2;

            if (DEBUG)
            {
                logDebug('  painter:           ${painter.width} x ${painter.height}');
                logDebug('  positionMiddle:    $positionMiddle');
            }
        }

        tickPainters.add(PositionedTextPainter(doubleValue, painter));
    }
}
