// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ScreenCodeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScreenCodeModelImpl _$$ScreenCodeModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ScreenCodeModelImpl(
      id: (json['id'] as num).toInt(),
      code: json['code'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$ScreenCodeModelImplToJson(
        _$ScreenCodeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
    };
