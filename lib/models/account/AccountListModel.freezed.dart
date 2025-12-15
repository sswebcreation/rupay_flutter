// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'AccountListModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AccountListModel _$AccountListModelFromJson(Map<String, dynamic> json) {
  return _AccountListModel.fromJson(json);
}

/// @nodoc
mixin _$AccountListModel {
  String get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<AccountModel>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AccountListModelCopyWith<AccountListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountListModelCopyWith<$Res> {
  factory $AccountListModelCopyWith(
          AccountListModel value, $Res Function(AccountListModel) then) =
      _$AccountListModelCopyWithImpl<$Res, AccountListModel>;
  @useResult
  $Res call(
      {String status, int code, String message, List<AccountModel>? data});
}

/// @nodoc
class _$AccountListModelCopyWithImpl<$Res, $Val extends AccountListModel>
    implements $AccountListModelCopyWith<$Res> {
  _$AccountListModelCopyWithImpl(this._value, this._then);

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
              as List<AccountModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccountListModelImplCopyWith<$Res>
    implements $AccountListModelCopyWith<$Res> {
  factory _$$AccountListModelImplCopyWith(_$AccountListModelImpl value,
          $Res Function(_$AccountListModelImpl) then) =
      __$$AccountListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String status, int code, String message, List<AccountModel>? data});
}

/// @nodoc
class __$$AccountListModelImplCopyWithImpl<$Res>
    extends _$AccountListModelCopyWithImpl<$Res, _$AccountListModelImpl>
    implements _$$AccountListModelImplCopyWith<$Res> {
  __$$AccountListModelImplCopyWithImpl(_$AccountListModelImpl _value,
      $Res Function(_$AccountListModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$AccountListModelImpl(
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
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<AccountModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AccountListModelImpl implements _AccountListModel {
  _$AccountListModelImpl(
      {required this.status,
      required this.code,
      required this.message,
      final List<AccountModel>? data})
      : _data = data;

  factory _$AccountListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccountListModelImplFromJson(json);

  @override
  final String status;
  @override
  final int code;
  @override
  final String message;
  final List<AccountModel>? _data;
  @override
  List<AccountModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'AccountListModel(status: $status, code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountListModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, code, message,
      const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountListModelImplCopyWith<_$AccountListModelImpl> get copyWith =>
      __$$AccountListModelImplCopyWithImpl<_$AccountListModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AccountListModelImplToJson(
      this,
    );
  }
}

abstract class _AccountListModel implements AccountListModel {
  factory _AccountListModel(
      {required final String status,
      required final int code,
      required final String message,
      final List<AccountModel>? data}) = _$AccountListModelImpl;

  factory _AccountListModel.fromJson(Map<String, dynamic> json) =
      _$AccountListModelImpl.fromJson;

  @override
  String get status;
  @override
  int get code;
  @override
  String get message;
  @override
  List<AccountModel>? get data;
  @override
  @JsonKey(ignore: true)
  _$$AccountListModelImplCopyWith<_$AccountListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
