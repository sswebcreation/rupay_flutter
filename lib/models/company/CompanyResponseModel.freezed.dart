// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'CompanyResponseModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CompanyResponseModel _$CompanyResponseModelFromJson(Map<String, dynamic> json) {
  return _CompanyResponseModel.fromJson(json);
}

/// @nodoc
mixin _$CompanyResponseModel {
  String get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  CompanyModel? get data => throw _privateConstructorUsedError;
  DashboardModel? get dashboard => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompanyResponseModelCopyWith<CompanyResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyResponseModelCopyWith<$Res> {
  factory $CompanyResponseModelCopyWith(CompanyResponseModel value,
          $Res Function(CompanyResponseModel) then) =
      _$CompanyResponseModelCopyWithImpl<$Res, CompanyResponseModel>;
  @useResult
  $Res call(
      {String status,
      int code,
      String message,
      CompanyModel? data,
      DashboardModel? dashboard});

  $CompanyModelCopyWith<$Res>? get data;
  $DashboardModelCopyWith<$Res>? get dashboard;
}

/// @nodoc
class _$CompanyResponseModelCopyWithImpl<$Res,
        $Val extends CompanyResponseModel>
    implements $CompanyResponseModelCopyWith<$Res> {
  _$CompanyResponseModelCopyWithImpl(this._value, this._then);

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
    Object? dashboard = freezed,
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
              as CompanyModel?,
      dashboard: freezed == dashboard
          ? _value.dashboard
          : dashboard // ignore: cast_nullable_to_non_nullable
              as DashboardModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CompanyModelCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $CompanyModelCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DashboardModelCopyWith<$Res>? get dashboard {
    if (_value.dashboard == null) {
      return null;
    }

    return $DashboardModelCopyWith<$Res>(_value.dashboard!, (value) {
      return _then(_value.copyWith(dashboard: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CompanyResponseModelImplCopyWith<$Res>
    implements $CompanyResponseModelCopyWith<$Res> {
  factory _$$CompanyResponseModelImplCopyWith(_$CompanyResponseModelImpl value,
          $Res Function(_$CompanyResponseModelImpl) then) =
      __$$CompanyResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String status,
      int code,
      String message,
      CompanyModel? data,
      DashboardModel? dashboard});

  @override
  $CompanyModelCopyWith<$Res>? get data;
  @override
  $DashboardModelCopyWith<$Res>? get dashboard;
}

/// @nodoc
class __$$CompanyResponseModelImplCopyWithImpl<$Res>
    extends _$CompanyResponseModelCopyWithImpl<$Res, _$CompanyResponseModelImpl>
    implements _$$CompanyResponseModelImplCopyWith<$Res> {
  __$$CompanyResponseModelImplCopyWithImpl(_$CompanyResponseModelImpl _value,
      $Res Function(_$CompanyResponseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
    Object? dashboard = freezed,
  }) {
    return _then(_$CompanyResponseModelImpl(
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
              as CompanyModel?,
      dashboard: freezed == dashboard
          ? _value.dashboard
          : dashboard // ignore: cast_nullable_to_non_nullable
              as DashboardModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompanyResponseModelImpl implements _CompanyResponseModel {
  _$CompanyResponseModelImpl(
      {required this.status,
      required this.code,
      required this.message,
      this.data,
      this.dashboard});

  factory _$CompanyResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompanyResponseModelImplFromJson(json);

  @override
  final String status;
  @override
  final int code;
  @override
  final String message;
  @override
  final CompanyModel? data;
  @override
  final DashboardModel? dashboard;

  @override
  String toString() {
    return 'CompanyResponseModel(status: $status, code: $code, message: $message, data: $data, dashboard: $dashboard)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompanyResponseModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.dashboard, dashboard) ||
                other.dashboard == dashboard));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, status, code, message, data, dashboard);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CompanyResponseModelImplCopyWith<_$CompanyResponseModelImpl>
      get copyWith =>
          __$$CompanyResponseModelImplCopyWithImpl<_$CompanyResponseModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompanyResponseModelImplToJson(
      this,
    );
  }
}

abstract class _CompanyResponseModel implements CompanyResponseModel {
  factory _CompanyResponseModel(
      {required final String status,
      required final int code,
      required final String message,
      final CompanyModel? data,
      final DashboardModel? dashboard}) = _$CompanyResponseModelImpl;

  factory _CompanyResponseModel.fromJson(Map<String, dynamic> json) =
      _$CompanyResponseModelImpl.fromJson;

  @override
  String get status;
  @override
  int get code;
  @override
  String get message;
  @override
  CompanyModel? get data;
  @override
  DashboardModel? get dashboard;
  @override
  @JsonKey(ignore: true)
  _$$CompanyResponseModelImplCopyWith<_$CompanyResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
