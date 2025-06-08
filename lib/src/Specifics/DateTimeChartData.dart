import 'package:eggnstone_dart/eggnstone_dart.dart';
import 'package:kt_dart/collection.dart';

import '../Generics/GenericChartData.dart';
import '../Generics/GenericMinMax.dart';
import 'DateTimeDataSeries.dart';
import 'DateTimePoint.dart';
import 'DoubleChartData.dart';
import 'DoubleDataSeries.dart';
import 'DoubleFormatter.dart';
import 'DoubleMinMax.dart';
import 'DoublePoint.dart';
import 'DoubleTools.dart';

class DateTimeChartData extends GenericChartData<DateTime, double>
{
    static const bool DEBUG = false;

    DateTimeChartData({
        required super.lines,
        required super.toolsX,
        required super.toolsY,
        required super.minMax
    });

    @override
    DoubleChartData createDoubleChartData()
    {
        final List<DoubleDataSeries> doubleLines = <DoubleDataSeries>[];

        /*double minX = double.infinity;
        double maxX = double.negativeInfinity;*/

        if (DEBUG)
            logDebug('lines.size: ${lines.size}');

        for (int i = 0; i < lines.size; i++)
        {
            final DateTimeDataSeries dateTimeLine = lines[i];
            final List<DoublePoint> doublePoints = <DoublePoint>[];

            if (DEBUG)
                logDebug('dateTimeLine.points.size: ${dateTimeLine.points.size}');

            for (int j = 0; j < dateTimeLine.points.size; j++)
            {
                final DateTimePoint dateTimePoint = dateTimeLine.points[j];
                doublePoints.add(DoublePoint(dateTimePoint.x.millisecondsSinceEpoch.toDouble(), dateTimePoint.y));
                /*minX = dateTimePoint.x.millisecondsSinceEpoch < minX ? dateTimePoint.x.millisecondsSinceEpoch.toDouble() : minX;
                maxX = dateTimePoint.x.millisecondsSinceEpoch > maxX ? dateTimePoint.x.millisecondsSinceEpoch.toDouble() : maxX;*/
            }

            doubleLines.add(DoubleDataSeries(dateTimeLine.color, dateTimeLine.label, doublePoints.toImmutableList()));
        }

        final GenericMinMax<double, double> doubleMinxMax = DoubleMinMax(
            minX: minMax.minX.millisecondsSinceEpoch.toDouble(),
            maxX: minMax.maxX.millisecondsSinceEpoch.toDouble(),
            minY: minMax.minY,
            maxY: minMax.maxY
        );

        return DoubleChartData(
            lines: doubleLines.toImmutableList(),
            toolsX: DoubleTools(const DoubleFormatter(0), const DoubleFormatter(0)),
            toolsY: DoubleTools(const DoubleFormatter(0), const DoubleFormatter(0)),
            minMax: doubleMinxMax
        );
    }
}
