import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'PositionedTextPainter.freezed.dart';

@freezed
abstract class PositionedTextPainter with _$PositionedTextPainter
{
    const factory PositionedTextPainter(
        double position,
        TextPainter textPainter
    ) = _PositionedTextPainter;
}
