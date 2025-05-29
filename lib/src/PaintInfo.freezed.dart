// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'PaintInfo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaintInfo {
  Canvas get canvas;
  Size get size;
  DoubleMinMax get graphMinMax;
  Paint get backgroundPaint;
  Paint get borderPaint;
  Paint get gridPaint;
  Paint get gridPaint2;

  /// Create a copy of PaintInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PaintInfoCopyWith<PaintInfo> get copyWith =>
      _$PaintInfoCopyWithImpl<PaintInfo>(this as PaintInfo, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PaintInfo &&
            (identical(other.canvas, canvas) || other.canvas == canvas) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.graphMinMax, graphMinMax) ||
                other.graphMinMax == graphMinMax) &&
            (identical(other.backgroundPaint, backgroundPaint) ||
                other.backgroundPaint == backgroundPaint) &&
            (identical(other.borderPaint, borderPaint) ||
                other.borderPaint == borderPaint) &&
            (identical(other.gridPaint, gridPaint) ||
                other.gridPaint == gridPaint) &&
            (identical(other.gridPaint2, gridPaint2) ||
                other.gridPaint2 == gridPaint2));
  }

  @override
  int get hashCode => Object.hash(runtimeType, canvas, size, graphMinMax,
      backgroundPaint, borderPaint, gridPaint, gridPaint2);

  @override
  String toString() {
    return 'PaintInfo(canvas: $canvas, size: $size, graphMinMax: $graphMinMax, backgroundPaint: $backgroundPaint, borderPaint: $borderPaint, gridPaint: $gridPaint, gridPaint2: $gridPaint2)';
  }
}

/// @nodoc
abstract mixin class $PaintInfoCopyWith<$Res> {
  factory $PaintInfoCopyWith(PaintInfo value, $Res Function(PaintInfo) _then) =
      _$PaintInfoCopyWithImpl;
  @useResult
  $Res call(
      {Canvas canvas,
      Size size,
      DoubleMinMax graphMinMax,
      Paint backgroundPaint,
      Paint borderPaint,
      Paint gridPaint,
      Paint gridPaint2});
}

/// @nodoc
class _$PaintInfoCopyWithImpl<$Res> implements $PaintInfoCopyWith<$Res> {
  _$PaintInfoCopyWithImpl(this._self, this._then);

  final PaintInfo _self;
  final $Res Function(PaintInfo) _then;

  /// Create a copy of PaintInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canvas = null,
    Object? size = null,
    Object? graphMinMax = null,
    Object? backgroundPaint = null,
    Object? borderPaint = null,
    Object? gridPaint = null,
    Object? gridPaint2 = null,
  }) {
    return _then(_self.copyWith(
      canvas: null == canvas
          ? _self.canvas
          : canvas // ignore: cast_nullable_to_non_nullable
              as Canvas,
      size: null == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as Size,
      graphMinMax: null == graphMinMax
          ? _self.graphMinMax
          : graphMinMax // ignore: cast_nullable_to_non_nullable
              as DoubleMinMax,
      backgroundPaint: null == backgroundPaint
          ? _self.backgroundPaint
          : backgroundPaint // ignore: cast_nullable_to_non_nullable
              as Paint,
      borderPaint: null == borderPaint
          ? _self.borderPaint
          : borderPaint // ignore: cast_nullable_to_non_nullable
              as Paint,
      gridPaint: null == gridPaint
          ? _self.gridPaint
          : gridPaint // ignore: cast_nullable_to_non_nullable
              as Paint,
      gridPaint2: null == gridPaint2
          ? _self.gridPaint2
          : gridPaint2 // ignore: cast_nullable_to_non_nullable
              as Paint,
    ));
  }
}

/// @nodoc

class _PaintInfo implements PaintInfo {
  const _PaintInfo(
      {required this.canvas,
      required this.size,
      required this.graphMinMax,
      required this.backgroundPaint,
      required this.borderPaint,
      required this.gridPaint,
      required this.gridPaint2});

  @override
  final Canvas canvas;
  @override
  final Size size;
  @override
  final DoubleMinMax graphMinMax;
  @override
  final Paint backgroundPaint;
  @override
  final Paint borderPaint;
  @override
  final Paint gridPaint;
  @override
  final Paint gridPaint2;

  /// Create a copy of PaintInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PaintInfoCopyWith<_PaintInfo> get copyWith =>
      __$PaintInfoCopyWithImpl<_PaintInfo>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PaintInfo &&
            (identical(other.canvas, canvas) || other.canvas == canvas) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.graphMinMax, graphMinMax) ||
                other.graphMinMax == graphMinMax) &&
            (identical(other.backgroundPaint, backgroundPaint) ||
                other.backgroundPaint == backgroundPaint) &&
            (identical(other.borderPaint, borderPaint) ||
                other.borderPaint == borderPaint) &&
            (identical(other.gridPaint, gridPaint) ||
                other.gridPaint == gridPaint) &&
            (identical(other.gridPaint2, gridPaint2) ||
                other.gridPaint2 == gridPaint2));
  }

  @override
  int get hashCode => Object.hash(runtimeType, canvas, size, graphMinMax,
      backgroundPaint, borderPaint, gridPaint, gridPaint2);

  @override
  String toString() {
    return 'PaintInfo(canvas: $canvas, size: $size, graphMinMax: $graphMinMax, backgroundPaint: $backgroundPaint, borderPaint: $borderPaint, gridPaint: $gridPaint, gridPaint2: $gridPaint2)';
  }
}

/// @nodoc
abstract mixin class _$PaintInfoCopyWith<$Res>
    implements $PaintInfoCopyWith<$Res> {
  factory _$PaintInfoCopyWith(
          _PaintInfo value, $Res Function(_PaintInfo) _then) =
      __$PaintInfoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Canvas canvas,
      Size size,
      DoubleMinMax graphMinMax,
      Paint backgroundPaint,
      Paint borderPaint,
      Paint gridPaint,
      Paint gridPaint2});
}

/// @nodoc
class __$PaintInfoCopyWithImpl<$Res> implements _$PaintInfoCopyWith<$Res> {
  __$PaintInfoCopyWithImpl(this._self, this._then);

  final _PaintInfo _self;
  final $Res Function(_PaintInfo) _then;

  /// Create a copy of PaintInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? canvas = null,
    Object? size = null,
    Object? graphMinMax = null,
    Object? backgroundPaint = null,
    Object? borderPaint = null,
    Object? gridPaint = null,
    Object? gridPaint2 = null,
  }) {
    return _then(_PaintInfo(
      canvas: null == canvas
          ? _self.canvas
          : canvas // ignore: cast_nullable_to_non_nullable
              as Canvas,
      size: null == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as Size,
      graphMinMax: null == graphMinMax
          ? _self.graphMinMax
          : graphMinMax // ignore: cast_nullable_to_non_nullable
              as DoubleMinMax,
      backgroundPaint: null == backgroundPaint
          ? _self.backgroundPaint
          : backgroundPaint // ignore: cast_nullable_to_non_nullable
              as Paint,
      borderPaint: null == borderPaint
          ? _self.borderPaint
          : borderPaint // ignore: cast_nullable_to_non_nullable
              as Paint,
      gridPaint: null == gridPaint
          ? _self.gridPaint
          : gridPaint // ignore: cast_nullable_to_non_nullable
              as Paint,
      gridPaint2: null == gridPaint2
          ? _self.gridPaint2
          : gridPaint2 // ignore: cast_nullable_to_non_nullable
              as Paint,
    ));
  }
}

// dart format on
