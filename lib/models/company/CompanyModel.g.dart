// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CompanyModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompanyModelImpl _$$CompanyModelImplFromJson(Map<String, dynamic> json) =>
    _$CompanyModelImpl(
      ID: (json['ID'] as num?)?.toInt(),
      UID: json['UID'] as String,
      CODE: json['CODE'] as String,
      NAME: json['NAME'] as String,
      YEAR: json['YEAR'] as String,
      FROMDATE: json['FROMDATE'] as String,
      TODATE: json['TODATE'] as String,
      PINCODE: (json['PINCODE'] as num).toInt(),
      LOGO: json['LOGO'] as String?,
      MOBILE1: json['MOBILE1'] as String,
      MOBILE2: json['MOBILE2'] as String?,
      EMAIL: json['EMAIL'] as String?,
      BANK1NAME: json['BANK1NAME'] as String?,
      BANK1IFSC: json['BANK1IFSC'] as String?,
      BANK1ACNO: json['BANK1ACNO'] as String?,
      BANK2NAME: json['BANK2NAME'] as String?,
      BANK2IFSC: json['BANK2IFSC'] as String?,
      BANK2ACNO: json['BANK2ACNO'] as String?,
      Q1: json['Q1'] as String?,
      Q2: json['Q2'] as String?,
      Q3: json['Q3'] as String?,
      GSTIN: json['GSTIN'] as String?,
      ADD1: json['ADD1'] as String?,
      ADD2: json['ADD2'] as String?,
      ADD3: json['ADD3'] as String?,
      CITY: json['CITY'] as String?,
      STATE: json['STATE'] as String?,
      TNC: json['TNC'] as String,
      LASTSYNCDATE: json['LASTSYNCDATE'] as String,
    );

Map<String, dynamic> _$$CompanyModelImplToJson(_$CompanyModelImpl instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'UID': instance.UID,
      'CODE': instance.CODE,
      'NAME': instance.NAME,
      'YEAR': instance.YEAR,
      'FROMDATE': instance.FROMDATE,
      'TODATE': instance.TODATE,
      'PINCODE': instance.PINCODE,
      'LOGO': instance.LOGO,
      'MOBILE1': instance.MOBILE1,
      'MOBILE2': instance.MOBILE2,
      'EMAIL': instance.EMAIL,
      'BANK1NAME': instance.BANK1NAME,
      'BANK1IFSC': instance.BANK1IFSC,
      'BANK1ACNO': instance.BANK1ACNO,
      'BANK2NAME': instance.BANK2NAME,
      'BANK2IFSC': instance.BANK2IFSC,
      'BANK2ACNO': instance.BANK2ACNO,
      'Q1': instance.Q1,
      'Q2': instance.Q2,
      'Q3': instance.Q3,
      'GSTIN': instance.GSTIN,
      'ADD1': instance.ADD1,
      'ADD2': instance.ADD2,
      'ADD3': instance.ADD3,
      'CITY': instance.CITY,
      'STATE': instance.STATE,
      'TNC': instance.TNC,
      'LASTSYNCDATE': instance.LASTSYNCDATE,
    };
