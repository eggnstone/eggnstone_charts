import '../Generics/GenericFormatter.dart';

class DoubleFormatter implements GenericFormatter<double>
{
    final bool invert;
    final int precision;

    const DoubleFormatter(this.precision, {this.invert = false});

    @override
    String format(dynamic value)
    {
        if (value is! double)
            return 'DoubleFormatter ?';

        final String s = value.toStringAsFixed(precision);

        if (s == '0' || s == '-0')
            return '0';

        if (!invert)
            return s;

        if (s.startsWith('-'))
            return s.substring(1);

        return '-$s';
    }
}
