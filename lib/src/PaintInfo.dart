import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'Specifics/DoubleMinMax.dart';

part 'PaintInfo.freezed.dart';

@freezed
abstract class PaintInfo with _$PaintInfo
{
    const factory PaintInfo({
        required Canvas canvas,
        required Size size,
        required DoubleMinMax graphMinMax,
        required Paint borderPaint,
        required Paint gridPaint,
        required Paint gridPaint2
    }) = _PaintInfo;
}
