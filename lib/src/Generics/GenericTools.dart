import 'GenericFormatter.dart';

/// An abstract class that defines generic tools for formatting and manipulating values of type T.
abstract class GenericTools<T>
{
    final GenericFormatter<T> formatter;
    final GenericFormatter<T> dataTipFormatter;

    const GenericTools(
        this.formatter,
        this.dataTipFormatter
    );

    String format(T value)
    => formatter.format(value);

    String formatDataTip(T value)
    => dataTipFormatter.format(value);

    double getNextDoubleValue(double value);
    T getNextNiceCustomValue(T value);
    T getNextNiceCustomValueOrSame(T value);
    T getPreviousNiceCustomValue(T value);
    T getPreviousNiceCustomValueOrSame(T value);
    T mid(T a, T b);
    T toCustomValue(double value);
    double toDoubleValue(T value);
}
