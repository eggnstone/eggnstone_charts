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
import 'package:widgetbook_workspace/UseCases/DateTimeLineChart.dart' as _i3;
import 'package:widgetbook_workspace/UseCases/DoubleLineChart.dart' as _i2;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookFolder(
    name: 'Errors',
    children: [
      _i1.WidgetbookComponent(
        name: 'GenericLineChart<double, double, DoubleChartData>',
        useCases: [
          _i1.WidgetbookUseCase(
            name: 'Mismatch of lines and colors',
            builder: _i2.buildDoubleChartMismatchOfLinesAndColors,
          ),
          _i1.WidgetbookUseCase(
            name: 'No data',
            builder: _i2.buildDoubleChartNoData,
          ),
        ],
      )
    ],
  ),
  _i1.WidgetbookComponent(
    name: 'GenericLineChart<DateTime, double, DateTimeChartData>',
    useCases: [
      _i1.WidgetbookUseCase(
        name: 'Inverted',
        builder: _i3.buildDateTimeChartInverted,
      ),
      _i1.WidgetbookUseCase(
        name: 'Normal',
        builder: _i3.buildDateTimeChart,
      ),
    ],
  ),
  _i1.WidgetbookComponent(
    name: 'GenericLineChart<double, double, DoubleChartData>',
    useCases: [
      _i1.WidgetbookUseCase(
        name: '1 dot',
        builder: _i2.buildDoubleChartOneDot,
      ),
      _i1.WidgetbookUseCase(
        name: '1 line',
        builder: _i2.buildDoubleChartOneLine,
      ),
      _i1.WidgetbookUseCase(
        name: '1 line, 1 dot',
        builder: _i2.buildDoubleChartOneLineOneDot,
      ),
      _i1.WidgetbookUseCase(
        name: '1 line, inverted',
        builder: _i2.buildDoubleChartOneLineInverted,
      ),
      _i1.WidgetbookUseCase(
        name: '2 dots',
        builder: _i2.buildDoubleChartTwoDots,
      ),
      _i1.WidgetbookUseCase(
        name: '2 lines',
        builder: _i2.buildDoubleChartTwoLines,
      ),
      _i1.WidgetbookUseCase(
        name: '2 lines, 2 dots',
        builder: _i2.buildDoubleChartTwoLinesTwoDots,
      ),
    ],
  ),
];
