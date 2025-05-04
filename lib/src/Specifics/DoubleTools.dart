import '../Generics/GenericTools.dart';

class DoubleTools extends GenericTools<double>
{
    DoubleTools(super.formatter);

    @override
    String format(double value)
    => formatter.format(value);

    @override
    double mid(double a, double b)
    => (a + b) / 2;

    @override
    double getNextDoubleValue(double currentValue)
    => throw UnimplementedError();
}
