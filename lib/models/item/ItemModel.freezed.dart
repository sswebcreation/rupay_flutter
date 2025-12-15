// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ItemModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) {
  return _ItemModel.fromJson(json);
}

/// @nodoc
mixin _$ItemModel {
  int get ID => throw _privateConstructorUsedError;
  String get UID => throw _privateConstructorUsedError;
  String get COCODE => throw _privateConstructorUsedError;
  String get CODE => throw _privateConstructorUsedError;
  String get NAME => throw _privateConstructorUsedError;
  String get ITEMGROUP => throw _privateConstructorUsedError;
  String? get HSN => throw _privateConstructorUsedError;
  String? get SAC => throw _privateConstructorUsedError;
  double get HSNPer => throw _privateConstructorUsedError;
  double get SACPer => throw _privateConstructorUsedError;
  double? get SALEPRICE => throw _privateConstructorUsedError;
  double? get PURCHASECOST => throw _privateConstructorUsedError;
  String? get BARCODENO => throw _privateConstructorUsedError;
  String? get UNIT => throw _privateConstructorUsedError;
  int? get RATEPER => throw _privateConstructorUsedError;
  double? get BALANCEQUANTITY => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemModelCopyWith<ItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemModelCopyWith<$Res> {
  factory $ItemModelCopyWith(ItemModel value, $Res Function(ItemModel) then) =
      _$ItemModelCopyWithImpl<$Res, ItemModel>;
  @useResult
  $Res call(
      {int ID,
      String UID,
      String COCODE,
      String CODE,
      String NAME,
      String ITEMGROUP,
      String? HSN,
      String? SAC,
      double HSNPer,
      double SACPer,
      double? SALEPRICE,
      double? PURCHASECOST,
      String? BARCODENO,
      String? UNIT,
      int? RATEPER,
      double? BALANCEQUANTITY});
}

/// @nodoc
class _$ItemModelCopyWithImpl<$Res, $Val extends ItemModel>
    implements $ItemModelCopyWith<$Res> {
  _$ItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ID = null,
    Object? UID = null,
    Object? COCODE = null,
    Object? CODE = null,
    Object? NAME = null,
    Object? ITEMGROUP = null,
    Object? HSN = freezed,
    Object? SAC = freezed,
    Object? HSNPer = null,
    Object? SACPer = null,
    Object? SALEPRICE = freezed,
    Object? PURCHASECOST = freezed,
    Object? BARCODENO = freezed,
    Object? UNIT = freezed,
    Object? RATEPER = freezed,
    Object? BALANCEQUANTITY = freezed,
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
      COCODE: null == COCODE
          ? _value.COCODE
          : COCODE // ignore: cast_nullable_to_non_nullable
              as String,
      CODE: null == CODE
          ? _value.CODE
          : CODE // ignore: cast_nullable_to_non_nullable
              as String,
      NAME: null == NAME
          ? _value.NAME
          : NAME // ignore: cast_nullable_to_non_nullable
              as String,
      ITEMGROUP: null == ITEMGROUP
          ? _value.ITEMGROUP
          : ITEMGROUP // ignore: cast_nullable_to_non_nullable
              as String,
      HSN: freezed == HSN
          ? _value.HSN
          : HSN // ignore: cast_nullable_to_non_nullable
              as String?,
      SAC: freezed == SAC
          ? _value.SAC
          : SAC // ignore: cast_nullable_to_non_nullable
              as String?,
      HSNPer: null == HSNPer
          ? _value.HSNPer
          : HSNPer // ignore: cast_nullable_to_non_nullable
              as double,
      SACPer: null == SACPer
          ? _value.SACPer
          : SACPer // ignore: cast_nullable_to_non_nullable
              as double,
      SALEPRICE: freezed == SALEPRICE
          ? _value.SALEPRICE
          : SALEPRICE // ignore: cast_nullable_to_non_nullable
              as double?,
      PURCHASECOST: freezed == PURCHASECOST
          ? _value.PURCHASECOST
          : PURCHASECOST // ignore: cast_nullable_to_non_nullable
              as double?,
      BARCODENO: freezed == BARCODENO
          ? _value.BARCODENO
          : BARCODENO // ignore: cast_nullable_to_non_nullable
              as String?,
      UNIT: freezed == UNIT
          ? _value.UNIT
          : UNIT // ignore: cast_nullable_to_non_nullable
              as String?,
      RATEPER: freezed == RATEPER
          ? _value.RATEPER
          : RATEPER // ignore: cast_nullable_to_non_nullable
              as int?,
      BALANCEQUANTITY: freezed == BALANCEQUANTITY
          ? _value.BALANCEQUANTITY
          : BALANCEQUANTITY // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemModelImplCopyWith<$Res>
    implements $ItemModelCopyWith<$Res> {
  factory _$$ItemModelImplCopyWith(
          _$ItemModelImpl value, $Res Function(_$ItemModelImpl) then) =
      __$$ItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int ID,
      String UID,
      String COCODE,
      String CODE,
      String NAME,
      String ITEMGROUP,
      String? HSN,
      String? SAC,
      double HSNPer,
      double SACPer,
      double? SALEPRICE,
      double? PURCHASECOST,
      String? BARCODENO,
      String? UNIT,
      int? RATEPER,
      double? BALANCEQUANTITY});
}

/// @nodoc
class __$$ItemModelImplCopyWithImpl<$Res>
    extends _$ItemModelCopyWithImpl<$Res, _$ItemModelImpl>
    implements _$$ItemModelImplCopyWith<$Res> {
  __$$ItemModelImplCopyWithImpl(
      _$ItemModelImpl _value, $Res Function(_$ItemModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ID = null,
    Object? UID = null,
    Object? COCODE = null,
    Object? CODE = null,
    Object? NAME = null,
    Object? ITEMGROUP = null,
    Object? HSN = freezed,
    Object? SAC = freezed,
    Object? HSNPer = null,
    Object? SACPer = null,
    Object? SALEPRICE = freezed,
    Object? PURCHASECOST = freezed,
    Object? BARCODENO = freezed,
    Object? UNIT = freezed,
    Object? RATEPER = freezed,
    Object? BALANCEQUANTITY = freezed,
  }) {
    return _then(_$ItemModelImpl(
      ID: null == ID
          ? _value.ID
          : ID // ignore: cast_nullable_to_non_nullable
              as int,
      UID: null == UID
          ? _value.UID
          : UID // ignore: cast_nullable_to_non_nullable
              as String,
      COCODE: null == COCODE
          ? _value.COCODE
          : COCODE // ignore: cast_nullable_to_non_nullable
              as String,
      CODE: null == CODE
          ? _value.CODE
          : CODE // ignore: cast_nullable_to_non_nullable
              as String,
      NAME: null == NAME
          ? _value.NAME
          : NAME // ignore: cast_nullable_to_non_nullable
              as String,
      ITEMGROUP: null == ITEMGROUP
          ? _value.ITEMGROUP
          : ITEMGROUP // ignore: cast_nullable_to_non_nullable
              as String,
      HSN: freezed == HSN
          ? _value.HSN
          : HSN // ignore: cast_nullable_to_non_nullable
              as String?,
      SAC: freezed == SAC
          ? _value.SAC
          : SAC // ignore: cast_nullable_to_non_nullable
              as String?,
      HSNPer: null == HSNPer
          ? _value.HSNPer
          : HSNPer // ignore: cast_nullable_to_non_nullable
              as double,
      SACPer: null == SACPer
          ? _value.SACPer
          : SACPer // ignore: cast_nullable_to_non_nullable
              as double,
      SALEPRICE: freezed == SALEPRICE
          ? _value.SALEPRICE
          : SALEPRICE // ignore: cast_nullable_to_non_nullable
              as double?,
      PURCHASECOST: freezed == PURCHASECOST
          ? _value.PURCHASECOST
          : PURCHASECOST // ignore: cast_nullable_to_non_nullable
              as double?,
      BARCODENO: freezed == BARCODENO
          ? _value.BARCODENO
          : BARCODENO // ignore: cast_nullable_to_non_nullable
              as String?,
      UNIT: freezed == UNIT
          ? _value.UNIT
          : UNIT // ignore: cast_nullable_to_non_nullable
              as String?,
      RATEPER: freezed == RATEPER
          ? _value.RATEPER
          : RATEPER // ignore: cast_nullable_to_non_nullable
              as int?,
      BALANCEQUANTITY: freezed == BALANCEQUANTITY
          ? _value.BALANCEQUANTITY
          : BALANCEQUANTITY // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemModelImpl implements _ItemModel {
  _$ItemModelImpl(
      {required this.ID,
      required this.UID,
      required this.COCODE,
      required this.CODE,
      required this.NAME,
      required this.ITEMGROUP,
      this.HSN,
      this.SAC,
      required this.HSNPer,
      required this.SACPer,
      this.SALEPRICE,
      this.PURCHASECOST,
      this.BARCODENO,
      this.UNIT,
      this.RATEPER,
      this.BALANCEQUANTITY});

  factory _$ItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemModelImplFromJson(json);

  @override
  final int ID;
  @override
  final String UID;
  @override
  final String COCODE;
  @override
  final String CODE;
  @override
  final String NAME;
  @override
  final String ITEMGROUP;
  @override
  final String? HSN;
  @override
  final String? SAC;
  @override
  final double HSNPer;
  @override
  final double SACPer;
  @override
  final double? SALEPRICE;
  @override
  final double? PURCHASECOST;
  @override
  final String? BARCODENO;
  @override
  final String? UNIT;
  @override
  final int? RATEPER;
  @override
  final double? BALANCEQUANTITY;

  @override
  String toString() {
    return 'ItemModel(ID: $ID, UID: $UID, COCODE: $COCODE, CODE: $CODE, NAME: $NAME, ITEMGROUP: $ITEMGROUP, HSN: $HSN, SAC: $SAC, HSNPer: $HSNPer, SACPer: $SACPer, SALEPRICE: $SALEPRICE, PURCHASECOST: $PURCHASECOST, BARCODENO: $BARCODENO, UNIT: $UNIT, RATEPER: $RATEPER, BALANCEQUANTITY: $BALANCEQUANTITY)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemModelImpl &&
            (identical(other.ID, ID) || other.ID == ID) &&
            (identical(other.UID, UID) || other.UID == UID) &&
            (identical(other.COCODE, COCODE) || other.COCODE == COCODE) &&
            (identical(other.CODE, CODE) || other.CODE == CODE) &&
            (identical(other.NAME, NAME) || other.NAME == NAME) &&
            (identical(other.ITEMGROUP, ITEMGROUP) ||
                other.ITEMGROUP == ITEMGROUP) &&
            (identical(other.HSN, HSN) || other.HSN == HSN) &&
            (identical(other.SAC, SAC) || other.SAC == SAC) &&
            (identical(other.HSNPer, HSNPer) || other.HSNPer == HSNPer) &&
            (identical(other.SACPer, SACPer) || other.SACPer == SACPer) &&
            (identical(other.SALEPRICE, SALEPRICE) ||
                other.SALEPRICE == SALEPRICE) &&
            (identical(other.PURCHASECOST, PURCHASECOST) ||
                other.PURCHASECOST == PURCHASECOST) &&
            (identical(other.BARCODENO, BARCODENO) ||
                other.BARCODENO == BARCODENO) &&
            (identical(other.UNIT, UNIT) || other.UNIT == UNIT) &&
            (identical(other.RATEPER, RATEPER) || other.RATEPER == RATEPER) &&
            (identical(other.BALANCEQUANTITY, BALANCEQUANTITY) ||
                other.BALANCEQUANTITY == BALANCEQUANTITY));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      ID,
      UID,
      COCODE,
      CODE,
      NAME,
      ITEMGROUP,
      HSN,
      SAC,
      HSNPer,
      SACPer,
      SALEPRICE,
      PURCHASECOST,
      BARCODENO,
      UNIT,
      RATEPER,
      BALANCEQUANTITY);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemModelImplCopyWith<_$ItemModelImpl> get copyWith =>
      __$$ItemModelImplCopyWithImpl<_$ItemModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemModelImplToJson(
      this,
    );
  }
}

abstract class _ItemModel implements ItemModel {
  factory _ItemModel(
      {required final int ID,
      required final String UID,
      required final String COCODE,
      required final String CODE,
      required final String NAME,
      required final String ITEMGROUP,
      final String? HSN,
      final String? SAC,
      required final double HSNPer,
      required final double SACPer,
      final double? SALEPRICE,
      final double? PURCHASECOST,
      final String? BARCODENO,
      final String? UNIT,
      final int? RATEPER,
      final double? BALANCEQUANTITY}) = _$ItemModelImpl;

  factory _ItemModel.fromJson(Map<String, dynamic> json) =
      _$ItemModelImpl.fromJson;

  @override
  int get ID;
  @override
  String get UID;
  @override
  String get COCODE;
  @override
  String get CODE;
  @override
  String get NAME;
  @override
  String get ITEMGROUP;
  @override
  String? get HSN;
  @override
  String? get SAC;
  @override
  double get HSNPer;
  @override
  double get SACPer;
  @override
  double? get SALEPRICE;
  @override
  double? get PURCHASECOST;
  @override
  String? get BARCODENO;
  @override
  String? get UNIT;
  @override
  int? get RATEPER;
  @override
  double? get BALANCEQUANTITY;
  @override
  @JsonKey(ignore: true)
  _$$ItemModelImplCopyWith<_$ItemModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
