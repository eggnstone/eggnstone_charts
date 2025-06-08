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
        required super.dataSeriesList,
        required super.toolsX,
        required super.toolsY,
        required super.minMax
    });

    @override
    DoubleChartData createDoubleChartData()
    {
        final List<DoubleDataSeries> doubleDataSeriesList = <DoubleDataSeries>[];

        /*double minX = double.infinity;
        double maxX = double.negativeInfinity;*/

        if (DEBUG)
            logDebug('dataSeriesList.size: ${dataSeriesList.size}');

        for (int i = 0; i < dataSeriesList.size; i++)
        {
            final DateTimeDataSeries dateTimeDataSeries = dataSeriesList[i];
            final List<DoublePoint> doublePoints = <DoublePoint>[];

            if (DEBUG)
                logDebug('dateTimeDataSeries.points.size: ${dateTimeDataSeries.points.size}');

            for (int j = 0; j < dateTimeDataSeries.points.size; j++)
            {
                final DateTimePoint dateTimePoint = dateTimeDataSeries.points[j];
                doublePoints.add(DoublePoint(dateTimePoint.x.millisecondsSinceEpoch.toDouble(), dateTimePoint.y));
                /*minX = dateTimePoint.x.millisecondsSinceEpoch < minX ? dateTimePoint.x.millisecondsSinceEpoch.toDouble() : minX;
                maxX = dateTimePoint.x.millisecondsSinceEpoch > maxX ? dateTimePoint.x.millisecondsSinceEpoch.toDouble() : maxX;*/
            }

            doubleDataSeriesList.add(DoubleDataSeries(dateTimeDataSeries.color, dateTimeDataSeries.label, doublePoints.toImmutableList()));
        }

        final GenericMinMax<double, double> doubleMinxMax = DoubleMinMax(
            minX: minMax.minX.millisecondsSinceEpoch.toDouble(),
            maxX: minMax.maxX.millisecondsSinceEpoch.toDouble(),
            minY: minMax.minY,
            maxY: minMax.maxY
        );

        return DoubleChartData(
            dataSeriesList: doubleDataSeriesList.toImmutableList(),
            toolsX: DoubleTools(const DoubleFormatter(0), const DoubleFormatter(0)),
            toolsY: DoubleTools(const DoubleFormatter(0), const DoubleFormatter(0)),
            minMax: doubleMinxMax
        );
    }
}
