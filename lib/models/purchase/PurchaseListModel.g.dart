// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PurchaseListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PurchaseListModelImpl _$$PurchaseListModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PurchaseListModelImpl(
      status: json['status'] as String,
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PurchaseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PurchaseListModelImplToJson(
        _$PurchaseListModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
