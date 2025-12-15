// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'SalesListModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SalesListModel _$SalesListModelFromJson(Map<String, dynamic> json) {
  return _SalesListModel.fromJson(json);
}

/// @nodoc
mixin _$SalesListModel {
  String get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<SalesModel>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SalesListModelCopyWith<SalesListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesListModelCopyWith<$Res> {
  factory $SalesListModelCopyWith(
          SalesListModel value, $Res Function(SalesListModel) then) =
      _$SalesListModelCopyWithImpl<$Res, SalesListModel>;
  @useResult
  $Res call({String status, int code, String message, List<SalesModel>? data});
}

/// @nodoc
class _$SalesListModelCopyWithImpl<$Res, $Val extends SalesListModel>
    implements $SalesListModelCopyWith<$Res> {
  _$SalesListModelCopyWithImpl(this._value, this._then);

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
              as List<SalesModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SalesListModelImplCopyWith<$Res>
    implements $SalesListModelCopyWith<$Res> {
  factory _$$SalesListModelImplCopyWith(_$SalesListModelImpl value,
          $Res Function(_$SalesListModelImpl) then) =
      __$$SalesListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, int code, String message, List<SalesModel>? data});
}

/// @nodoc
class __$$SalesListModelImplCopyWithImpl<$Res>
    extends _$SalesListModelCopyWithImpl<$Res, _$SalesListModelImpl>
    implements _$$SalesListModelImplCopyWith<$Res> {
  __$$SalesListModelImplCopyWithImpl(
      _$SalesListModelImpl _value, $Res Function(_$SalesListModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$SalesListModelImpl(
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
              as List<SalesModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SalesListModelImpl implements _SalesListModel {
  _$SalesListModelImpl(
      {required this.status,
      required this.code,
      required this.message,
      final List<SalesModel>? data})
      : _data = data;

  factory _$SalesListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SalesListModelImplFromJson(json);

  @override
  final String status;
  @override
  final int code;
  @override
  final String message;
  final List<SalesModel>? _data;
  @override
  List<SalesModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SalesListModel(status: $status, code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesListModelImpl &&
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
  _$$SalesListModelImplCopyWith<_$SalesListModelImpl> get copyWith =>
      __$$SalesListModelImplCopyWithImpl<_$SalesListModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SalesListModelImplToJson(
      this,
    );
  }
}

abstract class _SalesListModel implements SalesListModel {
  factory _SalesListModel(
      {required final String status,
      required final int code,
      required final String message,
      final List<SalesModel>? data}) = _$SalesListModelImpl;

  factory _SalesListModel.fromJson(Map<String, dynamic> json) =
      _$SalesListModelImpl.fromJson;

  @override
  String get status;
  @override
  int get code;
  @override
  String get message;
  @override
  List<SalesModel>? get data;
  @override
  @JsonKey(ignore: true)
  _$$SalesListModelImplCopyWith<_$SalesListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
