// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'OutstandingListModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OutstandingListModel _$OutstandingListModelFromJson(Map<String, dynamic> json) {
  return _OutstandingListModel.fromJson(json);
}

/// @nodoc
mixin _$OutstandingListModel {
  String get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<OutstandingModel>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OutstandingListModelCopyWith<OutstandingListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutstandingListModelCopyWith<$Res> {
  factory $OutstandingListModelCopyWith(OutstandingListModel value,
          $Res Function(OutstandingListModel) then) =
      _$OutstandingListModelCopyWithImpl<$Res, OutstandingListModel>;
  @useResult
  $Res call(
      {String status, int code, String message, List<OutstandingModel>? data});
}

/// @nodoc
class _$OutstandingListModelCopyWithImpl<$Res,
        $Val extends OutstandingListModel>
    implements $OutstandingListModelCopyWith<$Res> {
  _$OutstandingListModelCopyWithImpl(this._value, this._then);

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
              as List<OutstandingModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OutstandingListModelImplCopyWith<$Res>
    implements $OutstandingListModelCopyWith<$Res> {
  factory _$$OutstandingListModelImplCopyWith(_$OutstandingListModelImpl value,
          $Res Function(_$OutstandingListModelImpl) then) =
      __$$OutstandingListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String status, int code, String message, List<OutstandingModel>? data});
}

/// @nodoc
class __$$OutstandingListModelImplCopyWithImpl<$Res>
    extends _$OutstandingListModelCopyWithImpl<$Res, _$OutstandingListModelImpl>
    implements _$$OutstandingListModelImplCopyWith<$Res> {
  __$$OutstandingListModelImplCopyWithImpl(_$OutstandingListModelImpl _value,
      $Res Function(_$OutstandingListModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$OutstandingListModelImpl(
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
              as List<OutstandingModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OutstandingListModelImpl implements _OutstandingListModel {
  _$OutstandingListModelImpl(
      {required this.status,
      required this.code,
      required this.message,
      final List<OutstandingModel>? data})
      : _data = data;

  factory _$OutstandingListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OutstandingListModelImplFromJson(json);

  @override
  final String status;
  @override
  final int code;
  @override
  final String message;
  final List<OutstandingModel>? _data;
  @override
  List<OutstandingModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'OutstandingListModel(status: $status, code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutstandingListModelImpl &&
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
  _$$OutstandingListModelImplCopyWith<_$OutstandingListModelImpl>
      get copyWith =>
          __$$OutstandingListModelImplCopyWithImpl<_$OutstandingListModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OutstandingListModelImplToJson(
      this,
    );
  }
}

abstract class _OutstandingListModel implements OutstandingListModel {
  factory _OutstandingListModel(
      {required final String status,
      required final int code,
      required final String message,
      final List<OutstandingModel>? data}) = _$OutstandingListModelImpl;

  factory _OutstandingListModel.fromJson(Map<String, dynamic> json) =
      _$OutstandingListModelImpl.fromJson;

  @override
  String get status;
  @override
  int get code;
  @override
  String get message;
  @override
  List<OutstandingModel>? get data;
  @override
  @JsonKey(ignore: true)
  _$$OutstandingListModelImplCopyWith<_$OutstandingListModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
