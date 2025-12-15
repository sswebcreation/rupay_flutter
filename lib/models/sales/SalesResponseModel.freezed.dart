// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'SalesResponseModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SalesResponseModel _$SalesResponseModelFromJson(Map<String, dynamic> json) {
  return _SalesResponseModel.fromJson(json);
}

/// @nodoc
mixin _$SalesResponseModel {
  String get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  SalesModel? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SalesResponseModelCopyWith<SalesResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesResponseModelCopyWith<$Res> {
  factory $SalesResponseModelCopyWith(
          SalesResponseModel value, $Res Function(SalesResponseModel) then) =
      _$SalesResponseModelCopyWithImpl<$Res, SalesResponseModel>;
  @useResult
  $Res call({String status, int code, String message, SalesModel? data});

  $SalesModelCopyWith<$Res>? get data;
}

/// @nodoc
class _$SalesResponseModelCopyWithImpl<$Res, $Val extends SalesResponseModel>
    implements $SalesResponseModelCopyWith<$Res> {
  _$SalesResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as SalesModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SalesModelCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $SalesModelCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SalesResponseModelImplCopyWith<$Res>
    implements $SalesResponseModelCopyWith<$Res> {
  factory _$$SalesResponseModelImplCopyWith(_$SalesResponseModelImpl value,
          $Res Function(_$SalesResponseModelImpl) then) =
      __$$SalesResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, int code, String message, SalesModel? data});

  @override
  $SalesModelCopyWith<$Res>? get data;
}

/// @nodoc
class __$$SalesResponseModelImplCopyWithImpl<$Res>
    extends _$SalesResponseModelCopyWithImpl<$Res, _$SalesResponseModelImpl>
    implements _$$SalesResponseModelImplCopyWith<$Res> {
  __$$SalesResponseModelImplCopyWithImpl(_$SalesResponseModelImpl _value,
      $Res Function(_$SalesResponseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$SalesResponseModelImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as SalesModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SalesResponseModelImpl implements _SalesResponseModel {
  _$SalesResponseModelImpl(
      {required this.status,
      required this.code,
      required this.message,
      this.data});

  factory _$SalesResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SalesResponseModelImplFromJson(json);

  @override
  final String status;
  @override
  final int code;
  @override
  final String message;
  @override
  final SalesModel? data;

  @override
  String toString() {
    return 'SalesResponseModel(status: $status, code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesResponseModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, code, message, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SalesResponseModelImplCopyWith<_$SalesResponseModelImpl> get copyWith =>
      __$$SalesResponseModelImplCopyWithImpl<_$SalesResponseModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SalesResponseModelImplToJson(
      this,
    );
  }
}

abstract class _SalesResponseModel implements SalesResponseModel {
  factory _SalesResponseModel(
      {required final String status,
      required final int code,
      required final String message,
      final SalesModel? data}) = _$SalesResponseModelImpl;

  factory _SalesResponseModel.fromJson(Map<String, dynamic> json) =
      _$SalesResponseModelImpl.fromJson;

  @override
  String get status;
  @override
  int get code;
  @override
  String get message;
  @override
  SalesModel? get data;
  @override
  @JsonKey(ignore: true)
  _$$SalesResponseModelImplCopyWith<_$SalesResponseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
