import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rupay/models/purchase/PurchaseModel.dart';
part 'PurchaseListModel.freezed.dart';
part 'PurchaseListModel.g.dart';


@freezed
class PurchaseListModel with _$PurchaseListModel {
  factory PurchaseListModel({
    required String status,
    required int code,
    required String message,
    List<PurchaseModel>? data,
  }) = _PurchaseListModel;

  factory PurchaseListModel.fromJson(JSON json) => _$PurchaseListModelFromJson(json);
}

