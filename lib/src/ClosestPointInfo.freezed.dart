// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ClosestPointInfo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClosestPointInfo {
  Offset get distance;
  int get pointIndex;
  Offset get position;

  /// Create a copy of ClosestPointInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ClosestPointInfoCopyWith<ClosestPointInfo> get copyWith =>
      _$ClosestPointInfoCopyWithImpl<ClosestPointInfo>(
          this as ClosestPointInfo, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ClosestPointInfo &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.pointIndex, pointIndex) ||
                other.pointIndex == pointIndex) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @override
  int get hashCode => Object.hash(runtimeType, distance, pointIndex, position);

  @override
  String toString() {
    return 'ClosestPointInfo(distance: $distance, pointIndex: $pointIndex, position: $position)';
  }
}

/// @nodoc
abstract mixin class $ClosestPointInfoCopyWith<$Res> {
  factory $ClosestPointInfoCopyWith(
          ClosestPointInfo value, $Res Function(ClosestPointInfo) _then) =
      _$ClosestPointInfoCopyWithImpl;
  @useResult
  $Res call({Offset distance, int pointIndex, Offset position});
}

/// @nodoc
class _$ClosestPointInfoCopyWithImpl<$Res>
    implements $ClosestPointInfoCopyWith<$Res> {
  _$ClosestPointInfoCopyWithImpl(this._self, this._then);

  final ClosestPointInfo _self;
  final $Res Function(ClosestPointInfo) _then;

  /// Create a copy of ClosestPointInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? distance = null,
    Object? pointIndex = null,
    Object? position = null,
  }) {
    return _then(_self.copyWith(
      distance: null == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as Offset,
      pointIndex: null == pointIndex
          ? _self.pointIndex
          : pointIndex // ignore: cast_nullable_to_non_nullable
              as int,
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as Offset,
    ));
  }
}

/// @nodoc

class _ClosestPointInfo implements ClosestPointInfo {
  const _ClosestPointInfo(
      {required this.distance,
      required this.pointIndex,
      required this.position});

  @override
  final Offset distance;
  @override
  final int pointIndex;
  @override
  final Offset position;

  /// Create a copy of ClosestPointInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ClosestPointInfoCopyWith<_ClosestPointInfo> get copyWith =>
      __$ClosestPointInfoCopyWithImpl<_ClosestPointInfo>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ClosestPointInfo &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.pointIndex, pointIndex) ||
                other.pointIndex == pointIndex) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @override
  int get hashCode => Object.hash(runtimeType, distance, pointIndex, position);

  @override
  String toString() {
    return 'ClosestPointInfo(distance: $distance, pointIndex: $pointIndex, position: $position)';
  }
}

/// @nodoc
abstract mixin class _$ClosestPointInfoCopyWith<$Res>
    implements $ClosestPointInfoCopyWith<$Res> {
  factory _$ClosestPointInfoCopyWith(
          _ClosestPointInfo value, $Res Function(_ClosestPointInfo) _then) =
      __$ClosestPointInfoCopyWithImpl;
  @override
  @useResult
  $Res call({Offset distance, int pointIndex, Offset position});
}

/// @nodoc
class __$ClosestPointInfoCopyWithImpl<$Res>
    implements _$ClosestPointInfoCopyWith<$Res> {
  __$ClosestPointInfoCopyWithImpl(this._self, this._then);

  final _ClosestPointInfo _self;
  final $Res Function(_ClosestPointInfo) _then;

  /// Create a copy of ClosestPointInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? distance = null,
    Object? pointIndex = null,
    Object? position = null,
  }) {
    return _then(_ClosestPointInfo(
      distance: null == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as Offset,
      pointIndex: null == pointIndex
          ? _self.pointIndex
          : pointIndex // ignore: cast_nullable_to_non_nullable
              as int,
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as Offset,
    ));
  }
}

// dart format on
