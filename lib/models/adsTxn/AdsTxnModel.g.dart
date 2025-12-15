// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AdsTxnModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdsTxnModelImpl _$$AdsTxnModelImplFromJson(Map<String, dynamic> json) =>
    _$AdsTxnModelImpl(
      id: (json['id'] as num).toInt(),
      image: json['image'] as String,
      cus_id: (json['cus_id'] as num).toInt(),
      cat_id: (json['cat_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$AdsTxnModelImplToJson(_$AdsTxnModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'cus_id': instance.cus_id,
      'cat_id': instance.cat_id,
    };
