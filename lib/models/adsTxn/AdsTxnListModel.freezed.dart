// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'AdsTxnListModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdsTxnListModel _$AdsTxnListModelFromJson(Map<String, dynamic> json) {
  return _AdsTxnListModel.fromJson(json);
}

/// @nodoc
mixin _$AdsTxnListModel {
  String get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<AdsTxnModel>? get adsTxn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AdsTxnListModelCopyWith<AdsTxnListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdsTxnListModelCopyWith<$Res> {
  factory $AdsTxnListModelCopyWith(
          AdsTxnListModel value, $Res Function(AdsTxnListModel) then) =
      _$AdsTxnListModelCopyWithImpl<$Res, AdsTxnListModel>;
  @useResult
  $Res call(
      {String status, int code, String message, List<AdsTxnModel>? adsTxn});
}

/// @nodoc
class _$AdsTxnListModelCopyWithImpl<$Res, $Val extends AdsTxnListModel>
    implements $AdsTxnListModelCopyWith<$Res> {
  _$AdsTxnListModelCopyWithImpl(this._value, this._then);

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
    Object? adsTxn = freezed,
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
      adsTxn: freezed == adsTxn
          ? _value.adsTxn
          : adsTxn // ignore: cast_nullable_to_non_nullable
              as List<AdsTxnModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdsTxnListModelImplCopyWith<$Res>
    implements $AdsTxnListModelCopyWith<$Res> {
  factory _$$AdsTxnListModelImplCopyWith(_$AdsTxnListModelImpl value,
          $Res Function(_$AdsTxnListModelImpl) then) =
      __$$AdsTxnListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String status, int code, String message, List<AdsTxnModel>? adsTxn});
}

/// @nodoc
class __$$AdsTxnListModelImplCopyWithImpl<$Res>
    extends _$AdsTxnListModelCopyWithImpl<$Res, _$AdsTxnListModelImpl>
    implements _$$AdsTxnListModelImplCopyWith<$Res> {
  __$$AdsTxnListModelImplCopyWithImpl(
      _$AdsTxnListModelImpl _value, $Res Function(_$AdsTxnListModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? code = null,
    Object? message = null,
    Object? adsTxn = freezed,
  }) {
    return _then(_$AdsTxnListModelImpl(
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
      adsTxn: freezed == adsTxn
          ? _value._adsTxn
          : adsTxn // ignore: cast_nullable_to_non_nullable
              as List<AdsTxnModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdsTxnListModelImpl implements _AdsTxnListModel {
  _$AdsTxnListModelImpl(
      {required this.status,
      required this.code,
      required this.message,
      final List<AdsTxnModel>? adsTxn})
      : _adsTxn = adsTxn;

  factory _$AdsTxnListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdsTxnListModelImplFromJson(json);

  @override
  final String status;
  @override
  final int code;
  @override
  final String message;
  final List<AdsTxnModel>? _adsTxn;
  @override
  List<AdsTxnModel>? get adsTxn {
    final value = _adsTxn;
    if (value == null) return null;
    if (_adsTxn is EqualUnmodifiableListView) return _adsTxn;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'AdsTxnListModel(status: $status, code: $code, message: $message, adsTxn: $adsTxn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdsTxnListModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._adsTxn, _adsTxn));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, code, message,
      const DeepCollectionEquality().hash(_adsTxn));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AdsTxnListModelImplCopyWith<_$AdsTxnListModelImpl> get copyWith =>
      __$$AdsTxnListModelImplCopyWithImpl<_$AdsTxnListModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdsTxnListModelImplToJson(
      this,
    );
  }
}

abstract class _AdsTxnListModel implements AdsTxnListModel {
  factory _AdsTxnListModel(
      {required final String status,
      required final int code,
      required final String message,
      final List<AdsTxnModel>? adsTxn}) = _$AdsTxnListModelImpl;

  factory _AdsTxnListModel.fromJson(Map<String, dynamic> json) =
      _$AdsTxnListModelImpl.fromJson;

  @override
  String get status;
  @override
  int get code;
  @override
  String get message;
  @override
  List<AdsTxnModel>? get adsTxn;
  @override
  @JsonKey(ignore: true)
  _$$AdsTxnListModelImplCopyWith<_$AdsTxnListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
