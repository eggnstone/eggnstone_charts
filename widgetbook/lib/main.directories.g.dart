// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:widgetbook/widgetbook.dart' as _i1;
import 'package:widgetbook_workspace/UseCases/DateTimeLineChart.dart' as _i2;
import 'package:widgetbook_workspace/UseCases/DoubleLineChart.dart' as _i3;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookFolder(
    name: 'Errors',
    children: [
      _i1.WidgetbookLeafComponent(
        name: 'GenericLineChart<DateTime, double, DateTimeChartData>',
        useCase: _i1.WidgetbookUseCase(
          name: 'One date only',
          builder: _i2.buildDateTimeChartOnlyOneDate,
        ),
      ),
      _i1.WidgetbookComponent(
        name: 'GenericLineChart<double, double, DoubleChartData>',
        useCases: [
          _i1.WidgetbookUseCase(
            name: 'Mismatch of lines and colors',
            builder: _i3.buildDoubleChartMismatchOfLinesAndColors,
          ),
          _i1.WidgetbookUseCase(
            name: 'No data',
            builder: _i3.buildDoubleChartNoData,
          ),
        ],
      ),
    ],
  ),
  _i1.WidgetbookComponent(
    name: 'GenericLineChart<DateTime, double, DateTimeChartData>',
    useCases: [
      _i1.WidgetbookUseCase(
        name: 'Doc 1',
        builder: _i2.buildDateTimeChartDocOne,
      ),
      _i1.WidgetbookUseCase(
        name: 'Inverted',
        builder: _i2.buildDateTimeChartInverted,
      ),
      _i1.WidgetbookUseCase(
        name: 'Normal',
        builder: _i2.buildDateTimeChartNormal,
      ),
      _i1.WidgetbookUseCase(
        name: 'One date only (fixed)',
        builder: _i2.buildDateTimeChartOnlyOneDateFixed,
      ),
      _i1.WidgetbookUseCase(
        name: 'Two dates only',
        builder: _i2.buildDateTimeChartOnlyTwoDates,
      ),
    ],
  ),
  _i1.WidgetbookComponent(
    name: 'GenericLineChart<double, double, DoubleChartData>',
    useCases: [
      _i1.WidgetbookUseCase(
        name: '1 dot',
        builder: _i3.buildDoubleChartOneDot,
      ),
      _i1.WidgetbookUseCase(
        name: '1 line',
        builder: _i3.buildDoubleChartOneLine,
      ),
      _i1.WidgetbookUseCase(
        name: '1 line, 1 dot',
        builder: _i3.buildDoubleChartOneLineOneDot,
      ),
      _i1.WidgetbookUseCase(
        name: '1 line, inverted',
        builder: _i3.buildDoubleChartOneLineInverted,
      ),
      _i1.WidgetbookUseCase(
        name: '2 dots',
        builder: _i3.buildDoubleChartTwoDots,
      ),
      _i1.WidgetbookUseCase(
        name: '2 lines',
        builder: _i3.buildDoubleChartTwoLines,
      ),
      _i1.WidgetbookUseCase(
        name: '2 lines, 2 dots',
        builder: _i3.buildDoubleChartTwoLinesTwoDots,
      ),
      _i1.WidgetbookUseCase(
        name: 'Doc 1',
        builder: _i3.buildDoubleChartDocOne,
      ),
    ],
  ),
];
