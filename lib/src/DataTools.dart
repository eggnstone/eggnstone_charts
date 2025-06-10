import 'package:eggnstone_dart/eggnstone_dart.dart';

import 'ChartsException.dart';
import 'Generics/GenericMinMax.dart';
import 'Specifics/DoubleMinMax.dart';

/// A utility class for converting between data values and pixel values in a chart.
class DataTools
{
    static const bool DEBUG = false;

    final GenericMinMax<double, double> doubleDataMinMax;
    final DoubleMinMax graphMinMax;
    final bool invertXAxis;
    final bool invertYAxis;

    DataTools(this.doubleDataMinMax, this.graphMinMax, {required this.invertXAxis, required this.invertYAxis});

    double dataToPixelX(double doubleData, {bool useInvert = true})
    {
        if (doubleDataMinMax.getWidth() == 0)
            throw ChartsException('DataTools.dataToPixelX: doubleDataMinMax.getWidth() == 0');

        final double result = graphMinMax.minX + (doubleData - doubleDataMinMax.minX) / doubleDataMinMax.getWidth() * graphMinMax.getWidth();

        if (DEBUG)
        {
            logDebug('dataToPixelX:');
            logDebug('  graphMinMax:      [${graphMinMax.minX}, ${graphMinMax.maxX}] = ${graphMinMax.getWidth()}');
            logDebug('  doubleDataMinMax: [${doubleDataMinMax.minX}, ${doubleDataMinMax.maxX}] = ${doubleDataMinMax.getWidth()}');
            logDebug('  doubleData:       $doubleData');
            logDebug('  result:           $result');
        }

        if (useInvert && invertXAxis)
            return graphMinMax.minX + graphMinMax.maxX - result;

        return result;
    }

    double dataToPixelY(double doubleData, {bool useInvert = true})
    {
        if (doubleDataMinMax.getHeight() == 0)
            throw ChartsException('DataTools.dataToPixelY: doubleDataMinMax.getHeight() == 0');

        final double result = graphMinMax.maxY - (doubleData - doubleDataMinMax.minY) / doubleDataMinMax.getHeight() * graphMinMax.getHeight();

        if (DEBUG)
        {
            logDebug('dataToPixelY:');
            logDebug('  graphMinMax:      [${graphMinMax.minY}, ${graphMinMax.maxY}] = ${graphMinMax.getHeight()}');
            logDebug('  doubleDataMinMax: [${doubleDataMinMax.minY}, ${doubleDataMinMax.maxY}] = ${doubleDataMinMax.getHeight()}');
            logDebug('  doubleData:       $doubleData');
            logDebug('  result:           $result');
        }

        if (useInvert && invertYAxis)
            return graphMinMax.minY + graphMinMax.maxY - result;

        return result;
    }

    double pixelToDataX(double pixelX)
    {
        if (graphMinMax.getWidth() == 0)
            throw ChartsException('DataTools.pixelToDataX: graphMinMax.getWidth() == 0');

        final double actualPixelX = invertXAxis ? graphMinMax.minX + graphMinMax.maxX - pixelX : pixelX;
        final double result = doubleDataMinMax.minX + (actualPixelX - graphMinMax.minX) / graphMinMax.getWidth() * doubleDataMinMax.getWidth();

        if (DEBUG)
        {
            logDebug('pixelToDataX:');
            logDebug('  graphMinMax:      [${graphMinMax.minX}, ${graphMinMax.maxX}] = ${graphMinMax.getWidth()}');
            logDebug('  doubleDataMinMax: [${doubleDataMinMax.minX}, ${doubleDataMinMax.maxX}] = ${doubleDataMinMax.getWidth()}');
            logDebug('  pixelX:           $pixelX');
            logDebug('  actualPixelX:     $actualPixelX');
            logDebug('  result:           $result');
        }

        return result;
    }

    double pixelToDataY(double pixelY)
    {
        if (graphMinMax.getHeight() == 0)
            throw ChartsException('DataTools.pixelToDataY: graphMinMax.getHeight() == 0');

        final double actualPixelY = invertYAxis ? graphMinMax.minY + graphMinMax.maxY - pixelY : pixelY;
        final double result = doubleDataMinMax.minY + (graphMinMax.maxY - actualPixelY) / graphMinMax.getHeight() * doubleDataMinMax.getHeight();

        if (DEBUG)
        {
            logDebug('pixelToDataY:');
            logDebug('  graphMinMax:      [${graphMinMax.minY}, ${graphMinMax.maxY}] = ${graphMinMax.getHeight()}');
            logDebug('  doubleDataMinMax: [${doubleDataMinMax.minY}, ${doubleDataMinMax.maxY}] = ${doubleDataMinMax.getHeight()}');
            logDebug('  pixelY:           $pixelY');
            logDebug('  actualPixelY:     $actualPixelY');
            logDebug('  result:           $result');
        }

        return result;
    }
}
