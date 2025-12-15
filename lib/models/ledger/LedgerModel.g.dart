// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LedgerModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LedgerModelImpl _$$LedgerModelImplFromJson(Map<String, dynamic> json) =>
    _$LedgerModelImpl(
      ID: (json['ID'] as num?)?.toInt(),
      UID: json['UID'] as String?,
      COCODE: json['COCODE'] as String?,
      ACCOUNTCODE: json['ACCOUNTCODE'] as String?,
      ACCOUNTNAME: json['ACCOUNTNAME'] as String?,
      DOCNUMBER: json['DOCNUMBER'] as String?,
      TXNDATE: json['TXNDATE'] as String?,
      DOCNUMBER1: json['DOCNUMBER1'] as String?,
      DAYBOOKCODE: json['DAYBOOKCODE'] as String?,
      DAYBOOKNAME: json['DAYBOOKNAME'] as String?,
      DAYBOOKTYPE: (json['DAYBOOKTYPE'] as num?)?.toInt(),
      DayBookAccountName: json['DayBookAccountName'] as String?,
      ChequeNo: json['ChequeNo'] as String?,
      ChequeDate: json['ChequeDate'] as String?,
      ContraAccountName: json['ContraAccountName'] as String?,
      Particulars: json['Particulars'] as String?,
      Amount: (json['Amount'] as num?)?.toDouble(),
      ADD1: json['ADD1'] as String?,
      ADD2: json['ADD2'] as String?,
      PINCODE: json['PINCODE'] as String?,
      CITY: json['CITY'] as String?,
      GSTIN: json['GSTIN'] as String?,
      MOBILE: json['MOBILE'] as String?,
    );

Map<String, dynamic> _$$LedgerModelImplToJson(_$LedgerModelImpl instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'UID': instance.UID,
      'COCODE': instance.COCODE,
      'ACCOUNTCODE': instance.ACCOUNTCODE,
      'ACCOUNTNAME': instance.ACCOUNTNAME,
      'DOCNUMBER': instance.DOCNUMBER,
      'TXNDATE': instance.TXNDATE,
      'DOCNUMBER1': instance.DOCNUMBER1,
      'DAYBOOKCODE': instance.DAYBOOKCODE,
      'DAYBOOKNAME': instance.DAYBOOKNAME,
      'DAYBOOKTYPE': instance.DAYBOOKTYPE,
      'DayBookAccountName': instance.DayBookAccountName,
      'ChequeNo': instance.ChequeNo,
      'ChequeDate': instance.ChequeDate,
      'ContraAccountName': instance.ContraAccountName,
      'Particulars': instance.Particulars,
      'Amount': instance.Amount,
      'ADD1': instance.ADD1,
      'ADD2': instance.ADD2,
      'PINCODE': instance.PINCODE,
      'CITY': instance.CITY,
      'GSTIN': instance.GSTIN,
      'MOBILE': instance.MOBILE,
    };
