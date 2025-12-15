// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'CashListModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CashListModel _$CashListModelFromJson(Map<String, dynamic> json) {
  return _CashListModel.fromJson(json);
}

/// @nodoc
mixin _$CashListModel {
  String get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<CashModel>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CashListModelCopyWith<CashListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CashListModelCopyWith<$Res> {
  factory $CashListModelCopyWith(
          CashListModel value, $Res Function(CashListModel) then) =
      _$CashListModelCopyWithImpl<$Res, CashListModel>;
  @useResult
  $Res call({String status, int code, String message, List<CashModel>? data});
}

/// @nodoc
class _$CashListModelCopyWithImpl<$Res, $Val extends CashListModel>
    implements $CashListModelCopyWith<$Res> {
  _$CashListModelCopyWithImpl(this._value, this._then);

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
              as List<CashModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CashListModelImplCopyWith<$Res>
    implements $CashListModelCopyWith<$Res> {
  factory _$$CashListModelImplCopyWith(
          _$CashListModelImpl value, $Res Function(_$CashListModelImpl) then) =
      __$$CashListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, int code, String message, List<CashModel>? data});
}

/// @nodoc
class __$$CashListModelImplCopyWithImpl<$Res>
    extends _$CashListModelCopyWithImpl<$Res, _$CashListModelImpl>
    implements _$$CashListModelImplCopyWith<$Res> {
  __$$CashListModelImplCopyWithImpl(
      _$CashListModelImpl _value, $Res Function(_$CashListModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$CashListModelImpl(
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
              as List<CashModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CashListModelImpl implements _CashListModel {
  _$CashListModelImpl(
      {required this.status,
      required this.code,
      required this.message,
      final List<CashModel>? data})
      : _data = data;

  factory _$CashListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CashListModelImplFromJson(json);

  @override
  final String status;
  @override
  final int code;
  @override
  final String message;
  final List<CashModel>? _data;
  @override
  List<CashModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CashListModel(status: $status, code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CashListModelImpl &&
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
  _$$CashListModelImplCopyWith<_$CashListModelImpl> get copyWith =>
      __$$CashListModelImplCopyWithImpl<_$CashListModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CashListModelImplToJson(
      this,
    );
  }
}

abstract class _CashListModel implements CashListModel {
  factory _CashListModel(
      {required final String status,
      required final int code,
      required final String message,
      final List<CashModel>? data}) = _$CashListModelImpl;

  factory _CashListModel.fromJson(Map<String, dynamic> json) =
      _$CashListModelImpl.fromJson;

  @override
  String get status;
  @override
  int get code;
  @override
  String get message;
  @override
  List<CashModel>? get data;
  @override
  @JsonKey(ignore: true)
  _$$CashListModelImplCopyWith<_$CashListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
