import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'PositionedTextPainter.freezed.dart';

@freezed
abstract class PositionedTextPainter<T> with _$PositionedTextPainter<T>
{
    const PositionedTextPainter._();

    const factory PositionedTextPainter({
        required double position,
        /*required double textPosition,
        required double textStart,
        required double textEnd,*/
        required TextPainter? textPainter
    }) = _PositionedTextPainter<T>;

    double get textEnd
    => position + textPainter!.width / 2;

    double get textStart
    => position - textPainter!.width / 2;
}
