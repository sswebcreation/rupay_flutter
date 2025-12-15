// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'CompanyListModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CompanyListModel _$CompanyListModelFromJson(Map<String, dynamic> json) {
  return _CompanyListModel.fromJson(json);
}

/// @nodoc
mixin _$CompanyListModel {
  String get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<CompanyModel>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompanyListModelCopyWith<CompanyListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyListModelCopyWith<$Res> {
  factory $CompanyListModelCopyWith(
          CompanyListModel value, $Res Function(CompanyListModel) then) =
      _$CompanyListModelCopyWithImpl<$Res, CompanyListModel>;
  @useResult
  $Res call(
      {String status, int code, String message, List<CompanyModel>? data});
}

/// @nodoc
class _$CompanyListModelCopyWithImpl<$Res, $Val extends CompanyListModel>
    implements $CompanyListModelCopyWith<$Res> {
  _$CompanyListModelCopyWithImpl(this._value, this._then);

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
              as List<CompanyModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompanyListModelImplCopyWith<$Res>
    implements $CompanyListModelCopyWith<$Res> {
  factory _$$CompanyListModelImplCopyWith(_$CompanyListModelImpl value,
          $Res Function(_$CompanyListModelImpl) then) =
      __$$CompanyListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String status, int code, String message, List<CompanyModel>? data});
}

/// @nodoc
class __$$CompanyListModelImplCopyWithImpl<$Res>
    extends _$CompanyListModelCopyWithImpl<$Res, _$CompanyListModelImpl>
    implements _$$CompanyListModelImplCopyWith<$Res> {
  __$$CompanyListModelImplCopyWithImpl(_$CompanyListModelImpl _value,
      $Res Function(_$CompanyListModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$CompanyListModelImpl(
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
              as List<CompanyModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompanyListModelImpl implements _CompanyListModel {
  _$CompanyListModelImpl(
      {required this.status,
      required this.code,
      required this.message,
      final List<CompanyModel>? data})
      : _data = data;

  factory _$CompanyListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompanyListModelImplFromJson(json);

  @override
  final String status;
  @override
  final int code;
  @override
  final String message;
  final List<CompanyModel>? _data;
  @override
  List<CompanyModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CompanyListModel(status: $status, code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompanyListModelImpl &&
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
  _$$CompanyListModelImplCopyWith<_$CompanyListModelImpl> get copyWith =>
      __$$CompanyListModelImplCopyWithImpl<_$CompanyListModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompanyListModelImplToJson(
      this,
    );
  }
}

abstract class _CompanyListModel implements CompanyListModel {
  factory _CompanyListModel(
      {required final String status,
      required final int code,
      required final String message,
      final List<CompanyModel>? data}) = _$CompanyListModelImpl;

  factory _CompanyListModel.fromJson(Map<String, dynamic> json) =
      _$CompanyListModelImpl.fromJson;

  @override
  String get status;
  @override
  int get code;
  @override
  String get message;
  @override
  List<CompanyModel>? get data;
  @override
  @JsonKey(ignore: true)
  _$$CompanyListModelImplCopyWith<_$CompanyListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
