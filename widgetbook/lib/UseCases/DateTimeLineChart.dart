import 'package:collection/collection.dart';
import 'package:eggnstone_charts/eggnstone_charts.dart';
import 'package:eggnstone_dart/eggnstone_dart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kt_dart/collection.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

// UseCases

@UseCase(path: 'Errors', name: 'One date only', type: DateTimeLineChart)
Widget buildDateTimeChartForOnlyOneDate(BuildContext context)
=> _buildChart(context, 'One date only', _createDateTimeChartDataForOnlyOneDate(context));

@UseCase(path: '', name: 'Normal 0', type: DateTimeLineChart)
Widget buildDateTimeChartForNormalDisplay0(BuildContext context)
=> _buildChart(context, 'Normal 0', _createDateTimeChartDataForDisplay(context));

@UseCase(path: '', name: 'Normal 1', type: DateTimeLineChart)
Widget buildDateTimeChartForNormalDisplay1(BuildContext context)
=> _buildChart(context, 'Normal 1', _createDateTimeChartDataForDisplay(context, start: 1));

@UseCase(path: '', name: 'Inverted 0', type: DateTimeLineChart)
Widget buildDateTimeChartForInvertedDisplay0(BuildContext context)
=> _buildChart(context, 'Inverted 0', _createDateTimeChartDataForDisplay(context, invertY: true), invertY: true);

@UseCase(path: '', name: 'Inverted 1', type: DateTimeLineChart)
Widget buildDateTimeChartForInvertedDisplay1(BuildContext context)
=> _buildChart(context, 'Inverted 1', _createDateTimeChartDataForDisplay(context, start: 1, invertY: true), invertY: true);

@UseCase(path: '', name: 'One date only (fixed)', type: DateTimeLineChart)
Widget buildDateTimeChartForOnlyOneDateFixed(BuildContext context)
=> _buildChart(context, 'One date only (fixed)', _createDateTimeChartDataForOnlyOneDateFixed(context));

@UseCase(path: '', name: 'Two dates only', type: DateTimeLineChart)
Widget buildDateTimeChartForOnlyTwoDates(BuildContext context)
=> _buildChart(context, 'Two dates only', _createDateTimeChartDataForOnlyTwoDates(context));

@UseCase(path: '', name: 'Doc 1', type: DateTimeLineChart)
Widget buildDateTimeChartForDocOne(BuildContext context)
=> Center(
    child: SizedBox(
        width: 200,
        height: 300,
        child: _buildChart(
            context,
            'DateTime Sample',
            _createDateTimeChartDataForDocOne(context)
        )
    )
);

// Data

DateTimeChartData _createDateTimeChartDataForDisplay(BuildContext context, {int start = 0, bool invertY = false})
{
    final DateTime now = DateTime.now();
    return _createDateTimeChartData(
        context,
        referenceDateTime: now,
        colors: <Color>[Colors.red],
        dateTimePointLists: <List<DateTimePoint>>[_createDateTimePointsForLine1(now, start: start)],
        invertY: invertY,
        minX: -8,
        rangeInitialValueX: 2,
        rangeMinX: 2,
        rangeMaxX: 102,
        rangeStepsX: 2,
        minY: invertY ? -start.toDouble() : start.toDouble(),
        rangeMinY: 10 + start,
        rangeMaxY: 100 + start,
        rangeInitialValueY: 10 + start
    );
}

DateTimeChartData _createDateTimeChartDataForOnlyOneDate(BuildContext context, {bool invertY = false})
{
    final DateTime now = DateTime.now();
    return _createDateTimeChartData(
        context,
        referenceDateTime: now,
        colors: <Color>[Colors.red],
        dateTimePointLists: <List<DateTimePoint>>[_createDateTimePointsForOnlyOneDate(now)],
        invertY: invertY,
        minX: 0,
        rangeMinX: 0,
        rangeMaxX: 2,
        rangeStepsX: 2
    );
}

DateTimeChartData _createDateTimeChartDataForOnlyOneDateFixed(BuildContext context, {bool invertY = false})
{
    final DateTime now = DateTime.now();
    return _createDateTimeChartData(
        context,
        referenceDateTime: now,
        colors: <Color>[Colors.red],
        fixMinMax: true,
        dateTimePointLists: <List<DateTimePoint>>[_createDateTimePointsForOnlyOneDate(now)],
        invertY: invertY,
        minX: 0,
        rangeMinX: 0,
        rangeMaxX: 2,
        rangeStepsX: 2
    );
}

DateTimeChartData _createDateTimeChartDataForOnlyTwoDates(BuildContext context, {bool invertY = false})
{
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    return _createDateTimeChartData(
        context,
        referenceDateTime: today,
        colors: <Color>[Colors.red],
        fixMinMax: true,
        dateTimePointLists: <List<DateTimePoint>>[_createDateTimePointsForOnlyTwoDates(today)],
        invertY: invertY,
        minX: -1,
        rangeMinX: 0,
        rangeMaxX: 2,
        rangeStepsX: 2
    );
}

DateTimeChartData _createDateTimeChartDataForDocOne(BuildContext context)
{
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    return _createDateTimeChartData(
        context,
        referenceDateTime: today,
        colors: <Color>[Colors.green],
        dateTimePointLists: <List<DateTimePoint>>[_createDateTimePointsForDocOne(today)],
        rangeInitialValueX: 1,
        rangeInitialValueY: 7,
        minX: -8,
        rangeMinX: 1,
        rangeMaxX: 101,
        rangeMinY: 2,
        rangeMaxY: 11,
        rangeStepsX: 2,
        rangeStepsY: 2
    );
}

// Raw data

List<DateTimePoint> _createDateTimePointsForOnlyOneDate(DateTime referenceDateTime)
=> <DateTimePoint>
[
    DateTimePoint(referenceDateTime, 1)
];

List<DateTimePoint> _createDateTimePointsForOnlyTwoDates(DateTime referenceDateTime)
=> <DateTimePoint>
[
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 1)), 1),
    DateTimePoint(referenceDateTime, 2)
];

List<DateTimePoint> _createDateTimePointsForLine1(DateTime referenceDateTime, {int start = 0})
=> <DateTimePoint>
[
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 7)), start.toDouble()),
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 6)), start + 1),
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 5)), start + 2),
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 4)), start + 3),
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 3)), start + 4),
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 2)), start + 3),
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 1)), start + 1),
    DateTimePoint(referenceDateTime, start + 7)
];

List<DateTimePoint> _createDateTimePointsForDocOne(DateTime referenceDateTime)
=> <DateTimePoint>
[
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 7)), 1),
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 6)), 2),
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 5)), 3),
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 4)), 2),
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 3)), 3),
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 2)), 4),
    DateTimePoint(referenceDateTime.subtract(const Duration(days: 1)), 5),
    DateTimePoint(referenceDateTime, 6)
];

//

DateTimeChartData _createDateTimeChartData(
    BuildContext context, {
        required DateTime referenceDateTime,
        required List<Color> colors,
        required List<List<DateTimePoint>> dateTimePointLists,
        bool fixMinMax = false,
        int minX = -10,
        double minY = 0,
        int rangeMinX = -5,
        int rangeMaxX = 5,
        int rangeMinY = 10,
        int rangeMaxY = 100,
        int rangeStepsX = 3,
        int rangeStepsY = 3,
        int rangeInitialValueX = 0,
        int rangeInitialValueY = 10,
        bool invertY = false
    }
)
{
    final List<GenericDataSeries<DateTime, double>> convertedDateTimeDataSeriesList = dateTimePointLists
        .mapIndexed(
            (int index, List<DateTimePoint> points) 
            => GenericDataSeries<DateTime, double>(
                colors[index],
                'Data Series #${index + 1}',
                points.map((DateTimePoint dp) => invertY ? DateTimePoint(dp.x, -dp.y) : dp).toImmutableList()
            )
        )
        .toList();

    final int rangeX = context.knobs.int.slider(label: 'Range X', initialValue: rangeInitialValueX, min: rangeMinX, max: rangeMaxX, divisions: rangeStepsX);
    final double rangeY = context.knobs.int.slider(label: 'Range Y', initialValue: rangeInitialValueY, min: rangeMinY, max: rangeMaxY, divisions: rangeStepsY).toDouble();

    final DateTimeTools toolsX = DateTimeTools(DateTimeFormatter(DateFormat('dd.\nMM.\nyyyy')), DateTimeFormatter(DateFormat('dd.MM.yyyy')), useUtc: true);
    final DoubleTools toolsY = DoubleTools(DoubleFormatter(0, invert: invertY), DoubleFormatter(0, invert: invertY));
    DateTime dateTimeMinX = referenceDateTime.add(Duration(days: minX));
    DateTime dateTimeMaxX = referenceDateTime.add(Duration(days: rangeX));

    if (fixMinMax && dateTimeMinX == dateTimeMaxX)
    {
        final DateTime fixedMinDate = toolsX.getPreviousNiceCustomValue(dateTimeMinX);
        final DateTime fixedMaxDate = toolsX.getNextNiceCustomValue(dateTimeMaxX);
        //logDebug('minDate == maxDate ($minDate) => using fixed minDate: $fixedMinDate, maxDate: $fixedMaxDate');
        dateTimeMinX = fixedMinDate;
        dateTimeMaxX = fixedMaxDate;
    }

    return DateTimeChartData(
        dataSeriesList: convertedDateTimeDataSeriesList.toImmutableList(),
        toolsX: toolsX,
        toolsY: toolsY,
        minMax: DateTimeMinMax(
            minX: dateTimeMinX,
            maxX: dateTimeMaxX,
            minY: invertY ? -rangeY : minY,
            maxY: invertY ? minY : rangeY
        )
    );
}

//

Widget _buildChart(BuildContext context, String title, DateTimeChartData data, {bool invertY = false})
{
    final bool showLabelBottom = context.knobs.boolean(label: 'Show label bottom', initialValue: true);
    final bool showLabelLeft = context.knobs.boolean(label: 'Show label left', initialValue: true);
    final bool showLabelRight = context.knobs.boolean(label: 'Show label right');
    final bool showLabelTop = context.knobs.boolean(label: 'Show label top');

    final bool showTicksBottom = context.knobs.boolean(label: 'Show ticks bottom', initialValue: true);
    final bool showTicksLeft = context.knobs.boolean(label: 'Show ticks left', initialValue: true);
    final bool showTicksRight = context.knobs.boolean(label: 'Show ticks right');
    final bool showTicksTop = context.knobs.boolean(label: 'Show ticks top');

    final ChartInfo info = ChartInfo(
        title: title,
        labelBottom: showLabelBottom ? 'Bottom Label' : '',
        labelLeft: showLabelLeft ? 'Left Label' : '',
        labelRight: showLabelRight ? 'Right Label' : '',
        labelTop: showLabelTop ? 'Top Label' : ''
    );

    final ChartStyle style = ChartStyle(
        devicePixelRatio: 1,
        fontSize: 12,
        invertY: invertY,
        pointRadius: 4,
        showTicksBottom: showTicksBottom,
        showTicksLeft: showTicksLeft,
        showTicksRight: showTicksRight,
        showTicksTop: showTicksTop
    );

    return DateTimeLineChart(
        data: data, 
        info: info,
        style: style,
        onTap: _onTap
    );
}

void _onTap<TX, TY>(Offset location, TX dataX, TY dataY, ClosestLineInfo? closestLine)
{
    logDebug('Tapped at $location, dataX: $dataX, dataY: $dataY');
    logDebug('  closestLine: $closestLine');
}
