import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';

import 'GenericPoint.dart';

part 'GenericLineData.freezed.dart';

@freezed
class GenericLineData<TX, TY> with _$GenericLineData<TX, TY>
{
    @override
    final String label;

    @override
    final Color color;

    @override
    final KtList<GenericPoint<TX, TY>> points;

    const GenericLineData(
        this.color,
        this.label,
        this.points
    );
}
