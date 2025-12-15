// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SalesResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SalesResponseModelImpl _$$SalesResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SalesResponseModelImpl(
      status: json['status'] as String,
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : SalesModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SalesResponseModelImplToJson(
        _$SalesResponseModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
