import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'PositionedTextPainter.freezed.dart';

/// A class that holds the position and painter information for text in a chart.
@freezed
abstract class PositionedTextPainter<T> with _$PositionedTextPainter<T>
{
    const PositionedTextPainter._();

    const factory PositionedTextPainter({
        required double linePosition,
        required double textPosition,
        required TextPainter? textPainter
    }) = _PositionedTextPainter<T>;

    double get textEndX
    => textPosition + textPainter!.width / 2;

    double get textEndY
    => textPosition + textPainter!.height / 2;

    double get textHeight
    => textPainter!.height;

    double get textStartX
    => textPosition - textPainter!.width / 2;

    double get textStartY
    => textPosition - textPainter!.height / 2;

    double get textWidth
    => textPainter!.width;

    @override
    String toString() 
    => 'PositionedTextPainter<$T>(linePosition: $linePosition, textPosition: $textPosition, textPainter: "${textPainter?.plainText}")';
}
