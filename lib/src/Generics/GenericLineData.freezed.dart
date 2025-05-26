// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'GenericLineData.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GenericLineData<TX, TY> {
  String get label;
  KtList<GenericPoint<TX, TY>> get points;

  /// Create a copy of GenericLineData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GenericLineDataCopyWith<TX, TY, GenericLineData<TX, TY>> get copyWith =>
      _$GenericLineDataCopyWithImpl<TX, TY, GenericLineData<TX, TY>>(
          this as GenericLineData<TX, TY>, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GenericLineData<TX, TY> &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.points, points) || other.points == points));
  }

  @override
  int get hashCode => Object.hash(runtimeType, label, points);

  @override
  String toString() {
    return 'GenericLineData<$TX, $TY>(label: $label, points: $points)';
  }
}

/// @nodoc
abstract mixin class $GenericLineDataCopyWith<TX, TY, $Res> {
  factory $GenericLineDataCopyWith(GenericLineData<TX, TY> value,
          $Res Function(GenericLineData<TX, TY>) _then) =
      _$GenericLineDataCopyWithImpl;
  @useResult
  $Res call({String label, KtList<GenericPoint<TX, TY>> points});
}

/// @nodoc
class _$GenericLineDataCopyWithImpl<TX, TY, $Res>
    implements $GenericLineDataCopyWith<TX, TY, $Res> {
  _$GenericLineDataCopyWithImpl(this._self, this._then);

  final GenericLineData<TX, TY> _self;
  final $Res Function(GenericLineData<TX, TY>) _then;

  /// Create a copy of GenericLineData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? points = null,
  }) {
    return _then(GenericLineData(
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
