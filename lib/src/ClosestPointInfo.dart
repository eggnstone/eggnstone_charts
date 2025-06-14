import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ClosestPointInfo.freezed.dart';

/// A class that holds information about the closest point on a chart.
@freezed
abstract class ClosestPointInfo with _$ClosestPointInfo
{
    const factory ClosestPointInfo({
        required double distance,
        required int? pointIndex,
        required Offset position
    }) = _ClosestPointInfo;
}
