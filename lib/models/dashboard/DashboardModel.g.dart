// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DashboardModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardModelImpl _$$DashboardModelImplFromJson(Map<String, dynamic> json) =>
    _$DashboardModelImpl(
      SALES: (json['SALES'] as num).toDouble(),
      PURCHASE: (json['PURCHASE'] as num).toDouble(),
      SRETURN: (json['SRETURN'] as num).toDouble(),
      PRETURN: (json['PRETURN'] as num).toDouble(),
      SALESOS: (json['SALESOS'] as num).toDouble(),
      PURCHASEOS: (json['PURCHASEOS'] as num).toDouble(),
      CASH: (json['CASH'] as num).toDouble(),
      BANK: (json['BANK'] as num).toDouble(),
    );

Map<String, dynamic> _$$DashboardModelImplToJson(
        _$DashboardModelImpl instance) =>
    <String, dynamic>{
      'SALES': instance.SALES,
      'PURCHASE': instance.PURCHASE,
      'SRETURN': instance.SRETURN,
      'PRETURN': instance.PRETURN,
      'SALESOS': instance.SALESOS,
      'PURCHASEOS': instance.PURCHASEOS,
      'CASH': instance.CASH,
      'BANK': instance.BANK,
    };
