// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'DaybookModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DaybookModel _$DaybookModelFromJson(Map<String, dynamic> json) {
  return _DaybookModel.fromJson(json);
}

/// @nodoc
mixin _$DaybookModel {
  String get DAYBOOK => throw _privateConstructorUsedError;
  String get CODE => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DaybookModelCopyWith<DaybookModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DaybookModelCopyWith<$Res> {
  factory $DaybookModelCopyWith(
          DaybookModel value, $Res Function(DaybookModel) then) =
      _$DaybookModelCopyWithImpl<$Res, DaybookModel>;
  @useResult
  $Res call({String DAYBOOK, String CODE});
}

/// @nodoc
class _$DaybookModelCopyWithImpl<$Res, $Val extends DaybookModel>
    implements $DaybookModelCopyWith<$Res> {
  _$DaybookModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? DAYBOOK = null,
    Object? CODE = null,
  }) {
    return _then(_value.copyWith(
      DAYBOOK: null == DAYBOOK
          ? _value.DAYBOOK
          : DAYBOOK // ignore: cast_nullable_to_non_nullable
              as String,
      CODE: null == CODE
          ? _value.CODE
          : CODE // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DaybookModelImplCopyWith<$Res>
    implements $DaybookModelCopyWith<$Res> {
  factory _$$DaybookModelImplCopyWith(
          _$DaybookModelImpl value, $Res Function(_$DaybookModelImpl) then) =
      __$$DaybookModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String DAYBOOK, String CODE});
}

/// @nodoc
class __$$DaybookModelImplCopyWithImpl<$Res>
    extends _$DaybookModelCopyWithImpl<$Res, _$DaybookModelImpl>
    implements _$$DaybookModelImplCopyWith<$Res> {
  __$$DaybookModelImplCopyWithImpl(
      _$DaybookModelImpl _value, $Res Function(_$DaybookModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? DAYBOOK = null,
    Object? CODE = null,
  }) {
    return _then(_$DaybookModelImpl(
      DAYBOOK: null == DAYBOOK
          ? _value.DAYBOOK
          : DAYBOOK // ignore: cast_nullable_to_non_nullable
              as String,
      CODE: null == CODE
          ? _value.CODE
          : CODE // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DaybookModelImpl implements _DaybookModel {
  _$DaybookModelImpl({required this.DAYBOOK, required this.CODE});

  factory _$DaybookModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DaybookModelImplFromJson(json);

  @override
  final String DAYBOOK;
  @override
  final String CODE;

  @override
  String toString() {
    return 'DaybookModel(DAYBOOK: $DAYBOOK, CODE: $CODE)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DaybookModelImpl &&
            (identical(other.DAYBOOK, DAYBOOK) || other.DAYBOOK == DAYBOOK) &&
            (identical(other.CODE, CODE) || other.CODE == CODE));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, DAYBOOK, CODE);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DaybookModelImplCopyWith<_$DaybookModelImpl> get copyWith =>
      __$$DaybookModelImplCopyWithImpl<_$DaybookModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DaybookModelImplToJson(
      this,
    );
  }
}

abstract class _DaybookModel implements DaybookModel {
  factory _DaybookModel(
      {required final String DAYBOOK,
      required final String CODE}) = _$DaybookModelImpl;

  factory _DaybookModel.fromJson(Map<String, dynamic> json) =
      _$DaybookModelImpl.fromJson;

  @override
  String get DAYBOOK;
  @override
  String get CODE;
  @override
  @JsonKey(ignore: true)
  _$$DaybookModelImplCopyWith<_$DaybookModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
