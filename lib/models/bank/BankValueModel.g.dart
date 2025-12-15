// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BankValueModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BankValueModelImpl _$$BankValueModelImplFromJson(Map<String, dynamic> json) =>
    _$BankValueModelImpl(
      status: json['status'] as String,
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'] as String?,
      daybooks: (json['daybooks'] as List<dynamic>?)
          ?.map((e) => DaybookModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      parties: (json['parties'] as List<dynamic>?)
          ?.map((e) => AccountModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$BankValueModelImplToJson(
        _$BankValueModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
      'daybooks': instance.daybooks,
      'parties': instance.parties,
    };
