import 'package:freezed_annotation/freezed_annotation.dart';

part 'GenericMinMax.freezed.dart';

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
    => throw UnimplementedError();

    TY getHeight()
    => throw UnimplementedError();
}
