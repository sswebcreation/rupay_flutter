// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BankModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BankModelImpl _$$BankModelImplFromJson(Map<String, dynamic> json) =>
    _$BankModelImpl(
      ID: (json['ID'] as num?)?.toInt(),
      ACCOUNTNAME: json['ACCOUNTNAME'] as String?,
      TXNDATE: json['TXNDATE'] as String?,
      ChequeNo: json['ChequeNo'] as String?,
      Particulars: json['Particulars'] as String?,
      Amount: (json['Amount'] as num?)?.toDouble(),
      DOCNUMBER: json['DOCNUMBER'] as String?,
      ContraAccountName: json['ContraAccountName'] as String?,
      DAYBOOKNAME: json['DAYBOOKNAME'] as String?,
    );

Map<String, dynamic> _$$BankModelImplToJson(_$BankModelImpl instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'ACCOUNTNAME': instance.ACCOUNTNAME,
      'TXNDATE': instance.TXNDATE,
      'ChequeNo': instance.ChequeNo,
      'Particulars': instance.Particulars,
      'Amount': instance.Amount,
      'DOCNUMBER': instance.DOCNUMBER,
      'ContraAccountName': instance.ContraAccountName,
      'DAYBOOKNAME': instance.DAYBOOKNAME,
    };
