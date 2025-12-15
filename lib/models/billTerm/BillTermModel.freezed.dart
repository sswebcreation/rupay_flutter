// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'BillTermModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BillTermModel _$BillTermModelFromJson(Map<String, dynamic> json) {
  return _BillTermModel.fromJson(json);
}

/// @nodoc
mixin _$BillTermModel {
  int? get ID => throw _privateConstructorUsedError;
  int? get HEADERID => throw _privateConstructorUsedError;
  String? get TERMDESC => throw _privateConstructorUsedError;
  double? get Percentage => throw _privateConstructorUsedError;
  double? get Amount => throw _privateConstructorUsedError;
  int? get Ordinal => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BillTermModelCopyWith<BillTermModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillTermModelCopyWith<$Res> {
  factory $BillTermModelCopyWith(
          BillTermModel value, $Res Function(BillTermModel) then) =
      _$BillTermModelCopyWithImpl<$Res, BillTermModel>;
  @useResult
  $Res call(
      {int? ID,
      int? HEADERID,
      String? TERMDESC,
      double? Percentage,
      double? Amount,
      int? Ordinal});
}

/// @nodoc
class _$BillTermModelCopyWithImpl<$Res, $Val extends BillTermModel>
    implements $BillTermModelCopyWith<$Res> {
  _$BillTermModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ID = freezed,
    Object? HEADERID = freezed,
    Object? TERMDESC = freezed,
    Object? Percentage = freezed,
    Object? Amount = freezed,
    Object? Ordinal = freezed,
  }) {
    return _then(_value.copyWith(
      ID: freezed == ID
          ? _value.ID
          : ID // ignore: cast_nullable_to_non_nullable
              as int?,
      HEADERID: freezed == HEADERID
          ? _value.HEADERID
          : HEADERID // ignore: cast_nullable_to_non_nullable
              as int?,
      TERMDESC: freezed == TERMDESC
          ? _value.TERMDESC
          : TERMDESC // ignore: cast_nullable_to_non_nullable
              as String?,
      Percentage: freezed == Percentage
          ? _value.Percentage
          : Percentage // ignore: cast_nullable_to_non_nullable
              as double?,
      Amount: freezed == Amount
          ? _value.Amount
          : Amount // ignore: cast_nullable_to_non_nullable
              as double?,
      Ordinal: freezed == Ordinal
          ? _value.Ordinal
          : Ordinal // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BillTermModelImplCopyWith<$Res>
    implements $BillTermModelCopyWith<$Res> {
  factory _$$BillTermModelImplCopyWith(
          _$BillTermModelImpl value, $Res Function(_$BillTermModelImpl) then) =
      __$$BillTermModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? ID,
      int? HEADERID,
      String? TERMDESC,
      double? Percentage,
      double? Amount,
      int? Ordinal});
}

/// @nodoc
class __$$BillTermModelImplCopyWithImpl<$Res>
    extends _$BillTermModelCopyWithImpl<$Res, _$BillTermModelImpl>
    implements _$$BillTermModelImplCopyWith<$Res> {
  __$$BillTermModelImplCopyWithImpl(
      _$BillTermModelImpl _value, $Res Function(_$BillTermModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ID = freezed,
    Object? HEADERID = freezed,
    Object? TERMDESC = freezed,
    Object? Percentage = freezed,
    Object? Amount = freezed,
    Object? Ordinal = freezed,
  }) {
    return _then(_$BillTermModelImpl(
      ID: freezed == ID
          ? _value.ID
          : ID // ignore: cast_nullable_to_non_nullable
              as int?,
      HEADERID: freezed == HEADERID
          ? _value.HEADERID
          : HEADERID // ignore: cast_nullable_to_non_nullable
              as int?,
      TERMDESC: freezed == TERMDESC
          ? _value.TERMDESC
          : TERMDESC // ignore: cast_nullable_to_non_nullable
              as String?,
      Percentage: freezed == Percentage
          ? _value.Percentage
          : Percentage // ignore: cast_nullable_to_non_nullable
              as double?,
      Amount: freezed == Amount
          ? _value.Amount
          : Amount // ignore: cast_nullable_to_non_nullable
              as double?,
      Ordinal: freezed == Ordinal
          ? _value.Ordinal
          : Ordinal // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BillTermModelImpl implements _BillTermModel {
  _$BillTermModelImpl(
      {this.ID,
      this.HEADERID,
      this.TERMDESC,
      this.Percentage,
      this.Amount,
      this.Ordinal});

  factory _$BillTermModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BillTermModelImplFromJson(json);

  @override
  final int? ID;
  @override
  final int? HEADERID;
  @override
  final String? TERMDESC;
  @override
  final double? Percentage;
  @override
  final double? Amount;
  @override
  final int? Ordinal;

  @override
  String toString() {
    return 'BillTermModel(ID: $ID, HEADERID: $HEADERID, TERMDESC: $TERMDESC, Percentage: $Percentage, Amount: $Amount, Ordinal: $Ordinal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillTermModelImpl &&
            (identical(other.ID, ID) || other.ID == ID) &&
            (identical(other.HEADERID, HEADERID) ||
                other.HEADERID == HEADERID) &&
            (identical(other.TERMDESC, TERMDESC) ||
                other.TERMDESC == TERMDESC) &&
            (identical(other.Percentage, Percentage) ||
                other.Percentage == Percentage) &&
            (identical(other.Amount, Amount) || other.Amount == Amount) &&
            (identical(other.Ordinal, Ordinal) || other.Ordinal == Ordinal));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, ID, HEADERID, TERMDESC, Percentage, Amount, Ordinal);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BillTermModelImplCopyWith<_$BillTermModelImpl> get copyWith =>
      __$$BillTermModelImplCopyWithImpl<_$BillTermModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BillTermModelImplToJson(
      this,
    );
  }
}

abstract class _BillTermModel implements BillTermModel {
  factory _BillTermModel(
      {final int? ID,
      final int? HEADERID,
      final String? TERMDESC,
      final double? Percentage,
      final double? Amount,
      final int? Ordinal}) = _$BillTermModelImpl;

  factory _BillTermModel.fromJson(Map<String, dynamic> json) =
      _$BillTermModelImpl.fromJson;

  @override
  int? get ID;
  @override
  int? get HEADERID;
  @override
  String? get TERMDESC;
  @override
  double? get Percentage;
  @override
  double? get Amount;
  @override
  int? get Ordinal;
  @override
  @JsonKey(ignore: true)
  _$$BillTermModelImplCopyWith<_$BillTermModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
