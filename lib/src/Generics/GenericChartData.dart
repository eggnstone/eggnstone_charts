import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';

import '../Specifics/DoubleChartData.dart';
import 'GenericDataSeries.dart';
import 'GenericMinMax.dart';
import 'GenericTools.dart';

part 'GenericChartData.freezed.dart';

@freezed
class GenericChartData<TX, TY> with _$GenericChartData<TX, TY>
{
    @override
    final KtList<GenericDataSeries<TX, TY>> dataSeriesList;

    @override
    final GenericTools<TX> toolsX;

    @override
    final GenericTools<TY> toolsY;

    @override
    final GenericMinMax<TX, TY> minMax;

    const GenericChartData({
        required this.dataSeriesList,
        required this.toolsX,
        required this.toolsY,
        required this.minMax
    });

    DoubleChartData createDoubleChartData()
    => throw UnimplementedError('GenericChartData.createDoubleChartData');
}
