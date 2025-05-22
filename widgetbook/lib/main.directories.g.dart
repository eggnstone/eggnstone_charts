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
import 'package:widgetbook_workspace/UseCases/DoubleTimeLineChart.dart' as _i3;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookComponent(
    name: 'GenericLineChart<DateTime, double, DateTimeChartData>',
    useCases: [
      _i1.WidgetbookUseCase(
        name: 'Inverted',
        builder: _i2.buildDateTimeChartInverted,
      ),
      _i1.WidgetbookUseCase(
        name: 'Normal',
        builder: _i2.buildDateTimeChart,
      ),
    ],
  ),
  _i1.WidgetbookComponent(
    name: 'GenericLineChart<double, double, DoubleChartData>',
    useCases: [
      _i1.WidgetbookUseCase(
        name: '2 lines, single and multiple entries',
        builder: _i3.buildDoubleTimeChartTwoLinesSingleAndMultipleEntries,
      ),
      _i1.WidgetbookUseCase(
        name: '2 lines, single entry each',
        builder: _i3.buildDoubleTimeChartTwoLinesOneEntryEach,
      ),
      _i1.WidgetbookUseCase(
        name: 'Mismatch of lines and colors',
        builder: _i3.buildDoubleTimeChartMismatchOfLinesAndColors,
      ),
      _i1.WidgetbookUseCase(
        name: 'No lines',
        builder: _i3.buildDoubleTimeChartNoLines,
      ),
    ],
  ),
];
