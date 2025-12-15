// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'PurchaseListModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PurchaseListModel _$PurchaseListModelFromJson(Map<String, dynamic> json) {
  return _PurchaseListModel.fromJson(json);
}

/// @nodoc
mixin _$PurchaseListModel {
  String get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<PurchaseModel>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PurchaseListModelCopyWith<PurchaseListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseListModelCopyWith<$Res> {
  factory $PurchaseListModelCopyWith(
          PurchaseListModel value, $Res Function(PurchaseListModel) then) =
      _$PurchaseListModelCopyWithImpl<$Res, PurchaseListModel>;
  @useResult
  $Res call(
      {String status, int code, String message, List<PurchaseModel>? data});
}

/// @nodoc
class _$PurchaseListModelCopyWithImpl<$Res, $Val extends PurchaseListModel>
    implements $PurchaseListModelCopyWith<$Res> {
  _$PurchaseListModelCopyWithImpl(this._value, this._then);

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
              as List<PurchaseModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PurchaseListModelImplCopyWith<$Res>
    implements $PurchaseListModelCopyWith<$Res> {
  factory _$$PurchaseListModelImplCopyWith(_$PurchaseListModelImpl value,
          $Res Function(_$PurchaseListModelImpl) then) =
      __$$PurchaseListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String status, int code, String message, List<PurchaseModel>? data});
}

/// @nodoc
class __$$PurchaseListModelImplCopyWithImpl<$Res>
    extends _$PurchaseListModelCopyWithImpl<$Res, _$PurchaseListModelImpl>
    implements _$$PurchaseListModelImplCopyWith<$Res> {
  __$$PurchaseListModelImplCopyWithImpl(_$PurchaseListModelImpl _value,
      $Res Function(_$PurchaseListModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$PurchaseListModelImpl(
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
              as List<PurchaseModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PurchaseListModelImpl implements _PurchaseListModel {
  _$PurchaseListModelImpl(
      {required this.status,
      required this.code,
      required this.message,
      final List<PurchaseModel>? data})
      : _data = data;

  factory _$PurchaseListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchaseListModelImplFromJson(json);

  @override
  final String status;
  @override
  final int code;
  @override
  final String message;
  final List<PurchaseModel>? _data;
  @override
  List<PurchaseModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PurchaseListModel(status: $status, code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseListModelImpl &&
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
  _$$PurchaseListModelImplCopyWith<_$PurchaseListModelImpl> get copyWith =>
      __$$PurchaseListModelImplCopyWithImpl<_$PurchaseListModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PurchaseListModelImplToJson(
      this,
    );
  }
}

abstract class _PurchaseListModel implements PurchaseListModel {
  factory _PurchaseListModel(
      {required final String status,
      required final int code,
      required final String message,
      final List<PurchaseModel>? data}) = _$PurchaseListModelImpl;

  factory _PurchaseListModel.fromJson(Map<String, dynamic> json) =
      _$PurchaseListModelImpl.fromJson;

  @override
  String get status;
  @override
  int get code;
  @override
  String get message;
  @override
  List<PurchaseModel>? get data;
  @override
  @JsonKey(ignore: true)
  _$$PurchaseListModelImplCopyWith<_$PurchaseListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
