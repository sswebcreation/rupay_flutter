// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BankListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BankListModelImpl _$$BankListModelImplFromJson(Map<String, dynamic> json) =>
    _$BankListModelImpl(
      status: json['status'] as String,
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BankModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$BankListModelImplToJson(_$BankListModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
