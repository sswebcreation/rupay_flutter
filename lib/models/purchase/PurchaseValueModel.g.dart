// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PurchaseValueModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PurchaseValueModelImpl _$$PurchaseValueModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PurchaseValueModelImpl(
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
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PurchaseValueModelImplToJson(
        _$PurchaseValueModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
      'daybooks': instance.daybooks,
      'parties': instance.parties,
      'items': instance.items,
    };
