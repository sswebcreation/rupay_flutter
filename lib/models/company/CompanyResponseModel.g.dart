// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CompanyResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompanyResponseModelImpl _$$CompanyResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CompanyResponseModelImpl(
      status: json['status'] as String,
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : CompanyModel.fromJson(json['data'] as Map<String, dynamic>),
      dashboard: json['dashboard'] == null
          ? null
          : DashboardModel.fromJson(json['dashboard'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CompanyResponseModelImplToJson(
        _$CompanyResponseModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
      'dashboard': instance.dashboard,
    };
