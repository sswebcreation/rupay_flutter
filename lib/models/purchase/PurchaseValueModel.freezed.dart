// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'PurchaseValueModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PurchaseValueModel _$PurchaseValueModelFromJson(Map<String, dynamic> json) {
  return _PurchaseValueModel.fromJson(json);
}

/// @nodoc
mixin _$PurchaseValueModel {
  String get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String? get data => throw _privateConstructorUsedError;
  List<DaybookModel>? get daybooks => throw _privateConstructorUsedError;
  List<AccountModel>? get parties => throw _privateConstructorUsedError;
  List<ItemModel>? get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PurchaseValueModelCopyWith<PurchaseValueModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseValueModelCopyWith<$Res> {
  factory $PurchaseValueModelCopyWith(
          PurchaseValueModel value, $Res Function(PurchaseValueModel) then) =
      _$PurchaseValueModelCopyWithImpl<$Res, PurchaseValueModel>;
  @useResult
  $Res call(
      {String status,
      int code,
      String message,
      String? data,
      List<DaybookModel>? daybooks,
      List<AccountModel>? parties,
      List<ItemModel>? items});
}

/// @nodoc
class _$PurchaseValueModelCopyWithImpl<$Res, $Val extends PurchaseValueModel>
    implements $PurchaseValueModelCopyWith<$Res> {
  _$PurchaseValueModelCopyWithImpl(this._value, this._then);

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
    Object? daybooks = freezed,
    Object? parties = freezed,
    Object? items = freezed,
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
              as String?,
      daybooks: freezed == daybooks
          ? _value.daybooks
          : daybooks // ignore: cast_nullable_to_non_nullable
              as List<DaybookModel>?,
      parties: freezed == parties
          ? _value.parties
          : parties // ignore: cast_nullable_to_non_nullable
              as List<AccountModel>?,
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ItemModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PurchaseValueModelImplCopyWith<$Res>
    implements $PurchaseValueModelCopyWith<$Res> {
  factory _$$PurchaseValueModelImplCopyWith(_$PurchaseValueModelImpl value,
          $Res Function(_$PurchaseValueModelImpl) then) =
      __$$PurchaseValueModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String status,
      int code,
      String message,
      String? data,
      List<DaybookModel>? daybooks,
      List<AccountModel>? parties,
      List<ItemModel>? items});
}

/// @nodoc
class __$$PurchaseValueModelImplCopyWithImpl<$Res>
    extends _$PurchaseValueModelCopyWithImpl<$Res, _$PurchaseValueModelImpl>
    implements _$$PurchaseValueModelImplCopyWith<$Res> {
  __$$PurchaseValueModelImplCopyWithImpl(_$PurchaseValueModelImpl _value,
      $Res Function(_$PurchaseValueModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
    Object? daybooks = freezed,
    Object? parties = freezed,
    Object? items = freezed,
  }) {
    return _then(_$PurchaseValueModelImpl(
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
              as String?,
      daybooks: freezed == daybooks
          ? _value._daybooks
          : daybooks // ignore: cast_nullable_to_non_nullable
              as List<DaybookModel>?,
      parties: freezed == parties
          ? _value._parties
          : parties // ignore: cast_nullable_to_non_nullable
              as List<AccountModel>?,
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ItemModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PurchaseValueModelImpl implements _PurchaseValueModel {
  _$PurchaseValueModelImpl(
      {required this.status,
      required this.code,
      required this.message,
      this.data,
      final List<DaybookModel>? daybooks,
      final List<AccountModel>? parties,
      final List<ItemModel>? items})
      : _daybooks = daybooks,
        _parties = parties,
        _items = items;

  factory _$PurchaseValueModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchaseValueModelImplFromJson(json);

  @override
  final String status;
  @override
  final int code;
  @override
  final String message;
  @override
  final String? data;
  final List<DaybookModel>? _daybooks;
  @override
  List<DaybookModel>? get daybooks {
    final value = _daybooks;
    if (value == null) return null;
    if (_daybooks is EqualUnmodifiableListView) return _daybooks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<AccountModel>? _parties;
  @override
  List<AccountModel>? get parties {
    final value = _parties;
    if (value == null) return null;
    if (_parties is EqualUnmodifiableListView) return _parties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ItemModel>? _items;
  @override
  List<ItemModel>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PurchaseValueModel(status: $status, code: $code, message: $message, data: $data, daybooks: $daybooks, parties: $parties, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseValueModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data) &&
            const DeepCollectionEquality().equals(other._daybooks, _daybooks) &&
            const DeepCollectionEquality().equals(other._parties, _parties) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      code,
      message,
      data,
      const DeepCollectionEquality().hash(_daybooks),
      const DeepCollectionEquality().hash(_parties),
      const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseValueModelImplCopyWith<_$PurchaseValueModelImpl> get copyWith =>
      __$$PurchaseValueModelImplCopyWithImpl<_$PurchaseValueModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PurchaseValueModelImplToJson(
      this,
    );
  }
}

abstract class _PurchaseValueModel implements PurchaseValueModel {
  factory _PurchaseValueModel(
      {required final String status,
      required final int code,
      required final String message,
      final String? data,
      final List<DaybookModel>? daybooks,
      final List<AccountModel>? parties,
      final List<ItemModel>? items}) = _$PurchaseValueModelImpl;

  factory _PurchaseValueModel.fromJson(Map<String, dynamic> json) =
      _$PurchaseValueModelImpl.fromJson;

  @override
  String get status;
  @override
  int get code;
  @override
  String get message;
  @override
  String? get data;
  @override
  List<DaybookModel>? get daybooks;
  @override
  List<AccountModel>? get parties;
  @override
  List<ItemModel>? get items;
  @override
  @JsonKey(ignore: true)
  _$$PurchaseValueModelImplCopyWith<_$PurchaseValueModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
