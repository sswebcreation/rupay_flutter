// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'DaybookListModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DaybookListModel _$DaybookListModelFromJson(Map<String, dynamic> json) {
  return _DaybookListModel.fromJson(json);
}

/// @nodoc
mixin _$DaybookListModel {
  String get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<DaybookModel>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DaybookListModelCopyWith<DaybookListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DaybookListModelCopyWith<$Res> {
  factory $DaybookListModelCopyWith(
          DaybookListModel value, $Res Function(DaybookListModel) then) =
      _$DaybookListModelCopyWithImpl<$Res, DaybookListModel>;
  @useResult
  $Res call(
      {String status, int code, String message, List<DaybookModel>? data});
}

/// @nodoc
class _$DaybookListModelCopyWithImpl<$Res, $Val extends DaybookListModel>
    implements $DaybookListModelCopyWith<$Res> {
  _$DaybookListModelCopyWithImpl(this._value, this._then);

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
              as List<DaybookModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DaybookListModelImplCopyWith<$Res>
    implements $DaybookListModelCopyWith<$Res> {
  factory _$$DaybookListModelImplCopyWith(_$DaybookListModelImpl value,
          $Res Function(_$DaybookListModelImpl) then) =
      __$$DaybookListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String status, int code, String message, List<DaybookModel>? data});
}

/// @nodoc
class __$$DaybookListModelImplCopyWithImpl<$Res>
    extends _$DaybookListModelCopyWithImpl<$Res, _$DaybookListModelImpl>
    implements _$$DaybookListModelImplCopyWith<$Res> {
  __$$DaybookListModelImplCopyWithImpl(_$DaybookListModelImpl _value,
      $Res Function(_$DaybookListModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$DaybookListModelImpl(
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
              as List<DaybookModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DaybookListModelImpl implements _DaybookListModel {
  _$DaybookListModelImpl(
      {required this.status,
      required this.code,
      required this.message,
      final List<DaybookModel>? data})
      : _data = data;

  factory _$DaybookListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DaybookListModelImplFromJson(json);

  @override
  final String status;
  @override
  final int code;
  @override
  final String message;
  final List<DaybookModel>? _data;
  @override
  List<DaybookModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'DaybookListModel(status: $status, code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DaybookListModelImpl &&
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
  _$$DaybookListModelImplCopyWith<_$DaybookListModelImpl> get copyWith =>
      __$$DaybookListModelImplCopyWithImpl<_$DaybookListModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DaybookListModelImplToJson(
      this,
    );
  }
}

abstract class _DaybookListModel implements DaybookListModel {
  factory _DaybookListModel(
      {required final String status,
      required final int code,
      required final String message,
      final List<DaybookModel>? data}) = _$DaybookListModelImpl;

  factory _DaybookListModel.fromJson(Map<String, dynamic> json) =
      _$DaybookListModelImpl.fromJson;

  @override
  String get status;
  @override
  int get code;
  @override
  String get message;
  @override
  List<DaybookModel>? get data;
  @override
  @JsonKey(ignore: true)
  _$$DaybookListModelImplCopyWith<_$DaybookListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
