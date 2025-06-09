import 'package:freezed_annotation/freezed_annotation.dart';

part 'GenericMinMax.freezed.dart';

/// A generic class that holds minimum and maximum values for two types, TX and TY.
@freezed
class GenericMinMax<TX, TY> with _$GenericMinMax<TX, TY>
{
    @override
    final TX minX;

    @override
    final TX maxX;

    @override
    final TY minY;

    @override
    final TY maxY;

    const GenericMinMax({
        required this.minX,
        required this.maxX,
        required this.minY,
        required this.maxY
    });

    TX getWidth()
    => throw UnimplementedError('GenericMinMax.getWidth');

    TY getHeight()
    => throw UnimplementedError('GenericMinMax.getHeight');

    @override
    String toString()
    => 'X: [$minX, $maxX] = ${getWidth()}, Y: [$minY, $maxY] = ${getHeight()}';
}
