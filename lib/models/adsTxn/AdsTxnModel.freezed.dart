// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'AdsTxnModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdsTxnModel _$AdsTxnModelFromJson(Map<String, dynamic> json) {
  return _AdsTxnModel.fromJson(json);
}

/// @nodoc
mixin _$AdsTxnModel {
  int get id => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  int get cus_id => throw _privateConstructorUsedError;
  int? get cat_id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AdsTxnModelCopyWith<AdsTxnModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdsTxnModelCopyWith<$Res> {
  factory $AdsTxnModelCopyWith(
          AdsTxnModel value, $Res Function(AdsTxnModel) then) =
      _$AdsTxnModelCopyWithImpl<$Res, AdsTxnModel>;
  @useResult
  $Res call({int id, String image, int cus_id, int? cat_id});
}

/// @nodoc
class _$AdsTxnModelCopyWithImpl<$Res, $Val extends AdsTxnModel>
    implements $AdsTxnModelCopyWith<$Res> {
  _$AdsTxnModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? image = null,
    Object? cus_id = null,
    Object? cat_id = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      cus_id: null == cus_id
          ? _value.cus_id
          : cus_id // ignore: cast_nullable_to_non_nullable
              as int,
      cat_id: freezed == cat_id
          ? _value.cat_id
          : cat_id // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdsTxnModelImplCopyWith<$Res>
    implements $AdsTxnModelCopyWith<$Res> {
  factory _$$AdsTxnModelImplCopyWith(
          _$AdsTxnModelImpl value, $Res Function(_$AdsTxnModelImpl) then) =
      __$$AdsTxnModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String image, int cus_id, int? cat_id});
}

/// @nodoc
class __$$AdsTxnModelImplCopyWithImpl<$Res>
    extends _$AdsTxnModelCopyWithImpl<$Res, _$AdsTxnModelImpl>
    implements _$$AdsTxnModelImplCopyWith<$Res> {
  __$$AdsTxnModelImplCopyWithImpl(
      _$AdsTxnModelImpl _value, $Res Function(_$AdsTxnModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? image = null,
    Object? cus_id = null,
    Object? cat_id = freezed,
  }) {
    return _then(_$AdsTxnModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      cus_id: null == cus_id
          ? _value.cus_id
          : cus_id // ignore: cast_nullable_to_non_nullable
              as int,
      cat_id: freezed == cat_id
          ? _value.cat_id
          : cat_id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdsTxnModelImpl implements _AdsTxnModel {
  _$AdsTxnModelImpl(
      {required this.id,
      required this.image,
      required this.cus_id,
      this.cat_id});

  factory _$AdsTxnModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdsTxnModelImplFromJson(json);

  @override
  final int id;
  @override
  final String image;
  @override
  final int cus_id;
  @override
  final int? cat_id;

  @override
  String toString() {
    return 'AdsTxnModel(id: $id, image: $image, cus_id: $cus_id, cat_id: $cat_id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdsTxnModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.cus_id, cus_id) || other.cus_id == cus_id) &&
            (identical(other.cat_id, cat_id) || other.cat_id == cat_id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, image, cus_id, cat_id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AdsTxnModelImplCopyWith<_$AdsTxnModelImpl> get copyWith =>
      __$$AdsTxnModelImplCopyWithImpl<_$AdsTxnModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdsTxnModelImplToJson(
      this,
    );
  }
}

abstract class _AdsTxnModel implements AdsTxnModel {
  factory _AdsTxnModel(
      {required final int id,
      required final String image,
      required final int cus_id,
      final int? cat_id}) = _$AdsTxnModelImpl;

  factory _AdsTxnModel.fromJson(Map<String, dynamic> json) =
      _$AdsTxnModelImpl.fromJson;

  @override
  int get id;
  @override
  String get image;
  @override
  int get cus_id;
  @override
  int? get cat_id;
  @override
  @JsonKey(ignore: true)
  _$$AdsTxnModelImplCopyWith<_$AdsTxnModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
