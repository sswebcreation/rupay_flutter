// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SalesListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SalesListModelImpl _$$SalesListModelImplFromJson(Map<String, dynamic> json) =>
    _$SalesListModelImpl(
      status: json['status'] as String,
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SalesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SalesListModelImplToJson(
        _$SalesListModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
