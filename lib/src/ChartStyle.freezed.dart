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
  Color get borderColor;
  Color get borderColorDark;
  Color get dataTipBackgroundColor;
  Color get dataTipBackgroundColorDark;
  Color get gridColor;
  Color get gridColorDark;
  double get lineWidth;
  bool get showTicksBottom;
  bool get showTicksLeft;
  bool get showTicksRight;
  bool get showTicksTop;
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
            (identical(other.borderColor, borderColor) ||
                other.borderColor == borderColor) &&
            (identical(other.borderColorDark, borderColorDark) ||
                other.borderColorDark == borderColorDark) &&
            (identical(other.dataTipBackgroundColor, dataTipBackgroundColor) ||
                other.dataTipBackgroundColor == dataTipBackgroundColor) &&
            (identical(other.dataTipBackgroundColorDark,
                    dataTipBackgroundColorDark) ||
                other.dataTipBackgroundColorDark ==
                    dataTipBackgroundColorDark) &&
            (identical(other.gridColor, gridColor) ||
                other.gridColor == gridColor) &&
            (identical(other.gridColorDark, gridColorDark) ||
                other.gridColorDark == gridColorDark) &&
            (identical(other.lineWidth, lineWidth) ||
                other.lineWidth == lineWidth) &&
            (identical(other.showTicksBottom, showTicksBottom) ||
                other.showTicksBottom == showTicksBottom) &&
            (identical(other.showTicksLeft, showTicksLeft) ||
                other.showTicksLeft == showTicksLeft) &&
            (identical(other.showTicksRight, showTicksRight) ||
                other.showTicksRight == showTicksRight) &&
            (identical(other.showTicksTop, showTicksTop) ||
                other.showTicksTop == showTicksTop) &&
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
      borderColor,
      borderColorDark,
      dataTipBackgroundColor,
      dataTipBackgroundColorDark,
      gridColor,
      gridColorDark,
      lineWidth,
      showTicksBottom,
      showTicksLeft,
      showTicksRight,
      showTicksTop,
      textColor,
      textColorDark);

  @override
  String toString() {
    return 'ChartStyle(devicePixelRatio: $devicePixelRatio, fontSize: $fontSize, pointRadius: $pointRadius, borderColor: $borderColor, borderColorDark: $borderColorDark, dataTipBackgroundColor: $dataTipBackgroundColor, dataTipBackgroundColorDark: $dataTipBackgroundColorDark, gridColor: $gridColor, gridColorDark: $gridColorDark, lineWidth: $lineWidth, showTicksBottom: $showTicksBottom, showTicksLeft: $showTicksLeft, showTicksRight: $showTicksRight, showTicksTop: $showTicksTop, textColor: $textColor, textColorDark: $textColorDark)';
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
      Color borderColor,
      Color borderColorDark,
      Color dataTipBackgroundColor,
      Color dataTipBackgroundColorDark,
      Color gridColor,
      Color gridColorDark,
      double lineWidth,
      bool showTicksBottom,
      bool showTicksLeft,
      bool showTicksRight,
      bool showTicksTop,
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
    Object? borderColor = null,
    Object? borderColorDark = null,
    Object? dataTipBackgroundColor = null,
    Object? dataTipBackgroundColorDark = null,
    Object? gridColor = null,
    Object? gridColorDark = null,
    Object? lineWidth = null,
    Object? showTicksBottom = null,
    Object? showTicksLeft = null,
    Object? showTicksRight = null,
    Object? showTicksTop = null,
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
      borderColor: null == borderColor
          ? _self.borderColor
          : borderColor // ignore: cast_nullable_to_non_nullable
              as Color,
      borderColorDark: null == borderColorDark
          ? _self.borderColorDark
          : borderColorDark // ignore: cast_nullable_to_non_nullable
              as Color,
      dataTipBackgroundColor: null == dataTipBackgroundColor
          ? _self.dataTipBackgroundColor
          : dataTipBackgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
      dataTipBackgroundColorDark: null == dataTipBackgroundColorDark
          ? _self.dataTipBackgroundColorDark
          : dataTipBackgroundColorDark // ignore: cast_nullable_to_non_nullable
              as Color,
      gridColor: null == gridColor
          ? _self.gridColor
          : gridColor // ignore: cast_nullable_to_non_nullable
              as Color,
      gridColorDark: null == gridColorDark
          ? _self.gridColorDark
          : gridColorDark // ignore: cast_nullable_to_non_nullable
              as Color,
      lineWidth: null == lineWidth
          ? _self.lineWidth
          : lineWidth // ignore: cast_nullable_to_non_nullable
              as double,
      showTicksBottom: null == showTicksBottom
          ? _self.showTicksBottom
          : showTicksBottom // ignore: cast_nullable_to_non_nullable
              as bool,
      showTicksLeft: null == showTicksLeft
          ? _self.showTicksLeft
          : showTicksLeft // ignore: cast_nullable_to_non_nullable
              as bool,
      showTicksRight: null == showTicksRight
          ? _self.showTicksRight
          : showTicksRight // ignore: cast_nullable_to_non_nullable
              as bool,
      showTicksTop: null == showTicksTop
          ? _self.showTicksTop
          : showTicksTop // ignore: cast_nullable_to_non_nullable
              as bool,
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
      this.borderColor = Colors.black,
      this.borderColorDark = Colors.white,
      this.dataTipBackgroundColor = Colors.white,
      this.dataTipBackgroundColorDark = Colors.black,
      this.gridColor = Colors.grey,
      this.gridColorDark = Colors.grey,
      this.lineWidth = 2,
      this.showTicksBottom = false,
      this.showTicksLeft = false,
      this.showTicksRight = false,
      this.showTicksTop = false,
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
  final Color borderColor;
  @override
  @JsonKey()
  final Color borderColorDark;
  @override
  @JsonKey()
  final Color dataTipBackgroundColor;
  @override
  @JsonKey()
  final Color dataTipBackgroundColorDark;
  @override
  @JsonKey()
  final Color gridColor;
  @override
  @JsonKey()
  final Color gridColorDark;
  @override
  @JsonKey()
  final double lineWidth;
  @override
  @JsonKey()
  final bool showTicksBottom;
  @override
  @JsonKey()
  final bool showTicksLeft;
  @override
  @JsonKey()
  final bool showTicksRight;
  @override
  @JsonKey()
  final bool showTicksTop;
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
            (identical(other.borderColor, borderColor) ||
                other.borderColor == borderColor) &&
            (identical(other.borderColorDark, borderColorDark) ||
                other.borderColorDark == borderColorDark) &&
            (identical(other.dataTipBackgroundColor, dataTipBackgroundColor) ||
                other.dataTipBackgroundColor == dataTipBackgroundColor) &&
            (identical(other.dataTipBackgroundColorDark,
                    dataTipBackgroundColorDark) ||
                other.dataTipBackgroundColorDark ==
                    dataTipBackgroundColorDark) &&
            (identical(other.gridColor, gridColor) ||
                other.gridColor == gridColor) &&
            (identical(other.gridColorDark, gridColorDark) ||
                other.gridColorDark == gridColorDark) &&
            (identical(other.lineWidth, lineWidth) ||
                other.lineWidth == lineWidth) &&
            (identical(other.showTicksBottom, showTicksBottom) ||
                other.showTicksBottom == showTicksBottom) &&
            (identical(other.showTicksLeft, showTicksLeft) ||
                other.showTicksLeft == showTicksLeft) &&
            (identical(other.showTicksRight, showTicksRight) ||
                other.showTicksRight == showTicksRight) &&
            (identical(other.showTicksTop, showTicksTop) ||
                other.showTicksTop == showTicksTop) &&
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
      borderColor,
      borderColorDark,
      dataTipBackgroundColor,
      dataTipBackgroundColorDark,
      gridColor,
      gridColorDark,
      lineWidth,
      showTicksBottom,
      showTicksLeft,
      showTicksRight,
      showTicksTop,
      textColor,
      textColorDark);

  @override
  String toString() {
    return 'ChartStyle(devicePixelRatio: $devicePixelRatio, fontSize: $fontSize, pointRadius: $pointRadius, borderColor: $borderColor, borderColorDark: $borderColorDark, dataTipBackgroundColor: $dataTipBackgroundColor, dataTipBackgroundColorDark: $dataTipBackgroundColorDark, gridColor: $gridColor, gridColorDark: $gridColorDark, lineWidth: $lineWidth, showTicksBottom: $showTicksBottom, showTicksLeft: $showTicksLeft, showTicksRight: $showTicksRight, showTicksTop: $showTicksTop, textColor: $textColor, textColorDark: $textColorDark)';
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
      Color borderColor,
      Color borderColorDark,
      Color dataTipBackgroundColor,
      Color dataTipBackgroundColorDark,
      Color gridColor,
      Color gridColorDark,
      double lineWidth,
      bool showTicksBottom,
      bool showTicksLeft,
      bool showTicksRight,
      bool showTicksTop,
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
    Object? borderColor = null,
    Object? borderColorDark = null,
    Object? dataTipBackgroundColor = null,
    Object? dataTipBackgroundColorDark = null,
    Object? gridColor = null,
    Object? gridColorDark = null,
    Object? lineWidth = null,
    Object? showTicksBottom = null,
    Object? showTicksLeft = null,
    Object? showTicksRight = null,
    Object? showTicksTop = null,
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
      borderColor: null == borderColor
          ? _self.borderColor
          : borderColor // ignore: cast_nullable_to_non_nullable
              as Color,
      borderColorDark: null == borderColorDark
          ? _self.borderColorDark
          : borderColorDark // ignore: cast_nullable_to_non_nullable
              as Color,
      dataTipBackgroundColor: null == dataTipBackgroundColor
          ? _self.dataTipBackgroundColor
          : dataTipBackgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
      dataTipBackgroundColorDark: null == dataTipBackgroundColorDark
          ? _self.dataTipBackgroundColorDark
          : dataTipBackgroundColorDark // ignore: cast_nullable_to_non_nullable
              as Color,
      gridColor: null == gridColor
          ? _self.gridColor
          : gridColor // ignore: cast_nullable_to_non_nullable
              as Color,
      gridColorDark: null == gridColorDark
          ? _self.gridColorDark
          : gridColorDark // ignore: cast_nullable_to_non_nullable
              as Color,
      lineWidth: null == lineWidth
          ? _self.lineWidth
          : lineWidth // ignore: cast_nullable_to_non_nullable
              as double,
      showTicksBottom: null == showTicksBottom
          ? _self.showTicksBottom
          : showTicksBottom // ignore: cast_nullable_to_non_nullable
              as bool,
      showTicksLeft: null == showTicksLeft
          ? _self.showTicksLeft
          : showTicksLeft // ignore: cast_nullable_to_non_nullable
              as bool,
      showTicksRight: null == showTicksRight
          ? _self.showTicksRight
          : showTicksRight // ignore: cast_nullable_to_non_nullable
              as bool,
      showTicksTop: null == showTicksTop
          ? _self.showTicksTop
          : showTicksTop // ignore: cast_nullable_to_non_nullable
              as bool,
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
