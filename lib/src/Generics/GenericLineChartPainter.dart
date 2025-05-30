import 'dart:math';

import 'package:eggnstone_dart/eggnstone_dart.dart';
import 'package:flutter/material.dart';

import '../ChartStyle.dart';
import '../ChartsUserException.dart';
import '../DataTools.dart';
import '../PaintInfo.dart';
import '../PositionedTextPainter.dart';
import '../Specifics/DoubleChartData.dart';
import '../Specifics/DoubleLineData.dart';
import '../Specifics/DoubleMinMax.dart';
import 'GenericChartData.dart';
import 'GenericTools.dart';

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
    final String dataTipFormat;
    final DoubleChartData doubleData;
    final Brightness? brightness;
    final Offset? pointerPosition;

    GenericLineChartPainter({
        required this.chartStyle,
        required this.customData,
        required this.doubleData,
        this.brightness,
        this.dataTipFormat = 'X: %x\nY: %y',
        this.pointerPosition
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

        _drawLines(paintInfo);

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

        _drawDataTip(paintInfo);
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

            if (painter.position > paintInfo.graphMinMax.minY && painter.position < paintInfo.graphMinMax.maxY)
            {
                final Paint gridPaint = textPainter == null ? paintInfo.gridPaint2 : paintInfo.gridPaint;
                _drawLine(paintInfo.canvas, gridPaint, paintInfo.graphMinMax.minX, painter.position, paintInfo.graphMinMax.maxX, painter.position);
            }

            if (textPainter != null)
            {
                _drawLine(paintInfo.canvas, paintInfo.borderPaint, paintInfo.graphMinMax.minX - tickLineLengthX, painter.position, paintInfo.graphMinMax.minX, painter.position);
                textPainter.paint(paintInfo.canvas, Offset(paintInfo.graphMinMax.minX - tickLineLengthX - paddingBetweenTickLabelAndTickLineX - textPainter.width, painter.position - textPainter.height / 2));
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
                _drawLine(paintInfo.canvas, paintInfo.borderPaint, painter.position, paintInfo.graphMinMax.minY - tickLineLengthY, painter.position, paintInfo.graphMinMax.minY);
                textPainter.paint(paintInfo.canvas, Offset(painter.position - textPainter.width / 2, paintInfo.graphMinMax.minY - tickLineLengthY - paddingBetweenTickLabelAndTickLineY - textPainter.height));
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
                _drawLine(paintInfo.canvas, paintInfo.borderPaint, paintInfo.graphMinMax.maxX, painter.position, paintInfo.graphMinMax.maxX + tickLineLengthX, painter.position);
                textPainter.paint(paintInfo.canvas, Offset(paintInfo.graphMinMax.maxX + tickLineLengthX + paddingBetweenTickLabelAndTickLineX, painter.position - textPainter.height / 2));
            }
        }
    }

    void _paintTextPaintersBottom<T>(PaintInfo paintInfo, List<PositionedTextPainter<T>> painters)
    {
        for (int i = 0; i < painters.length; i++)
        {
            final PositionedTextPainter<T> painter = painters[i];
            final TextPainter? textPainter = painter.textPainter;

            if (painter.position > paintInfo.graphMinMax.minX && painter.position < paintInfo.graphMinMax.maxX)
            {
                final Paint gridPaint = textPainter == null ? paintInfo.gridPaint2 : paintInfo.gridPaint;
                _drawLine(paintInfo.canvas, gridPaint, painter.position, paintInfo.graphMinMax.minY, painter.position, paintInfo.graphMinMax.maxY);
            }

            if (textPainter != null)
            {
                _drawLine(paintInfo.canvas, paintInfo.borderPaint, painter.position, paintInfo.graphMinMax.maxY, painter.position, paintInfo.graphMinMax.maxY + tickLineLengthY);
                textPainter.paint(paintInfo.canvas, Offset(painter.position - textPainter.width / 2, paintInfo.graphMinMax.maxY + tickLineLengthY + paddingBetweenTickLabelAndTickLineY));
            }
        }
    }

    void _drawLines(PaintInfo paintInfo)
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
                ..strokeWidth = chartStyle.lineWidth / chartStyle.devicePixelRatio
                ..style = PaintingStyle.fill;

            double lastX = paintInfo.graphMinMax.minX + (line.points[0].x - doubleData.minMax.minX) / doubleData.minMax.getWidth() * paintInfo.graphMinMax.getWidth();
            double lastY = paintInfo.graphMinMax.maxY - (line.points[0].y - doubleData.minMax.minY) / doubleData.minMax.getHeight() * paintInfo.graphMinMax.getHeight();
            paintInfo.canvas.drawCircle(Offset(lastX, lastY), chartStyle.pointRadius, linePaint);

            for (int i = 1; i < line.points.size; i++)
            {
                final double currentX = paintInfo.graphMinMax.minX + (line.points[i].x - doubleData.minMax.minX) / doubleData.minMax.getWidth() * paintInfo.graphMinMax.getWidth();
                final double currentY = paintInfo.graphMinMax.maxY - (line.points[i].y - doubleData.minMax.minY) / doubleData.minMax.getHeight() * paintInfo.graphMinMax.getHeight();

                _drawLine(paintInfo.canvas, linePaint, lastX, lastY, currentX, currentY);
                paintInfo.canvas.drawCircle(Offset(currentX, currentY), chartStyle.pointRadius, linePaint);
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

    Paint _createDataTipBackgroundPaint()
    => _createPaint(brightness == Brightness.dark ? chartStyle.dataTipBackgroundColorDark : chartStyle.dataTipBackgroundColor, PaintingStyle.fill);

    Paint _createBorderPaint()
    => _createPaint(brightness == Brightness.dark ? chartStyle.borderColorDark : chartStyle.borderColor);

    Paint _createGridPaint() 
    => _createPaint((brightness == Brightness.dark ? chartStyle.gridColorDark : chartStyle.gridColor).withAlpha(128));

    Paint _createGridPaint2()
    => _createPaint((brightness == Brightness.dark ? chartStyle.gridColorDark : chartStyle.gridColor).withAlpha(32));

    Paint _createPaint(Color color, [PaintingStyle style = PaintingStyle.stroke])
    {
        final Paint paint = Paint()
            ..color = color
            //..strokeWidth = 1
            ..strokeWidth = 1 / chartStyle.devicePixelRatio
            ..style = style;

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
            customDataValue: customDataLast
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
                logDebug('    Tick painter for $customDataLast at ${lastPainter.textStart.toStringAsFixed(1)} / ${lastPainter.position.toStringAsFixed(1)} / ${lastPainter.textEnd.toStringAsFixed(1)}');

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
                customDataValue: customDataValue
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
                    if (tickPainter.position >= graphMinMax.maxX)
                        break;
                }
                else
                {
                    if (tickPainter.position <= graphMinMax.minY)
                        break;
                }
            }
            else
            {
                if (DEBUG)
                    logDebug('    Tick painter for $customDataValue at ${tickPainter.textStart.toStringAsFixed(1)} / ${tickPainter.position.toStringAsFixed(1)} / ${tickPainter.textEnd.toStringAsFixed(1)}');

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
            required T customDataValue
        }
    )
    {
        final double doubleDataValue = tools.toDoubleValue(customDataValue);
        final TextPainter textPainter = _createAndLayoutTextPainter(tools.format(customDataValue), chartStyle);
        final double textPosition = axis == Axis.horizontal ? dataTools.dataToPixelX(doubleDataValue) : dataTools.dataToPixelY(doubleDataValue);
        final double textPositionStart = textPosition - (axis == Axis.horizontal ? textPainter.width : textPainter.height) / 2;
        final double textPositionEnd = textPosition + (axis == Axis.horizontal ? textPainter.width : textPainter.height) / 2;

        if (textPositionStart < textPositionMin)
        {
            if (DEBUG)
                logDebug('textPositionStart ($textPositionStart) < textPositionMin ($textPositionMin)');

            return PositionedTextPainter<T>(position: textPosition, textPainter: null);
        }

        if (textPositionEnd > textPositionMax)
        {
            if (DEBUG)
                logDebug('textPositionEnd ($textPositionEnd) > textPositionMax ($textPositionMax)');

            return PositionedTextPainter<T>(position: textPosition, textPainter: null);
        }

        return PositionedTextPainter<T>(position: textPosition, textPainter: textPainter);
    }

    void _drawDataTip(PaintInfo paintInfo)
    {
        if (pointerPosition == null)
            return;

        final DataTools dataTools = DataTools(doubleData.minMax, paintInfo.graphMinMax);
        if (dataTools.pixelToDataX(pointerPosition!.dx + tickLineLengthX) < doubleData.minMax.minX
            || dataTools.pixelToDataX(pointerPosition!.dx - tickLineLengthX) > doubleData.minMax.maxX
            || dataTools.pixelToDataY(pointerPosition!.dy - tickLineLengthY) < doubleData.minMax.minY
            || dataTools.pixelToDataY(pointerPosition!.dy + tickLineLengthY) > doubleData.minMax.maxY)
            return;

        final TX customDataX = customData.toolsX.toCustomValue(dataTools.pixelToDataX(pointerPosition!.dx));
        final TY customDataY = customData.toolsY.toCustomValue(dataTools.pixelToDataY(pointerPosition!.dy));
        final String customDataXString = customData.toolsX.formatDataTip(customDataX);
        final String customDataYString = customData.toolsY.formatDataTip(customDataY);

        //final String dataTipFormat = dataTipStyle?.format ?? 'X: %x\nY: %y';
        final String dataTipText = dataTipFormat.replaceFirst('%x', customDataXString).replaceFirst('%y', customDataYString);
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
}
