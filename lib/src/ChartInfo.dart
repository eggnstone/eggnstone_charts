import 'package:freezed_annotation/freezed_annotation.dart';

part 'ChartInfo.freezed.dart';

/// A class that holds information about a chart, including data tip format and labels for the axes and title.
@freezed
abstract class ChartInfo with _$ChartInfo
{
    const factory ChartInfo({
        @Default('%s\nX: %x\nY: %y') String dataTipFormat,
        @Default('') String labelBottom,
        @Default('') String labelLeft,
        @Default('') String labelRight,
        @Default('') String labelTop,
        @Default('') String title
    }) = _ChartInfo;
}
