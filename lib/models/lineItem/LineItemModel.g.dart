// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LineItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LineItemModelImpl _$$LineItemModelImplFromJson(Map<String, dynamic> json) =>
    _$LineItemModelImpl(
      ID: (json['ID'] as num?)?.toInt(),
      HEADERID: (json['HEADERID'] as num?)?.toInt(),
      ITEMCODE: json['ITEMCODE'] as String?,
      ITEMNAME: json['ITEMNAME'] as String?,
      SCREENNAME: json['SCREENNAME'] as String?,
      Remarks: json['Remarks'] as String?,
      Notes: json['Notes'] as String?,
      QTY1: (json['QTY1'] as num?)?.toDouble(),
      QTY2: (json['QTY2'] as num?)?.toDouble(),
      QTY3: (json['QTY3'] as num?)?.toDouble(),
      ITEMRATE: (json['ITEMRATE'] as num?)?.toDouble(),
      AMOUNT: (json['AMOUNT'] as num?)?.toDouble(),
      NETAMOUNT: (json['NETAMOUNT'] as num?)?.toDouble(),
      HSN: json['HSN'] as String?,
      TAXABLEVALUE: (json['TAXABLEVALUE'] as num?)?.toDouble(),
      GSTPERCENT: (json['GSTPERCENT'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$LineItemModelImplToJson(_$LineItemModelImpl instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'HEADERID': instance.HEADERID,
      'ITEMCODE': instance.ITEMCODE,
      'ITEMNAME': instance.ITEMNAME,
      'SCREENNAME': instance.SCREENNAME,
      'Remarks': instance.Remarks,
      'Notes': instance.Notes,
      'QTY1': instance.QTY1,
      'QTY2': instance.QTY2,
      'QTY3': instance.QTY3,
      'ITEMRATE': instance.ITEMRATE,
      'AMOUNT': instance.AMOUNT,
      'NETAMOUNT': instance.NETAMOUNT,
      'HSN': instance.HSN,
      'TAXABLEVALUE': instance.TAXABLEVALUE,
      'GSTPERCENT': instance.GSTPERCENT,
    };
