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
  double get pointRadius;
  double get lineWidth;
  Color get backgroundColor;
  Color get backgroundColorDark;
  Color get borderColor;
  Color get borderColorDark;
  Color get gridColor;
  Color get gridColorDark;
  Color get textColor;
  Color get textColorDark;

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
            (identical(other.pointRadius, pointRadius) ||
                other.pointRadius == pointRadius) &&
            (identical(other.lineWidth, lineWidth) ||
                other.lineWidth == lineWidth) &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor) &&
            (identical(other.backgroundColorDark, backgroundColorDark) ||
                other.backgroundColorDark == backgroundColorDark) &&
            (identical(other.borderColor, borderColor) ||
                other.borderColor == borderColor) &&
            (identical(other.borderColorDark, borderColorDark) ||
                other.borderColorDark == borderColorDark) &&
            (identical(other.gridColor, gridColor) ||
                other.gridColor == gridColor) &&
            (identical(other.gridColorDark, gridColorDark) ||
                other.gridColorDark == gridColorDark) &&
            (identical(other.textColor, textColor) ||
                other.textColor == textColor) &&
            (identical(other.textColorDark, textColorDark) ||
                other.textColorDark == textColorDark));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      devicePixelRatio,
      fontSize,
      pointRadius,
      lineWidth,
      backgroundColor,
      backgroundColorDark,
      borderColor,
      borderColorDark,
      gridColor,
      gridColorDark,
      textColor,
      textColorDark);

  @override
  String toString() {
    return 'ChartStyle(devicePixelRatio: $devicePixelRatio, fontSize: $fontSize, pointRadius: $pointRadius, lineWidth: $lineWidth, backgroundColor: $backgroundColor, backgroundColorDark: $backgroundColorDark, borderColor: $borderColor, borderColorDark: $borderColorDark, gridColor: $gridColor, gridColorDark: $gridColorDark, textColor: $textColor, textColorDark: $textColorDark)';
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
      double pointRadius,
      double lineWidth,
      Color backgroundColor,
      Color backgroundColorDark,
      Color borderColor,
      Color borderColorDark,
      Color gridColor,
      Color gridColorDark,
      Color textColor,
      Color textColorDark});
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
    Object? pointRadius = null,
    Object? lineWidth = null,
    Object? backgroundColor = null,
    Object? backgroundColorDark = null,
    Object? borderColor = null,
    Object? borderColorDark = null,
    Object? gridColor = null,
    Object? gridColorDark = null,
    Object? textColor = null,
    Object? textColorDark = null,
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
      pointRadius: null == pointRadius
          ? _self.pointRadius
          : pointRadius // ignore: cast_nullable_to_non_nullable
              as double,
      lineWidth: null == lineWidth
          ? _self.lineWidth
          : lineWidth // ignore: cast_nullable_to_non_nullable
              as double,
      backgroundColor: null == backgroundColor
          ? _self.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
      backgroundColorDark: null == backgroundColorDark
          ? _self.backgroundColorDark
          : backgroundColorDark // ignore: cast_nullable_to_non_nullable
              as Color,
      borderColor: null == borderColor
          ? _self.borderColor
          : borderColor // ignore: cast_nullable_to_non_nullable
              as Color,
      borderColorDark: null == borderColorDark
          ? _self.borderColorDark
          : borderColorDark // ignore: cast_nullable_to_non_nullable
              as Color,
      gridColor: null == gridColor
          ? _self.gridColor
          : gridColor // ignore: cast_nullable_to_non_nullable
              as Color,
      gridColorDark: null == gridColorDark
          ? _self.gridColorDark
          : gridColorDark // ignore: cast_nullable_to_non_nullable
              as Color,
      textColor: null == textColor
          ? _self.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as Color,
      textColorDark: null == textColorDark
          ? _self.textColorDark
          : textColorDark // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc

class _ChartStyle implements ChartStyle {
  const _ChartStyle(
      {required this.devicePixelRatio,
      required this.fontSize,
      required this.pointRadius,
      this.lineWidth = 2,
      this.backgroundColor = Colors.white,
      this.backgroundColorDark = Colors.black,
      this.borderColor = Colors.black,
      this.borderColorDark = Colors.white,
      this.gridColor = Colors.grey,
      this.gridColorDark = Colors.grey,
      this.textColor = Colors.black,
      this.textColorDark = Colors.white});

  @override
  final double devicePixelRatio;
  @override
  final double fontSize;
  @override
  final double pointRadius;
  @override
  @JsonKey()
  final double lineWidth;
  @override
  @JsonKey()
  final Color backgroundColor;
  @override
  @JsonKey()
  final Color backgroundColorDark;
  @override
  @JsonKey()
  final Color borderColor;
  @override
  @JsonKey()
  final Color borderColorDark;
  @override
  @JsonKey()
  final Color gridColor;
  @override
  @JsonKey()
  final Color gridColorDark;
  @override
  @JsonKey()
  final Color textColor;
  @override
  @JsonKey()
  final Color textColorDark;

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
            (identical(other.pointRadius, pointRadius) ||
                other.pointRadius == pointRadius) &&
            (identical(other.lineWidth, lineWidth) ||
                other.lineWidth == lineWidth) &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor) &&
            (identical(other.backgroundColorDark, backgroundColorDark) ||
                other.backgroundColorDark == backgroundColorDark) &&
            (identical(other.borderColor, borderColor) ||
                other.borderColor == borderColor) &&
            (identical(other.borderColorDark, borderColorDark) ||
                other.borderColorDark == borderColorDark) &&
            (identical(other.gridColor, gridColor) ||
                other.gridColor == gridColor) &&
            (identical(other.gridColorDark, gridColorDark) ||
                other.gridColorDark == gridColorDark) &&
            (identical(other.textColor, textColor) ||
                other.textColor == textColor) &&
            (identical(other.textColorDark, textColorDark) ||
                other.textColorDark == textColorDark));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      devicePixelRatio,
      fontSize,
      pointRadius,
      lineWidth,
      backgroundColor,
      backgroundColorDark,
      borderColor,
      borderColorDark,
      gridColor,
      gridColorDark,
      textColor,
      textColorDark);

  @override
  String toString() {
    return 'ChartStyle(devicePixelRatio: $devicePixelRatio, fontSize: $fontSize, pointRadius: $pointRadius, lineWidth: $lineWidth, backgroundColor: $backgroundColor, backgroundColorDark: $backgroundColorDark, borderColor: $borderColor, borderColorDark: $borderColorDark, gridColor: $gridColor, gridColorDark: $gridColorDark, textColor: $textColor, textColorDark: $textColorDark)';
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
      double pointRadius,
      double lineWidth,
      Color backgroundColor,
      Color backgroundColorDark,
      Color borderColor,
      Color borderColorDark,
      Color gridColor,
      Color gridColorDark,
      Color textColor,
      Color textColorDark});
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
    Object? pointRadius = null,
    Object? lineWidth = null,
    Object? backgroundColor = null,
    Object? backgroundColorDark = null,
    Object? borderColor = null,
    Object? borderColorDark = null,
    Object? gridColor = null,
    Object? gridColorDark = null,
    Object? textColor = null,
    Object? textColorDark = null,
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
      pointRadius: null == pointRadius
          ? _self.pointRadius
          : pointRadius // ignore: cast_nullable_to_non_nullable
              as double,
      lineWidth: null == lineWidth
          ? _self.lineWidth
          : lineWidth // ignore: cast_nullable_to_non_nullable
              as double,
      backgroundColor: null == backgroundColor
          ? _self.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
      backgroundColorDark: null == backgroundColorDark
          ? _self.backgroundColorDark
          : backgroundColorDark // ignore: cast_nullable_to_non_nullable
              as Color,
      borderColor: null == borderColor
          ? _self.borderColor
          : borderColor // ignore: cast_nullable_to_non_nullable
              as Color,
      borderColorDark: null == borderColorDark
          ? _self.borderColorDark
          : borderColorDark // ignore: cast_nullable_to_non_nullable
              as Color,
      gridColor: null == gridColor
          ? _self.gridColor
          : gridColor // ignore: cast_nullable_to_non_nullable
              as Color,
      gridColorDark: null == gridColorDark
          ? _self.gridColorDark
          : gridColorDark // ignore: cast_nullable_to_non_nullable
              as Color,
      textColor: null == textColor
          ? _self.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as Color,
      textColorDark: null == textColorDark
          ? _self.textColorDark
          : textColorDark // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

// dart format on
