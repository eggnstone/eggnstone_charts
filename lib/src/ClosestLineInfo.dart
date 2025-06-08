import 'package:freezed_annotation/freezed_annotation.dart';

import 'ClosestPointInfo.dart';

part 'ClosestLineInfo.freezed.dart';

/// ClosestLineInfo class that holds information about the closest line to a point in a chart.
@freezed
abstract class ClosestLineInfo with _$ClosestLineInfo
{
    const factory ClosestLineInfo({
        required ClosestPointInfo closestPoint,
        required int lineIndex
    }) = _ClosestLineInfo;
}
