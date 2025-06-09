import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ChartStyle.freezed.dart';

/// A class that defines the style properties for charts.
@freezed
abstract class ChartStyle with _$ChartStyle
{
    const factory ChartStyle({
        required double devicePixelRatio,
        required double fontSize,
        required double pointRadius,
        @Default(Colors.black) Color borderColor,
        @Default(Colors.white) Color borderColorDark,
        @Default(Colors.white) Color dataTipBackgroundColor,
        @Default(Colors.black) Color dataTipBackgroundColorDark,
        @Default(Colors.grey) Color gridColor,
        @Default(Colors.grey) Color gridColorDark,
        @Default(false) bool invertX,
        @Default(false) bool invertY,
        @Default(2) double lineWidth,
        @Default(false) bool showTicksBottom,
        @Default(false) bool showTicksLeft,
        @Default(false) bool showTicksRight,
        @Default(false) bool showTicksTop,
        @Default(Colors.black) Color textColor,
        @Default(Colors.white) Color textColorDark
    }) = _ChartStyle;
}
