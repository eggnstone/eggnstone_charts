// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ClosestLineInfo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClosestLineInfo {
  ClosestPointInfo get closestPoint;
  int get lineIndex;

  /// Create a copy of ClosestLineInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ClosestLineInfoCopyWith<ClosestLineInfo> get copyWith =>
      _$ClosestLineInfoCopyWithImpl<ClosestLineInfo>(
          this as ClosestLineInfo, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ClosestLineInfo &&
            (identical(other.closestPoint, closestPoint) ||
                other.closestPoint == closestPoint) &&
            (identical(other.lineIndex, lineIndex) ||
                other.lineIndex == lineIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, closestPoint, lineIndex);

  @override
  String toString() {
    return 'ClosestLineInfo(closestPoint: $closestPoint, lineIndex: $lineIndex)';
  }
}

/// @nodoc
abstract mixin class $ClosestLineInfoCopyWith<$Res> {
  factory $ClosestLineInfoCopyWith(
          ClosestLineInfo value, $Res Function(ClosestLineInfo) _then) =
      _$ClosestLineInfoCopyWithImpl;
  @useResult
  $Res call({ClosestPointInfo closestPoint, int lineIndex});

  $ClosestPointInfoCopyWith<$Res> get closestPoint;
}

/// @nodoc
class _$ClosestLineInfoCopyWithImpl<$Res>
    implements $ClosestLineInfoCopyWith<$Res> {
  _$ClosestLineInfoCopyWithImpl(this._self, this._then);

  final ClosestLineInfo _self;
  final $Res Function(ClosestLineInfo) _then;

  /// Create a copy of ClosestLineInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? closestPoint = null,
    Object? lineIndex = null,
  }) {
    return _then(_self.copyWith(
      closestPoint: null == closestPoint
          ? _self.closestPoint
          : closestPoint // ignore: cast_nullable_to_non_nullable
              as ClosestPointInfo,
      lineIndex: null == lineIndex
          ? _self.lineIndex
          : lineIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of ClosestLineInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClosestPointInfoCopyWith<$Res> get closestPoint {
    return $ClosestPointInfoCopyWith<$Res>(_self.closestPoint, (value) {
      return _then(_self.copyWith(closestPoint: value));
    });
  }
}

/// @nodoc

class _ClosestLineInfo implements ClosestLineInfo {
  const _ClosestLineInfo({required this.closestPoint, required this.lineIndex});

  @override
  final ClosestPointInfo closestPoint;
  @override
  final int lineIndex;

  /// Create a copy of ClosestLineInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ClosestLineInfoCopyWith<_ClosestLineInfo> get copyWith =>
      __$ClosestLineInfoCopyWithImpl<_ClosestLineInfo>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ClosestLineInfo &&
            (identical(other.closestPoint, closestPoint) ||
                other.closestPoint == closestPoint) &&
            (identical(other.lineIndex, lineIndex) ||
                other.lineIndex == lineIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, closestPoint, lineIndex);

  @override
  String toString() {
    return 'ClosestLineInfo(closestPoint: $closestPoint, lineIndex: $lineIndex)';
  }
}

/// @nodoc
abstract mixin class _$ClosestLineInfoCopyWith<$Res>
    implements $ClosestLineInfoCopyWith<$Res> {
  factory _$ClosestLineInfoCopyWith(
          _ClosestLineInfo value, $Res Function(_ClosestLineInfo) _then) =
      __$ClosestLineInfoCopyWithImpl;
  @override
  @useResult
  $Res call({ClosestPointInfo closestPoint, int lineIndex});

  @override
  $ClosestPointInfoCopyWith<$Res> get closestPoint;
}

/// @nodoc
class __$ClosestLineInfoCopyWithImpl<$Res>
    implements _$ClosestLineInfoCopyWith<$Res> {
  __$ClosestLineInfoCopyWithImpl(this._self, this._then);

  final _ClosestLineInfo _self;
  final $Res Function(_ClosestLineInfo) _then;

  /// Create a copy of ClosestLineInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? closestPoint = null,
    Object? lineIndex = null,
  }) {
    return _then(_ClosestLineInfo(
      closestPoint: null == closestPoint
          ? _self.closestPoint
          : closestPoint // ignore: cast_nullable_to_non_nullable
              as ClosestPointInfo,
      lineIndex: null == lineIndex
          ? _self.lineIndex
          : lineIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of ClosestLineInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClosestPointInfoCopyWith<$Res> get closestPoint {
    return $ClosestPointInfoCopyWith<$Res>(_self.closestPoint, (value) {
      return _then(_self.copyWith(closestPoint: value));
    });
  }
}

// dart format on
