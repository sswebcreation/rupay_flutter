// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DaybookListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DaybookListModelImpl _$$DaybookListModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DaybookListModelImpl(
      status: json['status'] as String,
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DaybookModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DaybookListModelImplToJson(
        _$DaybookListModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
