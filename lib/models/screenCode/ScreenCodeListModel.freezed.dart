// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ScreenCodeListModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ScreenCodeListModel _$ScreenCodeListModelFromJson(Map<String, dynamic> json) {
  return _ScreenCodeListModel.fromJson(json);
}

/// @nodoc
mixin _$ScreenCodeListModel {
  String get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<ScreenCodeModel>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScreenCodeListModelCopyWith<ScreenCodeListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScreenCodeListModelCopyWith<$Res> {
  factory $ScreenCodeListModelCopyWith(
          ScreenCodeListModel value, $Res Function(ScreenCodeListModel) then) =
      _$ScreenCodeListModelCopyWithImpl<$Res, ScreenCodeListModel>;
  @useResult
  $Res call(
      {String status, int code, String message, List<ScreenCodeModel>? data});
}

/// @nodoc
class _$ScreenCodeListModelCopyWithImpl<$Res, $Val extends ScreenCodeListModel>
    implements $ScreenCodeListModelCopyWith<$Res> {
  _$ScreenCodeListModelCopyWithImpl(this._value, this._then);

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
              as List<ScreenCodeModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScreenCodeListModelImplCopyWith<$Res>
    implements $ScreenCodeListModelCopyWith<$Res> {
  factory _$$ScreenCodeListModelImplCopyWith(_$ScreenCodeListModelImpl value,
          $Res Function(_$ScreenCodeListModelImpl) then) =
      __$$ScreenCodeListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String status, int code, String message, List<ScreenCodeModel>? data});
}

/// @nodoc
class __$$ScreenCodeListModelImplCopyWithImpl<$Res>
    extends _$ScreenCodeListModelCopyWithImpl<$Res, _$ScreenCodeListModelImpl>
    implements _$$ScreenCodeListModelImplCopyWith<$Res> {
  __$$ScreenCodeListModelImplCopyWithImpl(_$ScreenCodeListModelImpl _value,
      $Res Function(_$ScreenCodeListModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$ScreenCodeListModelImpl(
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
              as List<ScreenCodeModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScreenCodeListModelImpl implements _ScreenCodeListModel {
  _$ScreenCodeListModelImpl(
      {required this.status,
      required this.code,
      required this.message,
      final List<ScreenCodeModel>? data})
      : _data = data;

  factory _$ScreenCodeListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScreenCodeListModelImplFromJson(json);

  @override
  final String status;
  @override
  final int code;
  @override
  final String message;
  final List<ScreenCodeModel>? _data;
  @override
  List<ScreenCodeModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ScreenCodeListModel(status: $status, code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScreenCodeListModelImpl &&
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
  _$$ScreenCodeListModelImplCopyWith<_$ScreenCodeListModelImpl> get copyWith =>
      __$$ScreenCodeListModelImplCopyWithImpl<_$ScreenCodeListModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScreenCodeListModelImplToJson(
      this,
    );
  }
}

abstract class _ScreenCodeListModel implements ScreenCodeListModel {
  factory _ScreenCodeListModel(
      {required final String status,
      required final int code,
      required final String message,
      final List<ScreenCodeModel>? data}) = _$ScreenCodeListModelImpl;

  factory _ScreenCodeListModel.fromJson(Map<String, dynamic> json) =
      _$ScreenCodeListModelImpl.fromJson;

  @override
  String get status;
  @override
  int get code;
  @override
  String get message;
  @override
  List<ScreenCodeModel>? get data;
  @override
  @JsonKey(ignore: true)
  _$$ScreenCodeListModelImplCopyWith<_$ScreenCodeListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
