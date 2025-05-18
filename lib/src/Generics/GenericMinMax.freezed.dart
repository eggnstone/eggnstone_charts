// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'GenericMinMax.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GenericMinMax<TX, TY> {
  TX get minX;
  TX get maxX;
  TY get minY;
  TY get maxY;

  /// Create a copy of GenericMinMax
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GenericMinMaxCopyWith<TX, TY, GenericMinMax<TX, TY>> get copyWith =>
      _$GenericMinMaxCopyWithImpl<TX, TY, GenericMinMax<TX, TY>>(
          this as GenericMinMax<TX, TY>, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GenericMinMax<TX, TY> &&
            const DeepCollectionEquality().equals(other.minX, minX) &&
            const DeepCollectionEquality().equals(other.maxX, maxX) &&
            const DeepCollectionEquality().equals(other.minY, minY) &&
            const DeepCollectionEquality().equals(other.maxY, maxY));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(minX),
      const DeepCollectionEquality().hash(maxX),
      const DeepCollectionEquality().hash(minY),
      const DeepCollectionEquality().hash(maxY));
}

/// @nodoc
abstract mixin class $GenericMinMaxCopyWith<TX, TY, $Res> {
  factory $GenericMinMaxCopyWith(GenericMinMax<TX, TY> value,
      $Res Function(GenericMinMax<TX, TY>) _then) = _$GenericMinMaxCopyWithImpl;
  @useResult
  $Res call({TX minX, TX maxX, TY minY, TY maxY});
}

/// @nodoc
class _$GenericMinMaxCopyWithImpl<TX, TY, $Res>
    implements $GenericMinMaxCopyWith<TX, TY, $Res> {
  _$GenericMinMaxCopyWithImpl(this._self, this._then);

  final GenericMinMax<TX, TY> _self;
  final $Res Function(GenericMinMax<TX, TY>) _then;

  /// Create a copy of GenericMinMax
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minX = freezed,
    Object? maxX = freezed,
    Object? minY = freezed,
    Object? maxY = freezed,
  }) {
    return _then(GenericMinMax(
      minX: freezed == minX
          ? _self.minX
          : minX // ignore: cast_nullable_to_non_nullable
              as TX,
      maxX: freezed == maxX
          ? _self.maxX
          : maxX // ignore: cast_nullable_to_non_nullable
              as TX,
      minY: freezed == minY
          ? _self.minY
          : minY // ignore: cast_nullable_to_non_nullable
              as TY,
      maxY: freezed == maxY
          ? _self.maxY
          : maxY // ignore: cast_nullable_to_non_nullable
              as TY,
    ));
  }
}

// dart format on
