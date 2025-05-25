import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ChartStyle.freezed.dart';

@freezed
abstract class ChartStyle with _$ChartStyle
{
    const factory ChartStyle({
        required double devicePixelRatio,
        required double fontSize,
        required double pointRadius,
        double? lineWidth, /// Default is 2.0
        Color? borderColor,
        Color? gridColor,
        Color? textColor
    }) = _ChartStyle;
}
