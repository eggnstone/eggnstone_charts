import 'package:freezed_annotation/freezed_annotation.dart';

import 'ClosestPointInfo.dart';

part 'ClosestLineInfo.freezed.dart';

/// A class that holds information about the closest point on a line and its index.
@freezed
abstract class ClosestLineInfo with _$ClosestLineInfo
{
    const factory ClosestLineInfo({
        required ClosestPointInfo closestPoint,
        required int lineIndex
    }) = _ClosestLineInfo;
}
