import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ProductModel.freezed.dart';
part 'ProductModel.g.dart';


@freezed
class ProductModel with _$ProductModel {
  factory ProductModel({
    required int id,
    required String category,
    required int cat_id,
    required int subcat,
    required String company,
    required String model,
    required String name,
    required int price,
    required int share,
    double? lat,
    double? lon,
    required String end_date,
    required int qty,
    required int status,
    required int sold,
    required int approved,
    required String image,
    required int cus_id,
    required String SubCategory,
    required String Owner,
    required int fav,
    required int feature,
    required String created_at,
  }) = _ProductModel;

  factory ProductModel.fromJson(JSON json) => _$ProductModelFromJson(json);
}
