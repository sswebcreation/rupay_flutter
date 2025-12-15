// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AdsTxnListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdsTxnListModelImpl _$$AdsTxnListModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AdsTxnListModelImpl(
      status: json['status'] as String,
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      adsTxn: (json['adsTxn'] as List<dynamic>?)
          ?.map((e) => AdsTxnModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AdsTxnListModelImplToJson(
        _$AdsTxnListModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'adsTxn': instance.adsTxn,
    };
