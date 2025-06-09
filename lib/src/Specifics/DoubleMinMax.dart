import '../Generics/GenericMinMax.dart';

/// A class that represents the minimum and maximum values for double values.
class DoubleMinMax extends GenericMinMax<double, double>
{
    DoubleMinMax({
        required super.minX,
        required super.maxX,
        required super.minY,
        required super.maxY
    });

    @override
    double getWidth()
    => maxX - minX;

    @override
    double getHeight()
    => maxY - minY;
}
