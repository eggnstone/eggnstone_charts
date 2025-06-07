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
  String get dataTipFormat;
  String get labelBottom;
  String get labelLeft;
  String get labelRight;
  String get labelTop;
  String get title;

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
            (identical(other.dataTipFormat, dataTipFormat) ||
                other.dataTipFormat == dataTipFormat) &&
            (identical(other.labelBottom, labelBottom) ||
                other.labelBottom == labelBottom) &&
            (identical(other.labelLeft, labelLeft) ||
                other.labelLeft == labelLeft) &&
            (identical(other.labelRight, labelRight) ||
                other.labelRight == labelRight) &&
            (identical(other.labelTop, labelTop) ||
                other.labelTop == labelTop) &&
            (identical(other.title, title) || other.title == title));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dataTipFormat, labelBottom,
      labelLeft, labelRight, labelTop, title);

  @override
  String toString() {
    return 'ChartInfo(dataTipFormat: $dataTipFormat, labelBottom: $labelBottom, labelLeft: $labelLeft, labelRight: $labelRight, labelTop: $labelTop, title: $title)';
  }
}

/// @nodoc
abstract mixin class $ChartInfoCopyWith<$Res> {
  factory $ChartInfoCopyWith(ChartInfo value, $Res Function(ChartInfo) _then) =
      _$ChartInfoCopyWithImpl;
  @useResult
  $Res call(
      {String dataTipFormat,
      String labelBottom,
      String labelLeft,
      String labelRight,
      String labelTop,
      String title});
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
    Object? dataTipFormat = null,
    Object? labelBottom = null,
    Object? labelLeft = null,
    Object? labelRight = null,
    Object? labelTop = null,
    Object? title = null,
  }) {
    return _then(_self.copyWith(
      dataTipFormat: null == dataTipFormat
          ? _self.dataTipFormat
          : dataTipFormat // ignore: cast_nullable_to_non_nullable
              as String,
      labelBottom: null == labelBottom
          ? _self.labelBottom
          : labelBottom // ignore: cast_nullable_to_non_nullable
              as String,
      labelLeft: null == labelLeft
          ? _self.labelLeft
          : labelLeft // ignore: cast_nullable_to_non_nullable
              as String,
      labelRight: null == labelRight
          ? _self.labelRight
          : labelRight // ignore: cast_nullable_to_non_nullable
              as String,
      labelTop: null == labelTop
          ? _self.labelTop
          : labelTop // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _ChartInfo implements ChartInfo {
  const _ChartInfo(
      {this.dataTipFormat = '%s\nX: %x\nY: %y',
      this.labelBottom = '',
      this.labelLeft = '',
      this.labelRight = '',
      this.labelTop = '',
      this.title = ''});

  @override
  @JsonKey()
  final String dataTipFormat;
  @override
  @JsonKey()
  final String labelBottom;
  @override
  @JsonKey()
  final String labelLeft;
  @override
  @JsonKey()
  final String labelRight;
  @override
  @JsonKey()
  final String labelTop;
  @override
  @JsonKey()
  final String title;

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
            (identical(other.dataTipFormat, dataTipFormat) ||
                other.dataTipFormat == dataTipFormat) &&
            (identical(other.labelBottom, labelBottom) ||
                other.labelBottom == labelBottom) &&
            (identical(other.labelLeft, labelLeft) ||
                other.labelLeft == labelLeft) &&
            (identical(other.labelRight, labelRight) ||
                other.labelRight == labelRight) &&
            (identical(other.labelTop, labelTop) ||
                other.labelTop == labelTop) &&
            (identical(other.title, title) || other.title == title));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dataTipFormat, labelBottom,
      labelLeft, labelRight, labelTop, title);

  @override
  String toString() {
    return 'ChartInfo(dataTipFormat: $dataTipFormat, labelBottom: $labelBottom, labelLeft: $labelLeft, labelRight: $labelRight, labelTop: $labelTop, title: $title)';
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
      {String dataTipFormat,
      String labelBottom,
      String labelLeft,
      String labelRight,
      String labelTop,
      String title});
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
    Object? dataTipFormat = null,
    Object? labelBottom = null,
    Object? labelLeft = null,
    Object? labelRight = null,
    Object? labelTop = null,
    Object? title = null,
  }) {
    return _then(_ChartInfo(
      dataTipFormat: null == dataTipFormat
          ? _self.dataTipFormat
          : dataTipFormat // ignore: cast_nullable_to_non_nullable
              as String,
      labelBottom: null == labelBottom
          ? _self.labelBottom
          : labelBottom // ignore: cast_nullable_to_non_nullable
              as String,
      labelLeft: null == labelLeft
          ? _self.labelLeft
          : labelLeft // ignore: cast_nullable_to_non_nullable
              as String,
      labelRight: null == labelRight
          ? _self.labelRight
          : labelRight // ignore: cast_nullable_to_non_nullable
              as String,
      labelTop: null == labelTop
          ? _self.labelTop
          : labelTop // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
