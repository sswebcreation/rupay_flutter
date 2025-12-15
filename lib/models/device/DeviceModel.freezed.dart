// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'DeviceModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DeviceModel _$DeviceModelFromJson(Map<String, dynamic> json) {
  return _DeviceModel.fromJson(json);
}

/// @nodoc
mixin _$DeviceModel {
  int get ID => throw _privateConstructorUsedError;
  String get UID => throw _privateConstructorUsedError;
  String get IMEI => throw _privateConstructorUsedError;
  String get MODEL => throw _privateConstructorUsedError;
  String get OS => throw _privateConstructorUsedError;
  String get LOGINAT => throw _privateConstructorUsedError;
  String? get UPDATEDAT => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeviceModelCopyWith<DeviceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceModelCopyWith<$Res> {
  factory $DeviceModelCopyWith(
          DeviceModel value, $Res Function(DeviceModel) then) =
      _$DeviceModelCopyWithImpl<$Res, DeviceModel>;
  @useResult
  $Res call(
      {int ID,
      String UID,
      String IMEI,
      String MODEL,
      String OS,
      String LOGINAT,
      String? UPDATEDAT});
}

/// @nodoc
class _$DeviceModelCopyWithImpl<$Res, $Val extends DeviceModel>
    implements $DeviceModelCopyWith<$Res> {
  _$DeviceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ID = null,
    Object? UID = null,
    Object? IMEI = null,
    Object? MODEL = null,
    Object? OS = null,
    Object? LOGINAT = null,
    Object? UPDATEDAT = freezed,
  }) {
    return _then(_value.copyWith(
      ID: null == ID
          ? _value.ID
          : ID // ignore: cast_nullable_to_non_nullable
              as int,
      UID: null == UID
          ? _value.UID
          : UID // ignore: cast_nullable_to_non_nullable
              as String,
      IMEI: null == IMEI
          ? _value.IMEI
          : IMEI // ignore: cast_nullable_to_non_nullable
              as String,
      MODEL: null == MODEL
          ? _value.MODEL
          : MODEL // ignore: cast_nullable_to_non_nullable
              as String,
      OS: null == OS
          ? _value.OS
          : OS // ignore: cast_nullable_to_non_nullable
              as String,
      LOGINAT: null == LOGINAT
          ? _value.LOGINAT
          : LOGINAT // ignore: cast_nullable_to_non_nullable
              as String,
      UPDATEDAT: freezed == UPDATEDAT
          ? _value.UPDATEDAT
          : UPDATEDAT // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeviceModelImplCopyWith<$Res>
    implements $DeviceModelCopyWith<$Res> {
  factory _$$DeviceModelImplCopyWith(
          _$DeviceModelImpl value, $Res Function(_$DeviceModelImpl) then) =
      __$$DeviceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int ID,
      String UID,
      String IMEI,
      String MODEL,
      String OS,
      String LOGINAT,
      String? UPDATEDAT});
}

/// @nodoc
class __$$DeviceModelImplCopyWithImpl<$Res>
    extends _$DeviceModelCopyWithImpl<$Res, _$DeviceModelImpl>
    implements _$$DeviceModelImplCopyWith<$Res> {
  __$$DeviceModelImplCopyWithImpl(
      _$DeviceModelImpl _value, $Res Function(_$DeviceModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ID = null,
    Object? UID = null,
    Object? IMEI = null,
    Object? MODEL = null,
    Object? OS = null,
    Object? LOGINAT = null,
    Object? UPDATEDAT = freezed,
  }) {
    return _then(_$DeviceModelImpl(
      ID: null == ID
          ? _value.ID
          : ID // ignore: cast_nullable_to_non_nullable
              as int,
      UID: null == UID
          ? _value.UID
          : UID // ignore: cast_nullable_to_non_nullable
              as String,
      IMEI: null == IMEI
          ? _value.IMEI
          : IMEI // ignore: cast_nullable_to_non_nullable
              as String,
      MODEL: null == MODEL
          ? _value.MODEL
          : MODEL // ignore: cast_nullable_to_non_nullable
              as String,
      OS: null == OS
          ? _value.OS
          : OS // ignore: cast_nullable_to_non_nullable
              as String,
      LOGINAT: null == LOGINAT
          ? _value.LOGINAT
          : LOGINAT // ignore: cast_nullable_to_non_nullable
              as String,
      UPDATEDAT: freezed == UPDATEDAT
          ? _value.UPDATEDAT
          : UPDATEDAT // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceModelImpl implements _DeviceModel {
  _$DeviceModelImpl(
      {required this.ID,
      required this.UID,
      required this.IMEI,
      required this.MODEL,
      required this.OS,
      required this.LOGINAT,
      this.UPDATEDAT});

  factory _$DeviceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceModelImplFromJson(json);

  @override
  final int ID;
  @override
  final String UID;
  @override
  final String IMEI;
  @override
  final String MODEL;
  @override
  final String OS;
  @override
  final String LOGINAT;
  @override
  final String? UPDATEDAT;

  @override
  String toString() {
    return 'DeviceModel(ID: $ID, UID: $UID, IMEI: $IMEI, MODEL: $MODEL, OS: $OS, LOGINAT: $LOGINAT, UPDATEDAT: $UPDATEDAT)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceModelImpl &&
            (identical(other.ID, ID) || other.ID == ID) &&
            (identical(other.UID, UID) || other.UID == UID) &&
            (identical(other.IMEI, IMEI) || other.IMEI == IMEI) &&
            (identical(other.MODEL, MODEL) || other.MODEL == MODEL) &&
            (identical(other.OS, OS) || other.OS == OS) &&
            (identical(other.LOGINAT, LOGINAT) || other.LOGINAT == LOGINAT) &&
            (identical(other.UPDATEDAT, UPDATEDAT) ||
                other.UPDATEDAT == UPDATEDAT));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, ID, UID, IMEI, MODEL, OS, LOGINAT, UPDATEDAT);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceModelImplCopyWith<_$DeviceModelImpl> get copyWith =>
      __$$DeviceModelImplCopyWithImpl<_$DeviceModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceModelImplToJson(
      this,
    );
  }
}

abstract class _DeviceModel implements DeviceModel {
  factory _DeviceModel(
      {required final int ID,
      required final String UID,
      required final String IMEI,
      required final String MODEL,
      required final String OS,
      required final String LOGINAT,
      final String? UPDATEDAT}) = _$DeviceModelImpl;

  factory _DeviceModel.fromJson(Map<String, dynamic> json) =
      _$DeviceModelImpl.fromJson;

  @override
  int get ID;
  @override
  String get UID;
  @override
  String get IMEI;
  @override
  String get MODEL;
  @override
  String get OS;
  @override
  String get LOGINAT;
  @override
  String? get UPDATEDAT;
  @override
  @JsonKey(ignore: true)
  _$$DeviceModelImplCopyWith<_$DeviceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
