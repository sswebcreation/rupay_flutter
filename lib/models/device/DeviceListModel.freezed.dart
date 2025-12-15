// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'DeviceListModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DeviceListModel _$DeviceListModelFromJson(Map<String, dynamic> json) {
  return _DeviceListModel.fromJson(json);
}

/// @nodoc
mixin _$DeviceListModel {
  String get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<DeviceModel>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeviceListModelCopyWith<DeviceListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceListModelCopyWith<$Res> {
  factory $DeviceListModelCopyWith(
          DeviceListModel value, $Res Function(DeviceListModel) then) =
      _$DeviceListModelCopyWithImpl<$Res, DeviceListModel>;
  @useResult
  $Res call({String status, int code, String message, List<DeviceModel>? data});
}

/// @nodoc
class _$DeviceListModelCopyWithImpl<$Res, $Val extends DeviceListModel>
    implements $DeviceListModelCopyWith<$Res> {
  _$DeviceListModelCopyWithImpl(this._value, this._then);

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
              as List<DeviceModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeviceListModelImplCopyWith<$Res>
    implements $DeviceListModelCopyWith<$Res> {
  factory _$$DeviceListModelImplCopyWith(_$DeviceListModelImpl value,
          $Res Function(_$DeviceListModelImpl) then) =
      __$$DeviceListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, int code, String message, List<DeviceModel>? data});
}

/// @nodoc
class __$$DeviceListModelImplCopyWithImpl<$Res>
    extends _$DeviceListModelCopyWithImpl<$Res, _$DeviceListModelImpl>
    implements _$$DeviceListModelImplCopyWith<$Res> {
  __$$DeviceListModelImplCopyWithImpl(
      _$DeviceListModelImpl _value, $Res Function(_$DeviceListModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$DeviceListModelImpl(
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
              as List<DeviceModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceListModelImpl implements _DeviceListModel {
  _$DeviceListModelImpl(
      {required this.status,
      required this.code,
      required this.message,
      final List<DeviceModel>? data})
      : _data = data;

  factory _$DeviceListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceListModelImplFromJson(json);

  @override
  final String status;
  @override
  final int code;
  @override
  final String message;
  final List<DeviceModel>? _data;
  @override
  List<DeviceModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'DeviceListModel(status: $status, code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceListModelImpl &&
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
  _$$DeviceListModelImplCopyWith<_$DeviceListModelImpl> get copyWith =>
      __$$DeviceListModelImplCopyWithImpl<_$DeviceListModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceListModelImplToJson(
      this,
    );
  }
}

abstract class _DeviceListModel implements DeviceListModel {
  factory _DeviceListModel(
      {required final String status,
      required final int code,
      required final String message,
      final List<DeviceModel>? data}) = _$DeviceListModelImpl;

  factory _DeviceListModel.fromJson(Map<String, dynamic> json) =
      _$DeviceListModelImpl.fromJson;

  @override
  String get status;
  @override
  int get code;
  @override
  String get message;
  @override
  List<DeviceModel>? get data;
  @override
  @JsonKey(ignore: true)
  _$$DeviceListModelImplCopyWith<_$DeviceListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
