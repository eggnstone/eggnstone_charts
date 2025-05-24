import '../Generics/GenericTools.dart';

class DateTimeTools extends GenericTools<DateTime>
{
    DateTimeTools(super.formatter);

    @override
    String format(DateTime value)
    => formatter.format(value);

    @override
    double getNextDoubleValue(double value)
    => toDoubleValue(getNextNiceCustomValue(toCustomValue(value)));

    @override
    DateTime getNextNiceCustomValue(DateTime value)
    => DateTime(value.year, value.month, value.day).add(const Duration(days: 1));

    @override
    DateTime getNextNiceCustomValueOrSame(DateTime value)
    {
        if (value.hour == 0 &&
            value.minute == 0 &&
            value.second == 0 &&
            value.millisecond == 0 &&
            value.microsecond == 0)
            return value;

        return getNextNiceCustomValue(value);
    }

    @override
    DateTime getPreviousNiceCustomValue(DateTime value)
    {
        if (value.hour == 0 &&
            value.minute == 0 &&
            value.second == 0 &&
            value.millisecond == 0 &&
            value.microsecond == 0)
            return value.subtract(const Duration(days: 1));

        return DateTime(value.year, value.month, value.day);
    }

    @override
    DateTime getPreviousNiceCustomValueOrSame(DateTime value)
    {
        if (value.hour == 0 &&
            value.minute == 0 &&
            value.second == 0 &&
            value.millisecond == 0 &&
            value.microsecond == 0)
            return value;

        return DateTime(value.year, value.month, value.day);
    }

    @override
    DateTime mid(DateTime a, DateTime b)
    {
        final Duration diff = b.difference(a);
        final Duration half = diff ~/ 2;
        return a.add(half);
    }

    @override
    DateTime toCustomValue(double value)
    => DateTime.fromMillisecondsSinceEpoch(value.toInt());

    @override
    double toDoubleValue(DateTime value)
    => value.millisecondsSinceEpoch.toDouble();
}
