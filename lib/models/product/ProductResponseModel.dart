import 'package:rupay/models/image/ImageModel.dart';
import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rupay/models/product/ProductModel.dart';

part 'ProductResponseModel.freezed.dart';
part 'ProductResponseModel.g.dart';


@freezed
class ProductResponseModel with _$ProductResponseModel {
  factory ProductResponseModel({
    required String status,
    required int code,
    required String message,
    ProductModel? product,
    List<ImageModel>? images,
    // List<AdsTxnModel>? ads,
  }) = _ProductResponseModel;

  factory ProductResponseModel.fromJson(JSON json) => _$ProductResponseModelFromJson(json);
}

