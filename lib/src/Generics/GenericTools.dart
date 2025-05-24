import 'GenericFormatter.dart';

class GenericTools<T>
{
    final GenericFormatter<T> formatter;

    const GenericTools(this.formatter);

    String format(T value)
    => throw UnimplementedError('GenericTools.format');

    double getNextDoubleValue(double value)
    => throw UnimplementedError('GenericTools.getNextDoubleValue');

    T getNextNiceCustomValue(T value)
    => throw UnimplementedError('GenericTools.getNextNiceCustomValue');

    T getNextNiceCustomValueOrSame(T value)
    => throw UnimplementedError('GenericTools.getNextNiceCustomValueOrSame');

    T getPreviousNiceCustomValue(T value)
    => throw UnimplementedError('GenericTools.getPreviousNiceCustomValue');

    T getPreviousNiceCustomValueOrSame(T value)
    => throw UnimplementedError('GenericTools.getPreviousNiceCustomValueOrSame');

    T mid(T a, T b)
    => throw UnimplementedError('GenericTools.mid');

    T toCustomValue(double value)
    => throw UnimplementedError('GenericTools.toCustomValue');

    double toDoubleValue(T value)
    => throw UnimplementedError('GenericTools.toDoubleValue');
}
