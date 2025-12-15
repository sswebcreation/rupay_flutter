// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductModelImpl _$$ProductModelImplFromJson(Map<String, dynamic> json) =>
    _$ProductModelImpl(
      id: (json['id'] as num).toInt(),
      category: json['category'] as String,
      cat_id: (json['cat_id'] as num).toInt(),
      subcat: (json['subcat'] as num).toInt(),
      company: json['company'] as String,
      model: json['model'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toInt(),
      share: (json['share'] as num).toInt(),
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      end_date: json['end_date'] as String,
      qty: (json['qty'] as num).toInt(),
      status: (json['status'] as num).toInt(),
      sold: (json['sold'] as num).toInt(),
      approved: (json['approved'] as num).toInt(),
      image: json['image'] as String,
      cus_id: (json['cus_id'] as num).toInt(),
      SubCategory: json['SubCategory'] as String,
      Owner: json['Owner'] as String,
      fav: (json['fav'] as num).toInt(),
      feature: (json['feature'] as num).toInt(),
      created_at: json['created_at'] as String,
    );

Map<String, dynamic> _$$ProductModelImplToJson(_$ProductModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'cat_id': instance.cat_id,
      'subcat': instance.subcat,
      'company': instance.company,
      'model': instance.model,
      'name': instance.name,
      'price': instance.price,
      'share': instance.share,
      'lat': instance.lat,
      'lon': instance.lon,
      'end_date': instance.end_date,
      'qty': instance.qty,
      'status': instance.status,
      'sold': instance.sold,
      'approved': instance.approved,
      'image': instance.image,
      'cus_id': instance.cus_id,
      'SubCategory': instance.SubCategory,
      'Owner': instance.Owner,
      'fav': instance.fav,
      'feature': instance.feature,
      'created_at': instance.created_at,
    };
