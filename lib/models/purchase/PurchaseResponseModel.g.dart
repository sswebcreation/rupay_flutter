// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PurchaseResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PurchaseResponseModelImpl _$$PurchaseResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PurchaseResponseModelImpl(
      status: json['status'] as String,
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : PurchaseModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PurchaseResponseModelImplToJson(
        _$PurchaseResponseModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
