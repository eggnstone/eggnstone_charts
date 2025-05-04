import '../Generics/GenericMinMax.dart';

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
