import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'PositionedTextPainter.freezed.dart';

@freezed
abstract class PositionedTextPainter<T> with _$PositionedTextPainter<T>
{
    const factory PositionedTextPainter({
        required double textPosition,
        required double textStart,
        required double textEnd,
        required TextPainter textPainter
    }) = _PositionedTextPainter<T>;
}
