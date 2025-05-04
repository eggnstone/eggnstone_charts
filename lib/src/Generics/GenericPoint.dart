import 'package:freezed_annotation/freezed_annotation.dart';

part 'GenericPoint.freezed.dart';

@freezed
class GenericPoint<TX, TY> with _$GenericPoint<TX, TY>
{
    @override
    final TX x;

    @override
    final TY y;

    const GenericPoint(
        this.x,
        this.y
    );
}
