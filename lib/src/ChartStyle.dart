import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ChartStyle.freezed.dart';

@freezed
abstract class ChartStyle with _$ChartStyle
{
    const factory ChartStyle({
        required double devicePixelRatio,
        required double radius,
        required TextStyle textStyle
    }) = _ChartStyle;
}
