import '../Generics/GenericFormatter.dart';

/// A formatter for double values that formats them to a specified precision.
class DoubleFormatter implements GenericFormatter<double>
{
    final int precision;

    const DoubleFormatter(this.precision);

    @override
    String format(dynamic value)
    {
        if (value is! double)
            return 'DoubleFormatter ?';

        final String s = value.toStringAsFixed(precision);

        if (s == '0' || s == '-0')
            return '0';

        return s;
    }
}
