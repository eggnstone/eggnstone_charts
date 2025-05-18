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
    name: 'GenericLineChart<dynamic, dynamic, dynamic>',
    useCases: [
      _i1.WidgetbookUseCase(
        name: 'DateTime',
        builder: _i2.buildDateTimeChart,
      ),
      _i1.WidgetbookUseCase(
        name: 'DateTime inverted',
        builder: _i2.buildDateTimeChartInverted,
      ),
      _i1.WidgetbookUseCase(
        name: 'Double',
        builder: _i3.buildDoubleTimeChart,
      ),
    ],
  )
];
