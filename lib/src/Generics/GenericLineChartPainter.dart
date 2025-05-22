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

class GenericLineChartPainter<TX, TY> extends CustomPainter
{
    static const bool DEBUG = false;
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
        required this.style
    }) : doubleData = data.getDoubleChartData();

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

        final List<PositionedTextPainter> leftTickPainters = <PositionedTextPainter>
        [
            PositionedTextPainter(doubleData.minMax.minY, _createAndLayoutTextPainter(data.toolsY.format(data.minMax.minY))),
            PositionedTextPainter(doubleData.minMax.maxY, _createAndLayoutTextPainter(data.toolsY.format(data.minMax.maxY)))
        ];

        final List<PositionedTextPainter> topTickPainters = <PositionedTextPainter>
        [
            PositionedTextPainter(doubleData.minMax.minX, _createAndLayoutTextPainter(data.toolsX.format(data.minMax.minX))),
            PositionedTextPainter(doubleData.minMax.maxX, _createAndLayoutTextPainter(data.toolsX.format(data.minMax.maxX)))
        ];

        final List<PositionedTextPainter> rightTickPainters = <PositionedTextPainter>
        [
            PositionedTextPainter(doubleData.minMax.minY, _createAndLayoutTextPainter(data.toolsY.format(data.minMax.minY))),
            PositionedTextPainter(doubleData.minMax.maxY, _createAndLayoutTextPainter(data.toolsY.format(data.minMax.maxY)))
        ];

        final List<PositionedTextPainter> bottomTickPainters = <PositionedTextPainter>
        [
            PositionedTextPainter(doubleData.minMax.minX, _createAndLayoutTextPainter(data.toolsX.format(data.minMax.minX))),
            PositionedTextPainter(doubleData.minMax.maxX, _createAndLayoutTextPainter(data.toolsX.format(data.minMax.maxX)))
        ];

        final DoubleMinMax graphMinMax = _calcGraphMinMax(size, leftTickPainters, topTickPainters, rightTickPainters, bottomTickPainters);
        TX firstTopDataX = data.toolsX.getNextValue(data.minMax.minX);
        double firstTopDoubleDataX = data.toolsX.toDouble(firstTopDataX);
        TextPainter firstTopPainter = _createAndLayoutTextPainter(data.toolsX.format(firstTopDataX));
        double firstTopGraphX = _dataToPixelX(doubleData.minMax, graphMinMax, firstTopDoubleDataX) - firstTopPainter.width / 2;

        if (DEBUG)
        {
            logDebug('  graphMinMax:            $graphMinMax');
            logDebug('  data.minMax.minX:       ${data.minMax.minX}');
            logDebug('  doubleData.minMax.minX: ${doubleData.minMax.minX}');
            logDebug('  firstTopDataX:          $firstTopDataX');
            logDebug('  firstTopDoubleDataX:    $firstTopDoubleDataX');
            logDebug('  firstTopPainter:        ${firstTopPainter.width} x ${firstTopPainter.height}');
            logDebug('  firstTopGraphX:         $firstTopGraphX');
        }

        if (firstTopDoubleDataX < doubleData.minMax.minX)
        {
            logDebug('firstTopDoubleDataX:    $firstTopDoubleDataX');
            logDebug('doubleData.minMax.minX: ${doubleData.minMax.minX}');
            final String message = 'firstTopDoubleDataX ($firstTopDoubleDataX) is ${doubleData.minMax.minX - firstTopDoubleDataX} lower than minX (${doubleData.minMax.minX})\n'
                '  firstTopDataX: $firstTopDataX}  minX: ${data.minMax.minX}\n'
                '  firstTopDataX: ${data.toolsX.formatter.format(firstTopDataX).replaceAll('\n', '')}  minX: ${data.toolsX.formatter.format(data.minMax.minX).replaceAll('\n', '')}';
            _showError(canvas, size, message);
            return;
        }

        if (firstTopDoubleDataX > doubleData.minMax.maxX)
        {
            final String message = 'firstTopDoubleDataX ($firstTopDoubleDataX) is greater than maxX (${doubleData.minMax.maxX})\n'
                '  firstTopDataX: $firstTopDataX}  maxX: ${data.minMax.maxX}\n'
                '  firstTopDataX: ${data.toolsX.formatter.format(firstTopDataX).replaceAll('\n', '')}  maxX: ${data.toolsX.formatter.format(data.minMax.maxX).replaceAll('\n', '')}';
            _showError(canvas, size, message);
            return;
        }

        while (firstTopGraphX < graphMinMax.minX - paddingHorizontalInner)
        {
            firstTopDataX = data.toolsX.getNextValue(firstTopDataX);
            firstTopDoubleDataX = data.toolsX.toDouble(firstTopDataX);

            if (DEBUG)
            {
                logDebug('  Correcting to next value');
                logDebug('  firstTopDataX:          $firstTopDataX');
                logDebug('  firstTopDoubleDataX:    $firstTopDoubleDataX');
            }

            if (firstTopDoubleDataX < doubleData.minMax.minX)
            {
                final String message = 'firstTopDoubleDataX ($firstTopDoubleDataX) is lower than minX (${doubleData.minMax.minX})\n'
                    '  firstTopDataX: $firstTopDataX}  minX: ${data.minMax.minX}\n'
                    '  firstTopDataX: ${data.toolsX.formatter.format(firstTopDataX).replaceAll('\n', '')}  minX: ${data.toolsX.formatter.format(data.minMax.minX).replaceAll('\n', '')}';
                _showError(canvas, size, message);
                return;
            }

            if (firstTopDoubleDataX > doubleData.minMax.maxX)
            {
                final String message = 'firstTopDoubleDataX ($firstTopDoubleDataX) is greater than maxX (${doubleData.minMax.maxX})\n'
                    '  firstTopDataX: $firstTopDataX}  maxX: ${data.minMax.maxX}\n'
                    '  firstTopDataX: ${data.toolsX.formatter.format(firstTopDataX).replaceAll('\n', '')}  maxX: ${data.toolsX.formatter.format(data.minMax.maxX).replaceAll('\n', '')}';
                _showError(canvas, size, message);
                return;
            }

            firstTopPainter = _createAndLayoutTextPainter(data.toolsX.format(firstTopDataX));
            firstTopGraphX = _dataToPixelX(doubleData.minMax, graphMinMax, firstTopDoubleDataX) - firstTopPainter.width / 2;

            if (DEBUG)
            {
                logDebug('  firstTopPainter:        ${firstTopPainter.width} x ${firstTopPainter.height}');
                logDebug('  firstTopGraphX:         $firstTopGraphX');
            }

            if (DEBUG)
                logDebug('  NEXT');
        }

        if (DEBUG)
            logDebug('  DONE');

        topTickPainters.clear();
        topTickPainters.add(PositionedTextPainter(firstTopDoubleDataX, firstTopPainter));
        topTickPainters.add(PositionedTextPainter(doubleData.minMax.maxX, _createAndLayoutTextPainter(data.toolsX.format(data.minMax.maxX))));

        //_addTicksY(topTickPainters, doubleData.minMax, graphMinMax, data.toolsX);

        if (DEBUG)
        {
            logDebug('  data.minMax:       ${doubleData.minMax}');
            logDebug('  graphMinMax:       $graphMinMax');
        }

        final Paint borderPaint = _createBorderPaint();
        canvas.drawRect(Rect.fromLTRB(graphMinMax.minX, graphMinMax.minY, graphMinMax.maxX, graphMinMax.maxY), borderPaint);

        _paintTextPaintersLeft(canvas, borderPaint, leftTickPainters, graphMinMax);
        _paintTextPaintersTop(canvas, borderPaint, topTickPainters, graphMinMax);
        _paintTextPaintersRight(canvas, borderPaint, rightTickPainters, graphMinMax);
        _paintTextPaintersBottom(canvas, borderPaint, bottomTickPainters, graphMinMax);

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
    bool shouldRepaint(covariant CustomPainter oldDelegate)
    => false;

    void _drawLine(Canvas canvas, Paint paint, double x1, double y1, double x2, double y2)
    => canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);

    TextPainter _createAndLayoutTextPainter(String text)
    {
        final TextPainter tp = TextPainter(
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

        if (DEBUG)
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

    DoubleMinMax _calcGraphMinMax(Size size, List<PositionedTextPainter> leftTickPainters, List<PositionedTextPainter> topTickPainters, List<PositionedTextPainter> rightTickPainters, List<PositionedTextPainter> bottomTickPainters)
    {
        final double maxWidthLeft = _calcMaxPainterWidth(leftTickPainters);
        final double maxHeightTop = _calcMaxPainterHeight(topTickPainters);
        final double maxWidthRight = _calcMaxPainterWidth(rightTickPainters);
        final double maxHeightBottom = _calcMaxPainterHeight(bottomTickPainters);

        final double chartStartXViaLeft = maxWidthLeft;
        /*final double chartStartXViaTop = topTickPainters.first.textPainter.width / 2;
        final double chartStartXViaBottom = bottomTickPainters.first.textPainter.width / 2;
        final double chartStartX = paddingHorizontalOuter + max(chartStartXViaLeft, max(chartStartXViaTop, chartStartXViaBottom)) + paddingHorizontalInner;*/
        final double chartStartX = paddingHorizontalOuter + chartStartXViaLeft + paddingHorizontalInner;

        final double chartStartYViaTop = maxHeightTop;
        /*final double chartStartYViaLeft = leftTickPainters.first.textPainter.height / 2;
        final double chartStartYViaRight = rightTickPainters.first.textPainter.height / 2;
        final double chartStartY = paddingVerticalOuter + max(chartStartYViaTop, max(chartStartYViaLeft, chartStartYViaRight)) + paddingVerticalInner;*/
        final double chartStartY = paddingVerticalOuter + chartStartYViaTop + paddingVerticalInner;

        final double chartEndXViaRight = maxWidthRight;
        /*final double chartEndXViaTop = topTickPainters.last.textPainter.width / 2;
        final double chartEndXViaBottom = bottomTickPainters.last.textPainter.width / 2;
        final double chartEndX = size.width - paddingHorizontalOuter - max(chartEndXViaRight, max(chartEndXViaTop, chartEndXViaBottom)) - paddingHorizontalInner;*/
        final double chartEndX = size.width - paddingHorizontalOuter - chartEndXViaRight - paddingHorizontalInner;

        final double chartEndYViaBottom = maxHeightBottom;
        /*final double chartEndYViaLeft = leftTickPainters.last.textPainter.height / 2;
        final double chartEndYViaRight = rightTickPainters.last.textPainter.height / 2;
        final double chartEndY = size.height - paddingVerticalOuter - max(chartEndYViaBottom, max(chartEndYViaLeft, chartEndYViaRight)) - paddingVerticalInner;*/
        final double chartEndY = size.height - paddingVerticalOuter - chartEndYViaBottom - paddingVerticalInner;

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

            final double startY = endY;
            /*if (i == 0)
                startY -= painter.textPainter.height / 2 - paddingVerticalInner;
            else if (i == painters.length - 1)
                startY += painter.textPainter.height / 2 - paddingVerticalInner;*/

            painter.textPainter.paint(canvas, Offset(graphMinMax.minX - paddingHorizontalInner - painter.textPainter.width, startY - painter.textPainter.height / 2));
        }
    }

    void _paintTextPaintersTop(Canvas canvas, Paint paint, List<PositionedTextPainter> painters, DoubleMinMax graphMinMax)
    {
        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter painter = painters[i];
            final double endX = _dataToPixelX(doubleData.minMax, graphMinMax, painter.position);
            _drawLine(canvas, paint, endX, graphMinMax.minY - paddingVerticalInner, endX, graphMinMax.minY);

            final double startX = endX;
            /*if (i == 0)
                startX += painter.textPainter.width / 2 - paddingHorizontalInner;
            else if (i == painters.length - 1)
                startX -= painter.textPainter.width / 2 - paddingHorizontalInner;*/

            painter.textPainter.paint(canvas, Offset(startX - painter.textPainter.width / 2, graphMinMax.minY - paddingVerticalInner - painter.textPainter.height));
        }
    }

    void _paintTextPaintersRight(Canvas canvas, Paint paint, List<PositionedTextPainter> painters, DoubleMinMax graphMinMax)
    {
        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter painter = painters[i];
            final double startY = _dataToPixelY(doubleData.minMax, graphMinMax, painter.position);
            _drawLine(canvas, paint, graphMinMax.maxX, startY, graphMinMax.maxX + paddingHorizontalInner, startY);

            final double endY = startY;
            /*if (i == 0)
                endY -= painter.textPainter.height / 2 - paddingVerticalInner;
            else if (i == painters.length - 1)
                endY += painter.textPainter.height / 2 - paddingVerticalInner;*/

            painter.textPainter.paint(canvas, Offset(graphMinMax.maxX + paddingHorizontalInner, endY - painter.textPainter.height / 2));
        }
    }

    void _paintTextPaintersBottom(Canvas canvas, Paint paint, List<PositionedTextPainter> painters, DoubleMinMax graphMinMax)
    {
        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter painter = painters[i];
            final double startX = _dataToPixelX(doubleData.minMax, graphMinMax, painter.position);
            _drawLine(canvas, paint, startX, graphMinMax.maxY, startX, graphMinMax.maxY + paddingVerticalInner);

            final double endX = startX;
            /*if (i == 0)
                endX += painter.textPainter.width / 2 - paddingHorizontalInner;
            else if (i == painters.length - 1)
                endX -= painter.textPainter.width / 2 - paddingHorizontalInner;*/

            painter.textPainter.paint(canvas, Offset(endX - painter.textPainter.width / 2, graphMinMax.maxY + paddingVerticalInner));
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

        final TextPainter tp = TextPainter(
            text: TextSpan(style: TextStyle(color: style.textColor, fontSize: style.fontSize * 1.5), text: s),
            textDirection: TextDirection.ltr
        );
        tp.layout();
        tp.paint(canvas, Offset(size.width / 2 - tp.width / 2, size.height / 2 - tp.height / 2));

        final DoubleMinMax graphMinMax = _calcGraphMinMax(size, <PositionedTextPainter>[], <PositionedTextPainter>[], <PositionedTextPainter>[], <PositionedTextPainter>[]);
        canvas.drawRect(Rect.fromLTRB(graphMinMax.minX, graphMinMax.minY, graphMinMax.maxX, graphMinMax.maxY), _createBorderPaint());
    }

    Paint _createBorderPaint()
    {
        final Paint borderPaint = Paint()
            ..color = style.lineColor ?? Colors.black
            ..strokeWidth = 1 // / style.devicePixelRatio;
            ..style = PaintingStyle.stroke;

        return borderPaint;
    }
}
