// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemModelImpl _$$ItemModelImplFromJson(Map<String, dynamic> json) =>
    _$ItemModelImpl(
      ID: (json['ID'] as num).toInt(),
      UID: json['UID'] as String,
      COCODE: json['COCODE'] as String,
      CODE: json['CODE'] as String,
      NAME: json['NAME'] as String,
      ITEMGROUP: json['ITEMGROUP'] as String,
      HSN: json['HSN'] as String?,
      SAC: json['SAC'] as String?,
      HSNPer: (json['HSNPer'] as num).toDouble(),
      SACPer: (json['SACPer'] as num).toDouble(),
      SALEPRICE: (json['SALEPRICE'] as num?)?.toDouble(),
      PURCHASECOST: (json['PURCHASECOST'] as num?)?.toDouble(),
      BARCODENO: json['BARCODENO'] as String?,
      UNIT: json['UNIT'] as String?,
      RATEPER: (json['RATEPER'] as num?)?.toInt(),
      BALANCEQUANTITY: (json['BALANCEQUANTITY'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$ItemModelImplToJson(_$ItemModelImpl instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'UID': instance.UID,
      'COCODE': instance.COCODE,
      'CODE': instance.CODE,
      'NAME': instance.NAME,
      'ITEMGROUP': instance.ITEMGROUP,
      'HSN': instance.HSN,
      'SAC': instance.SAC,
      'HSNPer': instance.HSNPer,
      'SACPer': instance.SACPer,
      'SALEPRICE': instance.SALEPRICE,
      'PURCHASECOST': instance.PURCHASECOST,
      'BARCODENO': instance.BARCODENO,
      'UNIT': instance.UNIT,
      'RATEPER': instance.RATEPER,
      'BALANCEQUANTITY': instance.BALANCEQUANTITY,
    };
