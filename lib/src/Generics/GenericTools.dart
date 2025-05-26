import 'GenericFormatter.dart';

abstract class GenericTools<T>
{
    final GenericFormatter<T> formatter;

    const GenericTools(this.formatter);

    String format(T value);

    double getNextDoubleValue(double value);

    T getNextNiceCustomValue(T value);

    T getNextNiceCustomValueOrSame(T value);

    T getPreviousNiceCustomValue(T value);

    T getPreviousNiceCustomValueOrSame(T value);

    T mid(T a, T b);

    T toCustomValue(double value);

    double toDoubleValue(T value);
}
