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
          builder: _i2.buildDateTimeChartForOnlyOneDate,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'GenericLineChart<double, double, DoubleChartData>',
        useCase: _i1.WidgetbookUseCase(
          name: 'No data',
          builder: _i3.buildDoubleChartForNoData,
        ),
      ),
    ],
  ),
  _i1.WidgetbookComponent(
    name: 'GenericLineChart<DateTime, double, DateTimeChartData>',
    useCases: [
      _i1.WidgetbookUseCase(
        name: '1 line',
        builder: _i2.buildDateTimeChartForOneLineStartingAt0,
      ),
      _i1.WidgetbookUseCase(
        name: '1 line @ 1',
        builder: _i2.buildDateTimeChartForOneLineStartingAt1,
      ),
      _i1.WidgetbookUseCase(
        name: 'Doc 1',
        builder: _i2.buildDateTimeChartForDocOne,
      ),
      _i1.WidgetbookUseCase(
        name: 'One date only (fixed)',
        builder: _i2.buildDateTimeChartForOnlyOneDateFixed,
      ),
      _i1.WidgetbookUseCase(
        name: 'Two dates only',
        builder: _i2.buildDateTimeChartForOnlyTwoDates,
      ),
    ],
  ),
  _i1.WidgetbookComponent(
    name: 'GenericLineChart<double, double, DoubleChartData>',
    useCases: [
      _i1.WidgetbookUseCase(
        name: '1 dot',
        builder: _i3.buildDoubleChartForOneDot,
      ),
      _i1.WidgetbookUseCase(
        name: '1 line',
        builder: _i3.buildDoubleChartForOneLineStartingAt0,
      ),
      _i1.WidgetbookUseCase(
        name: '1 line @ 1',
        builder: _i3.buildDoubleChartForOneLineStartingAt1,
      ),
      _i1.WidgetbookUseCase(
        name: '1 line, 1 dot',
        builder: _i3.buildDoubleChartForOneLineOneDot,
      ),
      _i1.WidgetbookUseCase(
        name: '2 dots',
        builder: _i3.buildDoubleChartForTwoDots,
      ),
      _i1.WidgetbookUseCase(
        name: '2 lines',
        builder: _i3.buildDoubleChartForTwoLines,
      ),
      _i1.WidgetbookUseCase(
        name: '2 lines, 2 dots',
        builder: _i3.buildDoubleChartForTwoLinesTwoDots,
      ),
      _i1.WidgetbookUseCase(
        name: 'Doc 1',
        builder: _i3.buildDoubleChartForDocOne,
      ),
    ],
  ),
];
