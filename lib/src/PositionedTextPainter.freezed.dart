// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'PositionedTextPainter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PositionedTextPainter {

 double get position; TextPainter get textPainter;
/// Create a copy of PositionedTextPainter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PositionedTextPainterCopyWith<PositionedTextPainter> get copyWith => _$PositionedTextPainterCopyWithImpl<PositionedTextPainter>(this as PositionedTextPainter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PositionedTextPainter&&(identical(other.position, position) || other.position == position)&&(identical(other.textPainter, textPainter) || other.textPainter == textPainter));
}


@override
int get hashCode => Object.hash(runtimeType,position,textPainter);

@override
String toString() {
  return 'PositionedTextPainter(position: $position, textPainter: $textPainter)';
}


}

/// @nodoc
abstract mixin class $PositionedTextPainterCopyWith<$Res>  {
  factory $PositionedTextPainterCopyWith(PositionedTextPainter value, $Res Function(PositionedTextPainter) _then) = _$PositionedTextPainterCopyWithImpl;
@useResult
$Res call({
 double position, TextPainter textPainter
});




}
/// @nodoc
class _$PositionedTextPainterCopyWithImpl<$Res>
    implements $PositionedTextPainterCopyWith<$Res> {
  _$PositionedTextPainterCopyWithImpl(this._self, this._then);

  final PositionedTextPainter _self;
  final $Res Function(PositionedTextPainter) _then;

/// Create a copy of PositionedTextPainter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? position = null,Object? textPainter = null,}) {
  return _then(_self.copyWith(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as double,textPainter: null == textPainter ? _self.textPainter : textPainter // ignore: cast_nullable_to_non_nullable
as TextPainter,
  ));
}

}


/// @nodoc


class _PositionedTextPainter implements PositionedTextPainter {
  const _PositionedTextPainter(this.position, this.textPainter);
  

@override final  double position;
@override final  TextPainter textPainter;

/// Create a copy of PositionedTextPainter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PositionedTextPainterCopyWith<_PositionedTextPainter> get copyWith => __$PositionedTextPainterCopyWithImpl<_PositionedTextPainter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PositionedTextPainter&&(identical(other.position, position) || other.position == position)&&(identical(other.textPainter, textPainter) || other.textPainter == textPainter));
}


@override
int get hashCode => Object.hash(runtimeType,position,textPainter);

@override
String toString() {
  return 'PositionedTextPainter(position: $position, textPainter: $textPainter)';
}


}

/// @nodoc
abstract mixin class _$PositionedTextPainterCopyWith<$Res> implements $PositionedTextPainterCopyWith<$Res> {
  factory _$PositionedTextPainterCopyWith(_PositionedTextPainter value, $Res Function(_PositionedTextPainter) _then) = __$PositionedTextPainterCopyWithImpl;
@override @useResult
$Res call({
 double position, TextPainter textPainter
});




}
/// @nodoc
class __$PositionedTextPainterCopyWithImpl<$Res>
    implements _$PositionedTextPainterCopyWith<$Res> {
  __$PositionedTextPainterCopyWithImpl(this._self, this._then);

  final _PositionedTextPainter _self;
  final $Res Function(_PositionedTextPainter) _then;

/// Create a copy of PositionedTextPainter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? position = null,Object? textPainter = null,}) {
  return _then(_PositionedTextPainter(
null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as double,null == textPainter ? _self.textPainter : textPainter // ignore: cast_nullable_to_non_nullable
as TextPainter,
  ));
}


}

// dart format on
