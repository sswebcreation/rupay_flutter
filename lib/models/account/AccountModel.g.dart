// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AccountModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountModelImpl _$$AccountModelImplFromJson(Map<String, dynamic> json) =>
    _$AccountModelImpl(
      ID: (json['ID'] as num).toInt(),
      UID: json['UID'] as String,
      COCODE: json['COCODE'] as String,
      CODE: json['CODE'] as String,
      NAME: json['NAME'] as String,
      GLGROUPCODE: json['GLGROUPCODE'] as String,
      GLGROUP: json['GLGROUP'] as String,
      ADD1: json['ADD1'] as String,
      ADD2: json['ADD2'] as String,
      PINCODE: json['PINCODE'] as String,
      CITY: json['CITY'] as String,
      STATE: json['STATE'] as String,
      GSTIN: json['GSTIN'] as String,
      MOBILE: json['MOBILE'] as String,
      EMAIL: json['EMAIL'] as String,
      AREACODE: json['AREACODE'] as String,
      AREANAME: json['AREANAME'] as String,
      BROKER: json['BROKER'] as String,
      BALANCE: (json['BALANCE'] as num).toDouble(),
      TYP: (json['TYP'] as num).toInt(),
      TYPCAPTION: json['TYPCAPTION'] as String,
      ISBLACKLIST: (json['ISBLACKLIST'] as num).toInt(),
      STATUS: (json['STATUS'] as num).toInt(),
    );

Map<String, dynamic> _$$AccountModelImplToJson(_$AccountModelImpl instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'UID': instance.UID,
      'COCODE': instance.COCODE,
      'CODE': instance.CODE,
      'NAME': instance.NAME,
      'GLGROUPCODE': instance.GLGROUPCODE,
      'GLGROUP': instance.GLGROUP,
      'ADD1': instance.ADD1,
      'ADD2': instance.ADD2,
      'PINCODE': instance.PINCODE,
      'CITY': instance.CITY,
      'STATE': instance.STATE,
      'GSTIN': instance.GSTIN,
      'MOBILE': instance.MOBILE,
      'EMAIL': instance.EMAIL,
      'AREACODE': instance.AREACODE,
      'AREANAME': instance.AREANAME,
      'BROKER': instance.BROKER,
      'BALANCE': instance.BALANCE,
      'TYP': instance.TYP,
      'TYPCAPTION': instance.TYPCAPTION,
      'ISBLACKLIST': instance.ISBLACKLIST,
      'STATUS': instance.STATUS,
    };
