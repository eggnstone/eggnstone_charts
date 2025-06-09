import '../ChartsException.dart';
import '../Generics/GenericMinMax.dart';

/// A class that represents the minimum and maximum values for DateTime objects.
class DateTimeMinMax extends GenericMinMax<DateTime, double>
{
    DateTimeMinMax({
        required super.minX,
        required super.maxX,
        required super.minY,
        required super.maxY
    });

    @override
    double getHeight()
    => maxY - minY;

    @override
    DateTime getWidth()
    {
        if (minX.isUtc != maxX.isUtc) 
            throw ChartsException('minX and maxX must both be either UTC or non-UTC DateTime objects.');

        return DateTime.fromMillisecondsSinceEpoch(maxX.difference(minX).inMilliseconds, isUtc: minX.isUtc);
    }

    @override
    String toString()
    {
        final Duration diff = maxX.difference(minX);
        final String width = diff.inMicroseconds > Duration.microsecondsPerDay
            ? '${(diff.inMicroseconds / Duration.microsecondsPerDay).toStringAsFixed(2)} days'
            : diff.inMicroseconds > Duration.microsecondsPerHour
                ? '${(diff.inMicroseconds / Duration.microsecondsPerHour).toStringAsFixed(2)} hours'
                : '$diff';
        return 'X: [$minX, $maxX] = $width, Y: [$minY, $maxY] = ${getHeight()}';
    }
}
