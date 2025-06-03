import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'PositionedTextPainter.freezed.dart';

@freezed
abstract class PositionedTextPainter<T> with _$PositionedTextPainter<T>
{
    const PositionedTextPainter._();

    const factory PositionedTextPainter({
        required double linePosition,
        required double textPosition,
        required TextPainter? textPainter
    }) = _PositionedTextPainter<T>;

    double get textEnd
    => textPosition + textPainter!.width / 2;

    double get textStart
    => textPosition - textPainter!.width / 2;
}
