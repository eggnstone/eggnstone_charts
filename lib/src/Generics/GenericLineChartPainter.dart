import 'dart:math';

import 'package:eggnstone_dart/eggnstone_dart.dart';
import 'package:flutter/material.dart';

import '../ChartStyle.dart';
import '../PositionedTextPainter.dart';
import '../Specifics/DoubleChartData.dart';
import '../Specifics/DoubleLineData.dart';
import '../Specifics/DoubleMinMax.dart';
import 'GenericChartData.dart';
import 'GenericMinMax.dart';
import 'GenericTools.dart';

/*enum Axis
{
    XAxis,
    YAxis
}*/

class GenericLineChartPainter<TX, TY> extends CustomPainter
{
    static const bool DEBUG = true;
    static const bool DEBUG_DATA_TO_PIXEL = false;

    static const double paddingHorizontalOuter = 4;
    static const double paddingHorizontalInner = 8;
    static const double paddingHorizontalTicks = 8;

    static const double paddingVerticalOuter = 4;
    static const double paddingVerticalInner = 8;
    static const double paddingVerticalTicks = 8;

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
        if (DEBUG)
        {
            //logDebug('\n\n\nLineChartPainter.linePaint() Size: $size');
            logDebug('LineChartPainter.linePaint() Size: $size');
            logDebug('  data.minMax:            ${data.minMax}');
            logDebug('  doubleData.minMax:      ${doubleData.minMax}');
        }

        if (data.lines.size != data.colors.size)
        {
            _showError(canvas, size, 'Mismatch between lines and colors');
            return;
        }

        if (data.lines.isEmpty())
        {
            _showError(canvas, size, 'No data');
            return;
        }

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

        String? errorMessage;

        xAxisPainters.clear();
        errorMessage = _addXAxisTicks(xAxisPainters, graphMinMax, data.toolsX);
        if (errorMessage != null)
        {
            _showError(canvas, size, errorMessage);
            return;
        }

        yAxisPainters.clear();
        errorMessage = _addYAxisTicks(yAxisPainters, graphMinMax, data.toolsY);
        if (errorMessage != null)
        {
            _showError(canvas, size, errorMessage);
            return;
        }

        if (DEBUG)
        {
            logDebug('  data.minMax:       ${doubleData.minMax}');
            logDebug('  graphMinMax:       $graphMinMax');
        }

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
        {
            logWarning('result < graphMinMax.minX');
            return graphMinMax.minX;
        }

        if (result > graphMinMax.maxX)
        {
            logWarning('result > graphMinMax.maxX');
            return graphMinMax.maxX;
        }

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
        {
            logWarning('result < graphMinMax.minY');
            return graphMinMax.minY;
        }

        if (result > graphMinMax.maxY)
        {
            logWarning('result > graphMinMax.maxY');
            return graphMinMax.maxY;
        }

        return result;
    }

    DoubleMinMax _calcGraphMinMax(Size size, List<PositionedTextPainter> xAxisPainters, List<PositionedTextPainter> yAxisPainters)
    {
        final double maxWidth = _calcMaxPainterWidth(xAxisPainters);
        final double maxHeight = _calcMaxPainterHeight(yAxisPainters);

        final double chartStartX = paddingHorizontalOuter + maxWidth + paddingHorizontalInner;
        final double chartStartY = paddingVerticalOuter + maxHeight + paddingVerticalInner;
        final double chartEndX = size.width - paddingHorizontalOuter - maxWidth - paddingHorizontalInner;
        final double chartEndY = size.height - paddingVerticalOuter - maxHeight - paddingVerticalInner;

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
            _drawLine(canvas, paint, graphMinMax.minX - paddingHorizontalInner, endY, graphMinMax.minX, endY);
            painter.textPainter.paint(canvas, Offset(graphMinMax.minX - paddingHorizontalInner - painter.textPainter.width, endY - painter.textPainter.height / 2));
        }
    }

    void _paintTextPaintersTop(Canvas canvas, Paint paint, List<PositionedTextPainter> painters, DoubleMinMax graphMinMax)
    {
        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter painter = painters[i];
            final double endX = _dataToPixelX(doubleData.minMax, graphMinMax, painter.position);
            _drawLine(canvas, paint, endX, graphMinMax.minY - paddingVerticalInner, endX, graphMinMax.minY);
            painter.textPainter.paint(canvas, Offset(endX - painter.textPainter.width / 2, graphMinMax.minY - paddingVerticalInner - painter.textPainter.height));
        }
    }

    void _paintTextPaintersRight(Canvas canvas, Paint paint, List<PositionedTextPainter> painters, DoubleMinMax graphMinMax)
    {
        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter painter = painters[i];
            final double startY = _dataToPixelY(doubleData.minMax, graphMinMax, painter.position);
            _drawLine(canvas, paint, graphMinMax.maxX, startY, graphMinMax.maxX + paddingHorizontalInner, startY);
            painter.textPainter.paint(canvas, Offset(graphMinMax.maxX + paddingHorizontalInner, startY - painter.textPainter.height / 2));
        }
    }

    void _paintTextPaintersBottom(Canvas canvas, Paint paint, List<PositionedTextPainter> painters, DoubleMinMax graphMinMax)
    {
        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter painter = painters[i];
            final double startX = _dataToPixelX(doubleData.minMax, graphMinMax, painter.position);
            _drawLine(canvas, paint, startX, graphMinMax.maxY, startX, graphMinMax.maxY + paddingVerticalInner);
            painter.textPainter.paint(canvas, Offset(startX - painter.textPainter.width / 2, graphMinMax.maxY + paddingVerticalInner));
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
        logError(s);

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

    String? _addXAxisTicks(List<PositionedTextPainter> tickPainters, DoubleMinMax graphMinMax, GenericTools<TX> tools)
    {
        if (DEBUG)
            logDebug('_addXAxisTicks');

        TX firstData = tools.getNextValue(data.minMax.minX);
        double firstDoubleData = tools.toDouble(firstData);
        TextPainter firstPainter = _createAndLayoutTextPainter(tools.format(firstData));
        double firstPosition = _dataToPixelX(doubleData.minMax, graphMinMax, firstDoubleData) - firstPainter.width / 2;

        if (DEBUG)
        {
            logDebug('  graphMinMax:       $graphMinMax');
            logDebug('  data.minMax:       ${data.minMax}');
            logDebug('  doubleData.minMax: ${doubleData.minMax}');
            logDebug('  firstData:         $firstData');
            logDebug('  firstDoubleData:   $firstDoubleData');
            logDebug('  firstPainter:      ${firstPainter.width} x ${firstPainter.height}');
            logDebug('  firstPosition:     $firstPosition');
        }

        if (firstDoubleData < doubleData.minMax.minX)
            return 'firstDoubleData ($firstDoubleData) is ${doubleData.minMax.minX - firstDoubleData} lower than min (${doubleData.minMax.minX})\n'
            '  firstData: $firstData}  min: ${data.minMax.minX}\n'
            '  firstData: ${tools.formatter.format(firstData).replaceAll('\n', '')}  min: ${tools.formatter.format(data.minMax.minX).replaceAll('\n', '')}';

        if (firstDoubleData > doubleData.minMax.maxX)
            return 'firstDoubleData ($firstDoubleData) is ${firstDoubleData - doubleData.minMax.maxX} greater than max (${doubleData.minMax.maxX})\n'
            '  firstData: $firstData}  max: ${data.minMax.maxX}\n'
            '  firstData: ${tools.formatter.format(firstData).replaceAll('\n', '')}  max: ${tools.formatter.format(data.minMax.maxX).replaceAll('\n', '')}';

        while (firstPosition < graphMinMax.minX - paddingHorizontalInner)
        {
            firstData = tools.getNextValue(firstData);
            firstDoubleData = tools.toDouble(firstData);

            if (DEBUG)
            {
                logDebug('  Correcting to next value');
                logDebug('  firstData:         $firstData');
                logDebug('  firstDoubleData:   $firstDoubleData');
            }

            if (firstDoubleData < doubleData.minMax.minX)
                return 'firstDoubleData ($firstDoubleData) is ${doubleData.minMax.minX - firstDoubleData} lower than min (${doubleData.minMax.minX})\n'
                '  firstData: $firstData}  min: ${data.minMax.minX}\n'
                '  firstData: ${tools.formatter.format(firstData).replaceAll('\n', '')}  min: ${tools.formatter.format(data.minMax.minX).replaceAll('\n', '')}';

            if (firstDoubleData > doubleData.minMax.maxX)
                return 'firstDoubleData ($firstDoubleData) is ${firstDoubleData - doubleData.minMax.maxX} greater than max (${doubleData.minMax.maxX})\n'
                '  firstData: $firstData}  max: ${data.minMax.maxX}\n'
                '  firstData: ${tools.formatter.format(firstData).replaceAll('\n', '')}  max: ${tools.formatter.format(data.minMax.maxX).replaceAll('\n', '')}';

            firstPainter = _createAndLayoutTextPainter(tools.format(firstData));
            firstPosition = _dataToPixelX(doubleData.minMax, graphMinMax, firstDoubleData) - firstPainter.width / 2;

            if (DEBUG)
            {
                logDebug('  firstPainter:      ${firstPainter.width} x ${firstPainter.height}');
                logDebug('  firstPosition:     $firstPosition');

                logDebug('  NEXT');
            }
        }

        if (DEBUG)
            logDebug('  DONE');

        tickPainters.add(PositionedTextPainter(firstDoubleData, firstPainter));

        //tickPainters.add(PositionedTextPainter(doubleData.minMax.maxX, _createAndLayoutTextPainter(tools.format(data.minMax.maxX))));

        return null;
    }

    String? _addYAxisTicks(List<PositionedTextPainter> tickPainters, DoubleMinMax graphMinMax, GenericTools<TY> tools)
    {
        if (DEBUG)
            logDebug('_addYAxisTicks');

        TY firstData = tools.getNextValue(data.minMax.minY);
        double firstDoubleData = tools.toDouble(firstData);
        TextPainter firstPainter = _createAndLayoutTextPainter(tools.format(firstData));
        double firstPosition = _dataToPixelX(doubleData.minMax, graphMinMax, firstDoubleData) - firstPainter.width / 2;

        if (DEBUG)
        {
            logDebug('  graphMinMax:       $graphMinMax');
            logDebug('  data.minMax:       ${data.minMax}');
            logDebug('  doubleData.minMax: ${doubleData.minMax}');
            logDebug('  firstData:         $firstData');
            logDebug('  firstDoubleData:   $firstDoubleData');
            logDebug('  firstPainter:      ${firstPainter.width} x ${firstPainter.height}');
            logDebug('  firstPosition:     $firstPosition');
        }

        if (firstDoubleData < doubleData.minMax.minY)
            return 'firstDoubleData ($firstDoubleData) is ${doubleData.minMax.minY - firstDoubleData} lower than min (${doubleData.minMax.minY})\n'
            '  firstData: $firstData}  min: ${data.minMax.minY}\n'
            '  firstData: ${tools.formatter.format(firstData).replaceAll('\n', '')}  min: ${tools.formatter.format(data.minMax.minY).replaceAll('\n', '')}';

        if (firstDoubleData > doubleData.minMax.maxY)
            return 'firstDoubleData ($firstDoubleData) is ${firstDoubleData - doubleData.minMax.maxY} greater than max (${doubleData.minMax.maxY})\n'
            '  firstData: $firstData}  max: ${data.minMax.maxY}\n'
            '  firstData: ${tools.formatter.format(firstData).replaceAll('\n', '')}  max: ${tools.formatter.format(data.minMax.maxY).replaceAll('\n', '')}';

        while (firstPosition < graphMinMax.minY - paddingVerticalInner)
        {
            firstData = tools.getNextValue(firstData);
            firstDoubleData = tools.toDouble(firstData);

            if (DEBUG)
            {
                logDebug('  Correcting to next value');
                logDebug('  firstData:         $firstData');
                logDebug('  firstDoubleData:   $firstDoubleData');
            }

            if (firstDoubleData < doubleData.minMax.minY)
                return 'firstDoubleData ($firstDoubleData) is ${doubleData.minMax.minY - firstDoubleData} lower than min (${doubleData.minMax.minY})\n'
                '  firstData: $firstData}  min: ${data.minMax.minY}\n'
                '  firstData: ${tools.formatter.format(firstData).replaceAll('\n', '')}  min: ${tools.formatter.format(data.minMax.minY).replaceAll('\n', '')}';

            if (firstDoubleData > doubleData.minMax.maxY)
                return 'firstDoubleData ($firstDoubleData) is ${firstDoubleData - doubleData.minMax.maxY} greater than max (${doubleData.minMax.maxY})\n'
                '  firstData: $firstData}  max: ${data.minMax.maxY}\n'
                '  firstData: ${tools.formatter.format(firstData).replaceAll('\n', '')}  max: ${tools.formatter.format(data.minMax.maxY).replaceAll('\n', '')}';

            firstPainter = _createAndLayoutTextPainter(tools.format(firstData));
            firstPosition = _dataToPixelX(doubleData.minMax, graphMinMax, firstDoubleData) - firstPainter.width / 2;

            if (DEBUG)
            {
                logDebug('  firstPainter:      ${firstPainter.width} x ${firstPainter.height}');
                logDebug('  firstPosition:     $firstPosition');

                logDebug('  NEXT');
            }
        }

        if (DEBUG)
            logDebug('  DONE');

        tickPainters.add(PositionedTextPainter(firstDoubleData, firstPainter));

        //tickPainters.add(PositionedTextPainter(doubleData.minMax.maxX, _createAndLayoutTextPainter(tools.format(data.minMax.maxX))));

        return null;
    }
}
