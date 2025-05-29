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
        @Default(2) double lineWidth,
        @Default(Colors.white) Color backgroundColor,
        @Default(Colors.black) Color backgroundColorDark,
        @Default(Colors.black) Color borderColor,
        @Default(Colors.white) Color borderColorDark,
        @Default(Colors.grey) Color gridColor,
        @Default(Colors.grey) Color gridColorDark,
        @Default(Colors.black) Color textColor,
        @Default(Colors.white) Color textColorDark
    }) = _ChartStyle;
}
