// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ItemListModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ItemListModel _$ItemListModelFromJson(Map<String, dynamic> json) {
  return _ItemListModel.fromJson(json);
}

/// @nodoc
mixin _$ItemListModel {
  String get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<ItemModel>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemListModelCopyWith<ItemListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemListModelCopyWith<$Res> {
  factory $ItemListModelCopyWith(
          ItemListModel value, $Res Function(ItemListModel) then) =
      _$ItemListModelCopyWithImpl<$Res, ItemListModel>;
  @useResult
  $Res call({String status, int code, String message, List<ItemModel>? data});
}

/// @nodoc
class _$ItemListModelCopyWithImpl<$Res, $Val extends ItemListModel>
    implements $ItemListModelCopyWith<$Res> {
  _$ItemListModelCopyWithImpl(this._value, this._then);

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
              as List<ItemModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemListModelImplCopyWith<$Res>
    implements $ItemListModelCopyWith<$Res> {
  factory _$$ItemListModelImplCopyWith(
          _$ItemListModelImpl value, $Res Function(_$ItemListModelImpl) then) =
      __$$ItemListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, int code, String message, List<ItemModel>? data});
}

/// @nodoc
class __$$ItemListModelImplCopyWithImpl<$Res>
    extends _$ItemListModelCopyWithImpl<$Res, _$ItemListModelImpl>
    implements _$$ItemListModelImplCopyWith<$Res> {
  __$$ItemListModelImplCopyWithImpl(
      _$ItemListModelImpl _value, $Res Function(_$ItemListModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$ItemListModelImpl(
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
              as List<ItemModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemListModelImpl implements _ItemListModel {
  _$ItemListModelImpl(
      {required this.status,
      required this.code,
      required this.message,
      final List<ItemModel>? data})
      : _data = data;

  factory _$ItemListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemListModelImplFromJson(json);

  @override
  final String status;
  @override
  final int code;
  @override
  final String message;
  final List<ItemModel>? _data;
  @override
  List<ItemModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ItemListModel(status: $status, code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemListModelImpl &&
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
  _$$ItemListModelImplCopyWith<_$ItemListModelImpl> get copyWith =>
      __$$ItemListModelImplCopyWithImpl<_$ItemListModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemListModelImplToJson(
      this,
    );
  }
}

abstract class _ItemListModel implements ItemListModel {
  factory _ItemListModel(
      {required final String status,
      required final int code,
      required final String message,
      final List<ItemModel>? data}) = _$ItemListModelImpl;

  factory _ItemListModel.fromJson(Map<String, dynamic> json) =
      _$ItemListModelImpl.fromJson;

  @override
  String get status;
  @override
  int get code;
  @override
  String get message;
  @override
  List<ItemModel>? get data;
  @override
  @JsonKey(ignore: true)
  _$$ItemListModelImplCopyWith<_$ItemListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
