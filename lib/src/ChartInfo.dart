import 'package:freezed_annotation/freezed_annotation.dart';

part 'ChartInfo.freezed.dart';

@freezed
abstract class ChartInfo with _$ChartInfo
{
    const factory ChartInfo({
        required String title,
        @Default('X: %x\nY: %y') String dataTipFormat,
        @Default('') String xAxisNameBottom,
        @Default('') String xAxisNameTop,
        @Default('') String yAxisNameLeft,
        @Default('') String yAxisNameRight
    }) = _ChartInfo;
}
