// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ScreenCodeListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScreenCodeListModelImpl _$$ScreenCodeListModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ScreenCodeListModelImpl(
      status: json['status'] as String,
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ScreenCodeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ScreenCodeListModelImplToJson(
        _$ScreenCodeListModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
