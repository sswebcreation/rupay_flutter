// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DeviceListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeviceListModelImpl _$$DeviceListModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DeviceListModelImpl(
      status: json['status'] as String,
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DeviceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DeviceListModelImplToJson(
        _$DeviceListModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
