// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DeviceModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeviceModelImpl _$$DeviceModelImplFromJson(Map<String, dynamic> json) =>
    _$DeviceModelImpl(
      ID: (json['ID'] as num).toInt(),
      UID: json['UID'] as String,
      IMEI: json['IMEI'] as String,
      MODEL: json['MODEL'] as String,
      OS: json['OS'] as String,
      LOGINAT: json['LOGINAT'] as String,
      UPDATEDAT: json['UPDATEDAT'] as String?,
    );

Map<String, dynamic> _$$DeviceModelImplToJson(_$DeviceModelImpl instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'UID': instance.UID,
      'IMEI': instance.IMEI,
      'MODEL': instance.MODEL,
      'OS': instance.OS,
      'LOGINAT': instance.LOGINAT,
      'UPDATEDAT': instance.UPDATEDAT,
    };
