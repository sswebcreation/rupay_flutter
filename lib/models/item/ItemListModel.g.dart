// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ItemListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemListModelImpl _$$ItemListModelImplFromJson(Map<String, dynamic> json) =>
    _$ItemListModelImpl(
      status: json['status'] as String,
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ItemListModelImplToJson(_$ItemListModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
