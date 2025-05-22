import 'GenericFormatter.dart';

class GenericTools<T>
{
    final GenericFormatter<T> formatter;

    const GenericTools(this.formatter);

    String format(T value)
    => throw UnimplementedError('GenericTools.format');

    double getNextDoubleValue(double currentValue)
    => throw UnimplementedError('GenericTools.getNextDoubleValue');

    T getNextValue(T currentValue)
    => throw UnimplementedError('GenericTools.getNextValue');

    T getNextValueOrSame(T currentValue)
    => throw UnimplementedError('GenericTools.getNextValueOrSame');

    T getPreviousValue(T currentValue)
    => throw UnimplementedError('GenericTools.getPreviousValue');

    T getPreviousValueOrSame(T currentValue)
    => throw UnimplementedError('GenericTools.getPreviousValueOrSame');

    T mid(T a, T b)
    => throw UnimplementedError('GenericTools.mid');

    double toDouble(T value)
    => throw UnimplementedError('GenericTools.toDouble');

    T toT(double value)
    => throw UnimplementedError('GenericTools.toT');
}
