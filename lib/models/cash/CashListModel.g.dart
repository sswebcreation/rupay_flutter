// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CashListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CashListModelImpl _$$CashListModelImplFromJson(Map<String, dynamic> json) =>
    _$CashListModelImpl(
      status: json['status'] as String,
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CashModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CashListModelImplToJson(_$CashListModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
