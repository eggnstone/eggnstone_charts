import 'package:freezed_annotation/freezed_annotation.dart';

part 'ChartInfo.freezed.dart';

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
