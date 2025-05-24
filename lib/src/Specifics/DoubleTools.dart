import 'package:flutter/foundation.dart';

import '../Generics/GenericTools.dart';

class DoubleTools extends GenericTools<double>
{
    DoubleTools(super.formatter);

    @override
    String format(double value)
    => formatter.format(value);

    @override
    double getNextDoubleValue(double value)
    => getNextNiceCustomValue(value);

    @override
    double getNextNiceCustomValue(double value)
    => value.floorToDouble() + 1.0;

    @override
    double getNextNiceCustomValueOrSame(double value)
    {
        final double floorValue = value.floorToDouble();
        if ((value - floorValue).abs() < precisionErrorTolerance)
            return value;

        return floorValue + 1.0;
    }

    @override
    double getPreviousNiceCustomValue(double value)
    => value.ceilToDouble() - 1.0;

    @override
    double getPreviousNiceCustomValueOrSame(double value)
    {
        final double ceilValue = value.ceilToDouble();
        if ((value - ceilValue).abs() < precisionErrorTolerance)
            return value;

        return ceilValue - 1.0;
    }

    @override
    double mid(double a, double b)
    => (a + b) / 2;

    @override
    double toCustomValue(double value)
    => value;

    @override
    double toDoubleValue(double value)
    => value;
}
