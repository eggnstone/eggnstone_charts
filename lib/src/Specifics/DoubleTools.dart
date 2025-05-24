import 'package:flutter/foundation.dart';

import '../Generics/GenericTools.dart';

class DoubleTools extends GenericTools<double>
{
    DoubleTools(super.formatter);

    @override
    String format(double value)
    => formatter.format(value);

    @override
    double mid(double a, double b)
    => (a + b) / 2;

    @override
    double getNextNiceValue(double currentValue)
    => currentValue.floorToDouble() + 1.0;

    @override
    double getNextNiceValueOrSame(double currentValue)
    {
        final double floorValue = currentValue.floorToDouble();
        if ((currentValue - floorValue).abs() < precisionErrorTolerance)
            return currentValue;

        return floorValue + 1.0;
    }

    @override
    double getPreviousNiceValue(double currentValue)
    => currentValue.ceilToDouble() - 1.0;

    @override
    double getPreviousNiceValueOrSame(double currentValue)
    {
        final double ceilValue = currentValue.ceilToDouble();
        if ((currentValue - ceilValue).abs() < precisionErrorTolerance)
            return currentValue;

        return ceilValue - 1.0;
    }

    @override
    double toDouble(double value)
    => value;

    @override
    double toT(double value)
    => value;
}
