import '../Generics/GenericFormatter.dart';

class DoubleFormatter implements GenericFormatter<double>
{
    final bool invert;
    final int precision;

    const DoubleFormatter(this.precision, {this.invert = false});

    @override
    String format(dynamic value)
    {
        if (value is double)
            return invert ? (-value).toStringAsFixed(precision) : value.toStringAsFixed(precision);

        return 'DoubleFormatter ?';
    }
}
