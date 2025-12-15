// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'VoucherListModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VoucherListModel _$VoucherListModelFromJson(Map<String, dynamic> json) {
  return _VoucherListModel.fromJson(json);
}

/// @nodoc
mixin _$VoucherListModel {
  String get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<VoucherModel>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VoucherListModelCopyWith<VoucherListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoucherListModelCopyWith<$Res> {
  factory $VoucherListModelCopyWith(
          VoucherListModel value, $Res Function(VoucherListModel) then) =
      _$VoucherListModelCopyWithImpl<$Res, VoucherListModel>;
  @useResult
  $Res call(
      {String status, int code, String message, List<VoucherModel>? data});
}

/// @nodoc
class _$VoucherListModelCopyWithImpl<$Res, $Val extends VoucherListModel>
    implements $VoucherListModelCopyWith<$Res> {
  _$VoucherListModelCopyWithImpl(this._value, this._then);

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
              as List<VoucherModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoucherListModelImplCopyWith<$Res>
    implements $VoucherListModelCopyWith<$Res> {
  factory _$$VoucherListModelImplCopyWith(_$VoucherListModelImpl value,
          $Res Function(_$VoucherListModelImpl) then) =
      __$$VoucherListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String status, int code, String message, List<VoucherModel>? data});
}

/// @nodoc
class __$$VoucherListModelImplCopyWithImpl<$Res>
    extends _$VoucherListModelCopyWithImpl<$Res, _$VoucherListModelImpl>
    implements _$$VoucherListModelImplCopyWith<$Res> {
  __$$VoucherListModelImplCopyWithImpl(_$VoucherListModelImpl _value,
      $Res Function(_$VoucherListModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$VoucherListModelImpl(
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
              as List<VoucherModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VoucherListModelImpl implements _VoucherListModel {
  _$VoucherListModelImpl(
      {required this.status,
      required this.code,
      required this.message,
      final List<VoucherModel>? data})
      : _data = data;

  factory _$VoucherListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoucherListModelImplFromJson(json);

  @override
  final String status;
  @override
  final int code;
  @override
  final String message;
  final List<VoucherModel>? _data;
  @override
  List<VoucherModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'VoucherListModel(status: $status, code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoucherListModelImpl &&
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
  _$$VoucherListModelImplCopyWith<_$VoucherListModelImpl> get copyWith =>
      __$$VoucherListModelImplCopyWithImpl<_$VoucherListModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoucherListModelImplToJson(
      this,
    );
  }
}

abstract class _VoucherListModel implements VoucherListModel {
  factory _VoucherListModel(
      {required final String status,
      required final int code,
      required final String message,
      final List<VoucherModel>? data}) = _$VoucherListModelImpl;

  factory _VoucherListModel.fromJson(Map<String, dynamic> json) =
      _$VoucherListModelImpl.fromJson;

  @override
  String get status;
  @override
  int get code;
  @override
  String get message;
  @override
  List<VoucherModel>? get data;
  @override
  @JsonKey(ignore: true)
  _$$VoucherListModelImplCopyWith<_$VoucherListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
