import 'GenericFormatter.dart';

class GenericTools<T>
{
    final GenericFormatter<T> formatter;

    const GenericTools(this.formatter);

    String format(T value)
    => throw UnimplementedError();

    double getNextDoubleValue(double currentValue)
    => throw UnimplementedError();

    T getNextValue(T currentValue)
    => throw UnimplementedError();

    T mid(T a, T b)
    => throw UnimplementedError();

    double toDouble(T value)
    => throw UnimplementedError();

    T toT(double value)
    => throw UnimplementedError();
}
