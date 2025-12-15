// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LedgerListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LedgerListModelImpl _$$LedgerListModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LedgerListModelImpl(
      status: json['status'] as String,
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => LedgerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$LedgerListModelImplToJson(
        _$LedgerListModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
