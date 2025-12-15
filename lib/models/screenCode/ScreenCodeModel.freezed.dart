// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ScreenCodeModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ScreenCodeModel _$ScreenCodeModelFromJson(Map<String, dynamic> json) {
  return _ScreenCodeModel.fromJson(json);
}

/// @nodoc
mixin _$ScreenCodeModel {
  int get id => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScreenCodeModelCopyWith<ScreenCodeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScreenCodeModelCopyWith<$Res> {
  factory $ScreenCodeModelCopyWith(
          ScreenCodeModel value, $Res Function(ScreenCodeModel) then) =
      _$ScreenCodeModelCopyWithImpl<$Res, ScreenCodeModel>;
  @useResult
  $Res call({int id, String code, String name});
}

/// @nodoc
class _$ScreenCodeModelCopyWithImpl<$Res, $Val extends ScreenCodeModel>
    implements $ScreenCodeModelCopyWith<$Res> {
  _$ScreenCodeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScreenCodeModelImplCopyWith<$Res>
    implements $ScreenCodeModelCopyWith<$Res> {
  factory _$$ScreenCodeModelImplCopyWith(_$ScreenCodeModelImpl value,
          $Res Function(_$ScreenCodeModelImpl) then) =
      __$$ScreenCodeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String code, String name});
}

/// @nodoc
class __$$ScreenCodeModelImplCopyWithImpl<$Res>
    extends _$ScreenCodeModelCopyWithImpl<$Res, _$ScreenCodeModelImpl>
    implements _$$ScreenCodeModelImplCopyWith<$Res> {
  __$$ScreenCodeModelImplCopyWithImpl(
      _$ScreenCodeModelImpl _value, $Res Function(_$ScreenCodeModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? name = null,
  }) {
    return _then(_$ScreenCodeModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScreenCodeModelImpl implements _ScreenCodeModel {
  _$ScreenCodeModelImpl(
      {required this.id, required this.code, required this.name});

  factory _$ScreenCodeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScreenCodeModelImplFromJson(json);

  @override
  final int id;
  @override
  final String code;
  @override
  final String name;

  @override
  String toString() {
    return 'ScreenCodeModel(id: $id, code: $code, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScreenCodeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, code, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScreenCodeModelImplCopyWith<_$ScreenCodeModelImpl> get copyWith =>
      __$$ScreenCodeModelImplCopyWithImpl<_$ScreenCodeModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScreenCodeModelImplToJson(
      this,
    );
  }
}

abstract class _ScreenCodeModel implements ScreenCodeModel {
  factory _ScreenCodeModel(
      {required final int id,
      required final String code,
      required final String name}) = _$ScreenCodeModelImpl;

  factory _ScreenCodeModel.fromJson(Map<String, dynamic> json) =
      _$ScreenCodeModelImpl.fromJson;

  @override
  int get id;
  @override
  String get code;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$ScreenCodeModelImplCopyWith<_$ScreenCodeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
