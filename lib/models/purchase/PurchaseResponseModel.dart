import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rupay/models/purchase/PurchaseModel.dart';
part 'PurchaseResponseModel.freezed.dart';
part 'PurchaseResponseModel.g.dart';


@freezed
class PurchaseResponseModel with _$PurchaseResponseModel {
  factory PurchaseResponseModel({
    required String status,
    required int code,
    required String message,
    PurchaseModel? data,
  }) = _PurchaseResponseModel;

  factory PurchaseResponseModel.fromJson(JSON json) => _$PurchaseResponseModelFromJson(json);
}

