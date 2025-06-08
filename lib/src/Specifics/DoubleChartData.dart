import '../Generics/GenericChartData.dart';

/// DoubleChartData class that holds data for a chart with double types for X and Y axes.
class DoubleChartData extends GenericChartData<double, double>
{
    DoubleChartData({
        required super.dataSeriesList,
        required super.toolsX,
        required super.toolsY,
        required super.minMax
    });

    @override
    DoubleChartData createDoubleChartData()
    => this;
}
