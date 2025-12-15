// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VoucherListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VoucherListModelImpl _$$VoucherListModelImplFromJson(
        Map<String, dynamic> json) =>
    _$VoucherListModelImpl(
      status: json['status'] as String,
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => VoucherModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$VoucherListModelImplToJson(
        _$VoucherListModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
