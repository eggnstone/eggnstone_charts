import 'GenericFormatter.dart';

class GenericTools<T>
{
    final GenericFormatter<T> formatter;

    const GenericTools(this.formatter);

    String format(T value)
    => throw UnimplementedError('GenericTools.format');

    double getNextDoubleValue(double currentValue)
    => throw UnimplementedError('GenericTools.getNextDoubleValue');

    T getNextNiceValue(T currentValue)
    => throw UnimplementedError('GenericTools.getNextNiceValue');

    T getNextNiceValueOrSame(T currentValue)
    => throw UnimplementedError('GenericTools.getNextNiceValueOrSame');

    T getPreviousNiceValue(T currentValue)
    => throw UnimplementedError('GenericTools.getPreviousNiceValue');

    T getPreviousNiceValueOrSame(T currentValue)
    => throw UnimplementedError('GenericTools.getPreviousNiceValueOrSame');

    T mid(T a, T b)
    => throw UnimplementedError('GenericTools.mid');

    double toDouble(T value)
    => throw UnimplementedError('GenericTools.toDouble');

    T toT(double value)
    => throw UnimplementedError('GenericTools.toT');
}
