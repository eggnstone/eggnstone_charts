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
    double getNextValue(double currentValue)
    => currentValue.floorToDouble() + 1.0;

    @override
    double getNextValueOrSame(double currentValue)
    {
        final double floorValue = currentValue.floorToDouble();
        if ((currentValue - floorValue).abs() < precisionErrorTolerance)
            return currentValue;

        return floorValue + 1.0;
    }

    @override
    double getPreviousValue(double currentValue)
    => currentValue.ceilToDouble() - 1.0;

    @override
    double getPreviousValueOrSame(double currentValue)
    {
        final double ceilValue = currentValue.ceilToDouble();
        if ((currentValue - ceilValue).abs() < precisionErrorTolerance)
            return currentValue;

        return ceilValue - 1.0;
    }

    @override
    double toDouble(double value)
    => value;
}
