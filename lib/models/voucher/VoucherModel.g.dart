// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VoucherModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VoucherModelImpl _$$VoucherModelImplFromJson(Map<String, dynamic> json) =>
    _$VoucherModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      cat_id: (json['cat_id'] as num).toInt(),
      category: json['category'] as String,
    );

Map<String, dynamic> _$$VoucherModelImplToJson(_$VoucherModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cat_id': instance.cat_id,
      'category': instance.category,
    };
