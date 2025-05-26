import '../Generics/GenericMinMax.dart';

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
    => throw UnimplementedError('DateTimeMinMax.getWidth');

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
