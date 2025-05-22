import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';

import '../Specifics/DoubleChartData.dart';
import 'GenericLineData.dart';
import 'GenericMinMax.dart';
import 'GenericTools.dart';

part 'GenericChartData.freezed.dart';

@freezed
class GenericChartData<TX, TY> with _$GenericChartData<TX, TY>
{
    @override
    final KtList<Color> colors;

    @override
    final KtList<GenericLineData<TX, TY>> lines;

    @override
    final GenericTools<TX> toolsX;

    @override
    final GenericTools<TY> toolsY;

    @override
    final GenericMinMax<TX, TY> minMax;

    const GenericChartData({
        required this.colors,
        required this.lines,
        required this.toolsX,
        required this.toolsY,
        required this.minMax
    });

    DoubleChartData getDoubleChartData()
    => throw UnimplementedError('GenericChartData.getDoubleChartData');
}
