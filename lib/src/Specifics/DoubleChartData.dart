import '../Generics/GenericChartData.dart';

class DoubleChartData extends GenericChartData<double, double>
{
    DoubleChartData({
        required super.lines,
        required super.toolsX,
        required super.toolsY,
        required super.minMax
    });

    @override
    DoubleChartData createDoubleChartData()
    => this;
}
