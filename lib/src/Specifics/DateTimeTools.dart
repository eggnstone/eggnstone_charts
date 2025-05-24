import '../Generics/GenericTools.dart';

class DateTimeTools extends GenericTools<DateTime>
{
    DateTimeTools(super.formatter);

    @override
    String format(DateTime value)
    => formatter.format(value);

    @override
    double getNextDoubleValue(double currentValue)
    => toDouble(getNextNiceValue(toT(currentValue)));

    @override
    DateTime getNextNiceValue(DateTime currentValue)
    => DateTime(currentValue.year, currentValue.month, currentValue.day).add(const Duration(days: 1));

    @override
    DateTime getNextNiceValueOrSame(DateTime currentValue)
    {
        if (currentValue.hour == 0 &&
            currentValue.minute == 0 &&
            currentValue.second == 0 &&
            currentValue.millisecond == 0 &&
            currentValue.microsecond == 0)
            return currentValue;

        return getNextNiceValue(currentValue);
    }

    @override
    DateTime getPreviousNiceValue(DateTime currentValue) 
    {
        if (currentValue.hour == 0 &&
            currentValue.minute == 0 &&
            currentValue.second == 0 &&
            currentValue.millisecond == 0 &&
            currentValue.microsecond == 0)
            return DateTime(currentValue.year, currentValue.month, currentValue.day).subtract(const Duration(days: 1));

        return DateTime(currentValue.year, currentValue.month, currentValue.day);
    }

    @override
    DateTime getPreviousNiceValueOrSame(DateTime currentValue)
    {
        if (currentValue.hour == 0 &&
            currentValue.minute == 0 &&
            currentValue.second == 0 &&
            currentValue.millisecond == 0 &&
            currentValue.microsecond == 0)
            return currentValue;

        return getPreviousNiceValue(currentValue);
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
