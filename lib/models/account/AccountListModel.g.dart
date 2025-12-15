// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AccountListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountListModelImpl _$$AccountListModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AccountListModelImpl(
      status: json['status'] as String,
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AccountModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AccountListModelImplToJson(
        _$AccountListModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
