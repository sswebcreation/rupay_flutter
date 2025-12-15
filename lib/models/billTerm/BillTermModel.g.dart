// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BillTermModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BillTermModelImpl _$$BillTermModelImplFromJson(Map<String, dynamic> json) =>
    _$BillTermModelImpl(
      ID: (json['ID'] as num?)?.toInt(),
      HEADERID: (json['HEADERID'] as num?)?.toInt(),
      TERMDESC: json['TERMDESC'] as String?,
      Percentage: (json['Percentage'] as num?)?.toDouble(),
      Amount: (json['Amount'] as num?)?.toDouble(),
      Ordinal: (json['Ordinal'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$BillTermModelImplToJson(_$BillTermModelImpl instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'HEADERID': instance.HEADERID,
      'TERMDESC': instance.TERMDESC,
      'Percentage': instance.Percentage,
      'Amount': instance.Amount,
      'Ordinal': instance.Ordinal,
    };
