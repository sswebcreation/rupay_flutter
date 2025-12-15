import 'package:rupay/models/account/AccountModel.dart';
import 'package:rupay/models/daybook/DaybookModel.dart';
import 'package:rupay/models/item/ItemModel.dart';
import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rupay/models/sales/SalesModel.dart';
part 'SalesValueModel.freezed.dart';
part 'SalesValueModel.g.dart';


@freezed
class SalesValueModel with _$SalesValueModel {
  factory SalesValueModel({
    required String status,
    required int code,
    required String message,
    String? data,
    List<DaybookModel>? daybooks,
    List<AccountModel>? parties,
    List<ItemModel>? items,
  }) = _SalesValueModel;

  factory SalesValueModel.fromJson(JSON json) => _$SalesValueModelFromJson(json);
}

