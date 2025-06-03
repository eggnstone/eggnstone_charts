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
mixin _$PositionedTextPainter<T> {
  double get linePosition;
  double get textPosition;
  TextPainter? get textPainter;

  /// Create a copy of PositionedTextPainter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PositionedTextPainterCopyWith<T, PositionedTextPainter<T>> get copyWith =>
      _$PositionedTextPainterCopyWithImpl<T, PositionedTextPainter<T>>(
          this as PositionedTextPainter<T>, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PositionedTextPainter<T> &&
            (identical(other.linePosition, linePosition) ||
                other.linePosition == linePosition) &&
            (identical(other.textPosition, textPosition) ||
                other.textPosition == textPosition) &&
            (identical(other.textPainter, textPainter) ||
                other.textPainter == textPainter));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, linePosition, textPosition, textPainter);

  @override
  String toString() {
    return 'PositionedTextPainter<$T>(linePosition: $linePosition, textPosition: $textPosition, textPainter: $textPainter)';
  }
}

/// @nodoc
abstract mixin class $PositionedTextPainterCopyWith<T, $Res> {
  factory $PositionedTextPainterCopyWith(PositionedTextPainter<T> value,
          $Res Function(PositionedTextPainter<T>) _then) =
      _$PositionedTextPainterCopyWithImpl;
  @useResult
  $Res call(
      {double linePosition, double textPosition, TextPainter? textPainter});
}

/// @nodoc
class _$PositionedTextPainterCopyWithImpl<T, $Res>
    implements $PositionedTextPainterCopyWith<T, $Res> {
  _$PositionedTextPainterCopyWithImpl(this._self, this._then);

  final PositionedTextPainter<T> _self;
  final $Res Function(PositionedTextPainter<T>) _then;

  /// Create a copy of PositionedTextPainter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? linePosition = null,
    Object? textPosition = null,
    Object? textPainter = freezed,
  }) {
    return _then(_self.copyWith(
      linePosition: null == linePosition
          ? _self.linePosition
          : linePosition // ignore: cast_nullable_to_non_nullable
              as double,
      textPosition: null == textPosition
          ? _self.textPosition
          : textPosition // ignore: cast_nullable_to_non_nullable
              as double,
      textPainter: freezed == textPainter
          ? _self.textPainter
          : textPainter // ignore: cast_nullable_to_non_nullable
              as TextPainter?,
    ));
  }
}

/// @nodoc

class _PositionedTextPainter<T> extends PositionedTextPainter<T> {
  const _PositionedTextPainter(
      {required this.linePosition,
      required this.textPosition,
      required this.textPainter})
      : super._();

  @override
  final double linePosition;
  @override
  final double textPosition;
  @override
  final TextPainter? textPainter;

  /// Create a copy of PositionedTextPainter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PositionedTextPainterCopyWith<T, _PositionedTextPainter<T>> get copyWith =>
      __$PositionedTextPainterCopyWithImpl<T, _PositionedTextPainter<T>>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PositionedTextPainter<T> &&
            (identical(other.linePosition, linePosition) ||
                other.linePosition == linePosition) &&
            (identical(other.textPosition, textPosition) ||
                other.textPosition == textPosition) &&
            (identical(other.textPainter, textPainter) ||
                other.textPainter == textPainter));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, linePosition, textPosition, textPainter);

  @override
  String toString() {
    return 'PositionedTextPainter<$T>(linePosition: $linePosition, textPosition: $textPosition, textPainter: $textPainter)';
  }
}

/// @nodoc
abstract mixin class _$PositionedTextPainterCopyWith<T, $Res>
    implements $PositionedTextPainterCopyWith<T, $Res> {
  factory _$PositionedTextPainterCopyWith(_PositionedTextPainter<T> value,
          $Res Function(_PositionedTextPainter<T>) _then) =
      __$PositionedTextPainterCopyWithImpl;
  @override
  @useResult
  $Res call(
      {double linePosition, double textPosition, TextPainter? textPainter});
}

/// @nodoc
class __$PositionedTextPainterCopyWithImpl<T, $Res>
    implements _$PositionedTextPainterCopyWith<T, $Res> {
  __$PositionedTextPainterCopyWithImpl(this._self, this._then);

  final _PositionedTextPainter<T> _self;
  final $Res Function(_PositionedTextPainter<T>) _then;

  /// Create a copy of PositionedTextPainter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? linePosition = null,
    Object? textPosition = null,
    Object? textPainter = freezed,
  }) {
    return _then(_PositionedTextPainter<T>(
      linePosition: null == linePosition
          ? _self.linePosition
          : linePosition // ignore: cast_nullable_to_non_nullable
              as double,
      textPosition: null == textPosition
          ? _self.textPosition
          : textPosition // ignore: cast_nullable_to_non_nullable
              as double,
      textPainter: freezed == textPainter
          ? _self.textPainter
          : textPainter // ignore: cast_nullable_to_non_nullable
              as TextPainter?,
    ));
  }
}

// dart format on
