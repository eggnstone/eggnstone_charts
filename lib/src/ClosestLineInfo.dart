import 'package:freezed_annotation/freezed_annotation.dart';

import 'ClosestPointInfo.dart';

part 'ClosestLineInfo.freezed.dart';

@freezed
abstract class ClosestLineInfo with _$ClosestLineInfo
{
    const factory ClosestLineInfo({
        required ClosestPointInfo closestPoint,
        required int lineIndex
    }) = _ClosestLineInfo;
}
