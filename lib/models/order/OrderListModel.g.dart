// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderListModelImpl _$$OrderListModelImplFromJson(Map<String, dynamic> json) =>
    _$OrderListModelImpl(
      status: json['status'] as String,
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$OrderListModelImplToJson(
        _$OrderListModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
