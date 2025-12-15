import 'package:rupay/models/adsTxn/AdsTxnModel.dart';
import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rupay/models/product/ProductModel.dart';

part 'ProductListModel.freezed.dart';
part 'ProductListModel.g.dart';


@freezed
class ProductListModel with _$ProductListModel {
  factory ProductListModel({
    required String status,
    required int code,
    required String message,
    List<ProductModel>? products,
    List<AdsTxnModel>? ads,
  }) = _ProductListModel;

  factory ProductListModel.fromJson(JSON json) => _$ProductListModelFromJson(json);
}

