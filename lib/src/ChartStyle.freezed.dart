// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ChartStyle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChartStyle {
  double get devicePixelRatio;
  double get fontSize;
  double get radius;
  Color? get lineColor;
  Color? get textColor;

  /// Create a copy of ChartStyle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChartStyleCopyWith<ChartStyle> get copyWith =>
      _$ChartStyleCopyWithImpl<ChartStyle>(this as ChartStyle, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChartStyle &&
            (identical(other.devicePixelRatio, devicePixelRatio) ||
                other.devicePixelRatio == devicePixelRatio) &&
            (identical(other.fontSize, fontSize) ||
                other.fontSize == fontSize) &&
            (identical(other.radius, radius) || other.radius == radius) &&
            (identical(other.lineColor, lineColor) ||
                other.lineColor == lineColor) &&
            (identical(other.textColor, textColor) ||
                other.textColor == textColor));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, devicePixelRatio, fontSize, radius, lineColor, textColor);

  @override
  String toString() {
    return 'ChartStyle(devicePixelRatio: $devicePixelRatio, fontSize: $fontSize, radius: $radius, lineColor: $lineColor, textColor: $textColor)';
  }
}

/// @nodoc
abstract mixin class $ChartStyleCopyWith<$Res> {
  factory $ChartStyleCopyWith(
          ChartStyle value, $Res Function(ChartStyle) _then) =
      _$ChartStyleCopyWithImpl;
  @useResult
  $Res call(
      {double devicePixelRatio,
      double fontSize,
      double radius,
      Color? lineColor,
      Color? textColor});
}

/// @nodoc
class _$ChartStyleCopyWithImpl<$Res> implements $ChartStyleCopyWith<$Res> {
  _$ChartStyleCopyWithImpl(this._self, this._then);

  final ChartStyle _self;
  final $Res Function(ChartStyle) _then;

  /// Create a copy of ChartStyle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? devicePixelRatio = null,
    Object? fontSize = null,
    Object? radius = null,
    Object? lineColor = freezed,
    Object? textColor = freezed,
  }) {
    return _then(_self.copyWith(
      devicePixelRatio: null == devicePixelRatio
          ? _self.devicePixelRatio
          : devicePixelRatio // ignore: cast_nullable_to_non_nullable
              as double,
      fontSize: null == fontSize
          ? _self.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as double,
      radius: null == radius
          ? _self.radius
          : radius // ignore: cast_nullable_to_non_nullable
              as double,
      lineColor: freezed == lineColor
          ? _self.lineColor
          : lineColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      textColor: freezed == textColor
          ? _self.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as Color?,
    ));
  }
}

/// @nodoc

class _ChartStyle implements ChartStyle {
  const _ChartStyle(
      {required this.devicePixelRatio,
      required this.fontSize,
      required this.radius,
      this.lineColor,
      this.textColor});

  @override
  final double devicePixelRatio;
  @override
  final double fontSize;
  @override
  final double radius;
  @override
  final Color? lineColor;
  @override
  final Color? textColor;

  /// Create a copy of ChartStyle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChartStyleCopyWith<_ChartStyle> get copyWith =>
      __$ChartStyleCopyWithImpl<_ChartStyle>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChartStyle &&
            (identical(other.devicePixelRatio, devicePixelRatio) ||
                other.devicePixelRatio == devicePixelRatio) &&
            (identical(other.fontSize, fontSize) ||
                other.fontSize == fontSize) &&
            (identical(other.radius, radius) || other.radius == radius) &&
            (identical(other.lineColor, lineColor) ||
                other.lineColor == lineColor) &&
            (identical(other.textColor, textColor) ||
                other.textColor == textColor));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, devicePixelRatio, fontSize, radius, lineColor, textColor);

  @override
  String toString() {
    return 'ChartStyle(devicePixelRatio: $devicePixelRatio, fontSize: $fontSize, radius: $radius, lineColor: $lineColor, textColor: $textColor)';
  }
}

/// @nodoc
abstract mixin class _$ChartStyleCopyWith<$Res>
    implements $ChartStyleCopyWith<$Res> {
  factory _$ChartStyleCopyWith(
          _ChartStyle value, $Res Function(_ChartStyle) _then) =
      __$ChartStyleCopyWithImpl;
  @override
  @useResult
  $Res call(
      {double devicePixelRatio,
      double fontSize,
      double radius,
      Color? lineColor,
      Color? textColor});
}

/// @nodoc
class __$ChartStyleCopyWithImpl<$Res> implements _$ChartStyleCopyWith<$Res> {
  __$ChartStyleCopyWithImpl(this._self, this._then);

  final _ChartStyle _self;
  final $Res Function(_ChartStyle) _then;

  /// Create a copy of ChartStyle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? devicePixelRatio = null,
    Object? fontSize = null,
    Object? radius = null,
    Object? lineColor = freezed,
    Object? textColor = freezed,
  }) {
    return _then(_ChartStyle(
      devicePixelRatio: null == devicePixelRatio
          ? _self.devicePixelRatio
          : devicePixelRatio // ignore: cast_nullable_to_non_nullable
              as double,
      fontSize: null == fontSize
          ? _self.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as double,
      radius: null == radius
          ? _self.radius
          : radius // ignore: cast_nullable_to_non_nullable
              as double,
      lineColor: freezed == lineColor
          ? _self.lineColor
          : lineColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      textColor: freezed == textColor
          ? _self.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as Color?,
    ));
  }
}

// dart format on
