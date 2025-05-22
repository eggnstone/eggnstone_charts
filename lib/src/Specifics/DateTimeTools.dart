import '../Generics/GenericTools.dart';

class DateTimeTools extends GenericTools<DateTime>
{
    DateTimeTools(super.formatter);

    @override
    String format(DateTime value)
    => formatter.format(value);

    @override
    double getNextDoubleValue(double currentValue)
    => toDouble(getNextValue(toT(currentValue)));

    @override
    DateTime getNextValue(DateTime currentValue)
    => DateTime(currentValue.year, currentValue.month, currentValue.day).add(const Duration(days: 1));

    @override
    DateTime getNextValueOrSame(DateTime currentValue)
    {
        if (currentValue.hour == 0 &&
            currentValue.minute == 0 &&
            currentValue.second == 0 &&
            currentValue.millisecond == 0)
            return currentValue;

        return getNextValue(currentValue);
    }

    @override
    DateTime getPreviousValue(DateTime currentValue)
    => DateTime(currentValue.year, currentValue.month, currentValue.day).subtract(const Duration(days: 1));

    @override
    DateTime getPreviousValueOrSame(DateTime currentValue)
    {
        if (currentValue.hour == 0 &&
            currentValue.minute == 0 &&
            currentValue.second == 0 &&
            currentValue.millisecond == 0)
            return currentValue;

        return getPreviousValue(currentValue);
    }

    @override
    DateTime mid(DateTime a, DateTime b)
    {
        final Duration diff = b.difference(a);
        final Duration half = diff ~/ 2;
        return a.add(half);
    }

    @override
    double toDouble(DateTime value)
    => value.millisecondsSinceEpoch.toDouble();

    @override
    DateTime toT(double value)
    => DateTime.fromMillisecondsSinceEpoch(value.toInt());
}
