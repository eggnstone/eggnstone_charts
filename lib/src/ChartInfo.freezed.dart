// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ChartInfo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChartInfo {
  String get title;
  String get xAxisNameBottom;
  String get xAxisNameTop;
  String get yAxisNameLeft;
  String get yAxisNameRight;

  /// Create a copy of ChartInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChartInfoCopyWith<ChartInfo> get copyWith =>
      _$ChartInfoCopyWithImpl<ChartInfo>(this as ChartInfo, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChartInfo &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.xAxisNameBottom, xAxisNameBottom) ||
                other.xAxisNameBottom == xAxisNameBottom) &&
            (identical(other.xAxisNameTop, xAxisNameTop) ||
                other.xAxisNameTop == xAxisNameTop) &&
            (identical(other.yAxisNameLeft, yAxisNameLeft) ||
                other.yAxisNameLeft == yAxisNameLeft) &&
            (identical(other.yAxisNameRight, yAxisNameRight) ||
                other.yAxisNameRight == yAxisNameRight));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, xAxisNameBottom,
      xAxisNameTop, yAxisNameLeft, yAxisNameRight);

  @override
  String toString() {
    return 'ChartInfo(title: $title, xAxisNameBottom: $xAxisNameBottom, xAxisNameTop: $xAxisNameTop, yAxisNameLeft: $yAxisNameLeft, yAxisNameRight: $yAxisNameRight)';
  }
}

/// @nodoc
abstract mixin class $ChartInfoCopyWith<$Res> {
  factory $ChartInfoCopyWith(ChartInfo value, $Res Function(ChartInfo) _then) =
      _$ChartInfoCopyWithImpl;
  @useResult
  $Res call(
      {String title,
      String xAxisNameBottom,
      String xAxisNameTop,
      String yAxisNameLeft,
      String yAxisNameRight});
}

/// @nodoc
class _$ChartInfoCopyWithImpl<$Res> implements $ChartInfoCopyWith<$Res> {
  _$ChartInfoCopyWithImpl(this._self, this._then);

  final ChartInfo _self;
  final $Res Function(ChartInfo) _then;

  /// Create a copy of ChartInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? xAxisNameBottom = null,
    Object? xAxisNameTop = null,
    Object? yAxisNameLeft = null,
    Object? yAxisNameRight = null,
  }) {
    return _then(_self.copyWith(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      xAxisNameBottom: null == xAxisNameBottom
          ? _self.xAxisNameBottom
          : xAxisNameBottom // ignore: cast_nullable_to_non_nullable
              as String,
      xAxisNameTop: null == xAxisNameTop
          ? _self.xAxisNameTop
          : xAxisNameTop // ignore: cast_nullable_to_non_nullable
              as String,
      yAxisNameLeft: null == yAxisNameLeft
          ? _self.yAxisNameLeft
          : yAxisNameLeft // ignore: cast_nullable_to_non_nullable
              as String,
      yAxisNameRight: null == yAxisNameRight
          ? _self.yAxisNameRight
          : yAxisNameRight // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _ChartInfo implements ChartInfo {
  const _ChartInfo(
      {required this.title,
      this.xAxisNameBottom = '',
      this.xAxisNameTop = '',
      this.yAxisNameLeft = '',
      this.yAxisNameRight = ''});

  @override
  final String title;
  @override
  @JsonKey()
  final String xAxisNameBottom;
  @override
  @JsonKey()
  final String xAxisNameTop;
  @override
  @JsonKey()
  final String yAxisNameLeft;
  @override
  @JsonKey()
  final String yAxisNameRight;

  /// Create a copy of ChartInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChartInfoCopyWith<_ChartInfo> get copyWith =>
      __$ChartInfoCopyWithImpl<_ChartInfo>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChartInfo &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.xAxisNameBottom, xAxisNameBottom) ||
                other.xAxisNameBottom == xAxisNameBottom) &&
            (identical(other.xAxisNameTop, xAxisNameTop) ||
                other.xAxisNameTop == xAxisNameTop) &&
            (identical(other.yAxisNameLeft, yAxisNameLeft) ||
                other.yAxisNameLeft == yAxisNameLeft) &&
            (identical(other.yAxisNameRight, yAxisNameRight) ||
                other.yAxisNameRight == yAxisNameRight));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, xAxisNameBottom,
      xAxisNameTop, yAxisNameLeft, yAxisNameRight);

  @override
  String toString() {
    return 'ChartInfo(title: $title, xAxisNameBottom: $xAxisNameBottom, xAxisNameTop: $xAxisNameTop, yAxisNameLeft: $yAxisNameLeft, yAxisNameRight: $yAxisNameRight)';
  }
}

/// @nodoc
abstract mixin class _$ChartInfoCopyWith<$Res>
    implements $ChartInfoCopyWith<$Res> {
  factory _$ChartInfoCopyWith(
          _ChartInfo value, $Res Function(_ChartInfo) _then) =
      __$ChartInfoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String title,
      String xAxisNameBottom,
      String xAxisNameTop,
      String yAxisNameLeft,
      String yAxisNameRight});
}

/// @nodoc
class __$ChartInfoCopyWithImpl<$Res> implements _$ChartInfoCopyWith<$Res> {
  __$ChartInfoCopyWithImpl(this._self, this._then);

  final _ChartInfo _self;
  final $Res Function(_ChartInfo) _then;

  /// Create a copy of ChartInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = null,
    Object? xAxisNameBottom = null,
    Object? xAxisNameTop = null,
    Object? yAxisNameLeft = null,
    Object? yAxisNameRight = null,
  }) {
    return _then(_ChartInfo(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      xAxisNameBottom: null == xAxisNameBottom
          ? _self.xAxisNameBottom
          : xAxisNameBottom // ignore: cast_nullable_to_non_nullable
              as String,
      xAxisNameTop: null == xAxisNameTop
          ? _self.xAxisNameTop
          : xAxisNameTop // ignore: cast_nullable_to_non_nullable
              as String,
      yAxisNameLeft: null == yAxisNameLeft
          ? _self.yAxisNameLeft
          : yAxisNameLeft // ignore: cast_nullable_to_non_nullable
              as String,
      yAxisNameRight: null == yAxisNameRight
          ? _self.yAxisNameRight
          : yAxisNameRight // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
