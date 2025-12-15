import 'package:rupay/models/account/AccountModel.dart';
import 'package:rupay/models/daybook/DaybookModel.dart';
import 'package:rupay/models/item/ItemModel.dart';
import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'CashValueModel.freezed.dart';
part 'CashValueModel.g.dart';


@freezed
class CashValueModel with _$CashValueModel {
  factory CashValueModel({
    required String status,
    required int code,
    required String message,
    String? data,
    List<DaybookModel>? daybooks,
    List<AccountModel>? parties,
  }) = _CashValueModel;

  factory CashValueModel.fromJson(JSON json) => _$CashValueModelFromJson(json);
}

