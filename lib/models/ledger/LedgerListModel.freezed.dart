// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'LedgerListModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LedgerListModel _$LedgerListModelFromJson(Map<String, dynamic> json) {
  return _LedgerListModel.fromJson(json);
}

/// @nodoc
mixin _$LedgerListModel {
  String get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<LedgerModel>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LedgerListModelCopyWith<LedgerListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerListModelCopyWith<$Res> {
  factory $LedgerListModelCopyWith(
          LedgerListModel value, $Res Function(LedgerListModel) then) =
      _$LedgerListModelCopyWithImpl<$Res, LedgerListModel>;
  @useResult
  $Res call({String status, int code, String message, List<LedgerModel>? data});
}

/// @nodoc
class _$LedgerListModelCopyWithImpl<$Res, $Val extends LedgerListModel>
    implements $LedgerListModelCopyWith<$Res> {
  _$LedgerListModelCopyWithImpl(this._value, this._then);

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
              as List<LedgerModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LedgerListModelImplCopyWith<$Res>
    implements $LedgerListModelCopyWith<$Res> {
  factory _$$LedgerListModelImplCopyWith(_$LedgerListModelImpl value,
          $Res Function(_$LedgerListModelImpl) then) =
      __$$LedgerListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, int code, String message, List<LedgerModel>? data});
}

/// @nodoc
class __$$LedgerListModelImplCopyWithImpl<$Res>
    extends _$LedgerListModelCopyWithImpl<$Res, _$LedgerListModelImpl>
    implements _$$LedgerListModelImplCopyWith<$Res> {
  __$$LedgerListModelImplCopyWithImpl(
      _$LedgerListModelImpl _value, $Res Function(_$LedgerListModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$LedgerListModelImpl(
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
              as List<LedgerModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LedgerListModelImpl implements _LedgerListModel {
  _$LedgerListModelImpl(
      {required this.status,
      required this.code,
      required this.message,
      final List<LedgerModel>? data})
      : _data = data;

  factory _$LedgerListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LedgerListModelImplFromJson(json);

  @override
  final String status;
  @override
  final int code;
  @override
  final String message;
  final List<LedgerModel>? _data;
  @override
  List<LedgerModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'LedgerListModel(status: $status, code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LedgerListModelImpl &&
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
  _$$LedgerListModelImplCopyWith<_$LedgerListModelImpl> get copyWith =>
      __$$LedgerListModelImplCopyWithImpl<_$LedgerListModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LedgerListModelImplToJson(
      this,
    );
  }
}

abstract class _LedgerListModel implements LedgerListModel {
  factory _LedgerListModel(
      {required final String status,
      required final int code,
      required final String message,
      final List<LedgerModel>? data}) = _$LedgerListModelImpl;

  factory _LedgerListModel.fromJson(Map<String, dynamic> json) =
      _$LedgerListModelImpl.fromJson;

  @override
  String get status;
  @override
  int get code;
  @override
  String get message;
  @override
  List<LedgerModel>? get data;
  @override
  @JsonKey(ignore: true)
  _$$LedgerListModelImplCopyWith<_$LedgerListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
