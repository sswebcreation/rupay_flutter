import 'package:rupay/models/account/AccountModel.dart';
import 'package:rupay/models/daybook/DaybookModel.dart';
import 'package:rupay/models/item/ItemModel.dart';
import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'PurchaseValueModel.freezed.dart';
part 'PurchaseValueModel.g.dart';


@freezed
class PurchaseValueModel with _$PurchaseValueModel {
  factory PurchaseValueModel({
    required String status,
    required int code,
    required String message,
    String? data,
    List<DaybookModel>? daybooks,
    List<AccountModel>? parties,
    List<ItemModel>? items,
  }) = _PurchaseValueModel;

  factory PurchaseValueModel.fromJson(JSON json) => _$PurchaseValueModelFromJson(json);
}

