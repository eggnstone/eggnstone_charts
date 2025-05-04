// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'GenericChartData.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GenericChartData<TX, TY> {
  KtList<Color> get colors;
  KtList<GenericLineData<TX, TY>> get lines;
  GenericTools<TX> get toolsX;
  GenericTools<TY> get toolsY;
  GenericMinMax<TX, TY> get minMax;

  /// Create a copy of GenericChartData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GenericChartDataCopyWith<TX, TY, GenericChartData<TX, TY>> get copyWith =>
      _$GenericChartDataCopyWithImpl<TX, TY, GenericChartData<TX, TY>>(
          this as GenericChartData<TX, TY>, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GenericChartData<TX, TY> &&
            (identical(other.colors, colors) || other.colors == colors) &&
            (identical(other.lines, lines) || other.lines == lines) &&
            (identical(other.toolsX, toolsX) || other.toolsX == toolsX) &&
            (identical(other.toolsY, toolsY) || other.toolsY == toolsY) &&
            (identical(other.minMax, minMax) || other.minMax == minMax));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, colors, lines, toolsX, toolsY, minMax);

  @override
  String toString() {
    return 'GenericChartData<$TX, $TY>(colors: $colors, lines: $lines, toolsX: $toolsX, toolsY: $toolsY, minMax: $minMax)';
  }
}

/// @nodoc
abstract mixin class $GenericChartDataCopyWith<TX, TY, $Res> {
  factory $GenericChartDataCopyWith(GenericChartData<TX, TY> value,
          $Res Function(GenericChartData<TX, TY>) _then) =
      _$GenericChartDataCopyWithImpl;
  @useResult
  $Res call(
      {KtList<Color> colors,
      KtList<GenericLineData<TX, TY>> lines,
      GenericTools<TX> toolsX,
      GenericTools<TY> toolsY,
      GenericMinMax<TX, TY> minMax});
}

/// @nodoc
class _$GenericChartDataCopyWithImpl<TX, TY, $Res>
    implements $GenericChartDataCopyWith<TX, TY, $Res> {
  _$GenericChartDataCopyWithImpl(this._self, this._then);

  final GenericChartData<TX, TY> _self;
  final $Res Function(GenericChartData<TX, TY>) _then;

  /// Create a copy of GenericChartData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? colors = null,
    Object? lines = null,
    Object? toolsX = null,
    Object? toolsY = null,
    Object? minMax = null,
  }) {
    return _then(GenericChartData(
      colors: null == colors
          ? _self.colors
          : colors // ignore: cast_nullable_to_non_nullable
              as KtList<Color>,
      lines: null == lines
          ? _self.lines
          : lines // ignore: cast_nullable_to_non_nullable
              as KtList<GenericLineData<TX, TY>>,
      toolsX: null == toolsX
          ? _self.toolsX
          : toolsX // ignore: cast_nullable_to_non_nullable
              as GenericTools<TX>,
      toolsY: null == toolsY
          ? _self.toolsY
          : toolsY // ignore: cast_nullable_to_non_nullable
              as GenericTools<TY>,
      minMax: null == minMax
          ? _self.minMax
          : minMax // ignore: cast_nullable_to_non_nullable
              as GenericMinMax<TX, TY>,
    ));
  }
}

// dart format on
