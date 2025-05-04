// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'GenericPoint.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GenericPoint<TX,TY> {

 TX get x; TY get y;
/// Create a copy of GenericPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GenericPointCopyWith<TX, TY, GenericPoint<TX, TY>> get copyWith => _$GenericPointCopyWithImpl<TX, TY, GenericPoint<TX, TY>>(this as GenericPoint<TX, TY>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GenericPoint<TX, TY>&&const DeepCollectionEquality().equals(other.x, x)&&const DeepCollectionEquality().equals(other.y, y));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(x),const DeepCollectionEquality().hash(y));

@override
String toString() {
  return 'GenericPoint<$TX, $TY>(x: $x, y: $y)';
}


}

/// @nodoc
abstract mixin class $GenericPointCopyWith<TX,TY,$Res>  {
  factory $GenericPointCopyWith(GenericPoint<TX, TY> value, $Res Function(GenericPoint<TX, TY>) _then) = _$GenericPointCopyWithImpl;
@useResult
$Res call({
 TX x, TY y
});




}
/// @nodoc
class _$GenericPointCopyWithImpl<TX,TY,$Res>
    implements $GenericPointCopyWith<TX, TY, $Res> {
  _$GenericPointCopyWithImpl(this._self, this._then);

  final GenericPoint<TX, TY> _self;
  final $Res Function(GenericPoint<TX, TY>) _then;

/// Create a copy of GenericPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? x = freezed,Object? y = freezed,}) {
  return _then(GenericPoint(
freezed == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as TX,freezed == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as TY,
  ));
}

}


// dart format on
