// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'GenericDataSeries.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GenericDataSeries<TX, TY> {
  Color get color;
  String get label;
  KtList<GenericPoint<TX, TY>> get points;

  /// Create a copy of GenericDataSeries
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GenericDataSeriesCopyWith<TX, TY, GenericDataSeries<TX, TY>> get copyWith =>
      _$GenericDataSeriesCopyWithImpl<TX, TY, GenericDataSeries<TX, TY>>(
          this as GenericDataSeries<TX, TY>, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GenericDataSeries<TX, TY> &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.points, points) || other.points == points));
  }

  @override
  int get hashCode => Object.hash(runtimeType, color, label, points);

  @override
  String toString() {
    return 'GenericDataSeries<$TX, $TY>(color: $color, label: $label, points: $points)';
  }
}

/// @nodoc
abstract mixin class $GenericDataSeriesCopyWith<TX, TY, $Res> {
  factory $GenericDataSeriesCopyWith(GenericDataSeries<TX, TY> value,
          $Res Function(GenericDataSeries<TX, TY>) _then) =
      _$GenericDataSeriesCopyWithImpl;
  @useResult
  $Res call({Color color, String label, KtList<GenericPoint<TX, TY>> points});
}

/// @nodoc
class _$GenericDataSeriesCopyWithImpl<TX, TY, $Res>
    implements $GenericDataSeriesCopyWith<TX, TY, $Res> {
  _$GenericDataSeriesCopyWithImpl(this._self, this._then);

  final GenericDataSeries<TX, TY> _self;
  final $Res Function(GenericDataSeries<TX, TY>) _then;

  /// Create a copy of GenericDataSeries
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? color = null,
    Object? label = null,
    Object? points = null,
  }) {
    return _then(GenericDataSeries(
      null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      null == points
          ? _self.points
          : points // ignore: cast_nullable_to_non_nullable
              as KtList<GenericPoint<TX, TY>>,
    ));
  }
}

// dart format on
