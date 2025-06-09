import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';

import 'GenericPoint.dart';

part 'GenericDataSeries.freezed.dart';

/// A generic data series class that holds a list of points with a specific type for X and Y values.
@freezed
class GenericDataSeries<TX, TY> with _$GenericDataSeries<TX, TY>
{
    @override
    final Color color;

    @override
    final String label;

    @override
    final KtList<GenericPoint<TX, TY>> points;

    const GenericDataSeries(
        this.color,
        this.label,
        this.points
    );
}
