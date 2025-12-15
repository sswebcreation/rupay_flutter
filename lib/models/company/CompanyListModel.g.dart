// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CompanyListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompanyListModelImpl _$$CompanyListModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CompanyListModelImpl(
      status: json['status'] as String,
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CompanyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CompanyListModelImplToJson(
        _$CompanyListModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
