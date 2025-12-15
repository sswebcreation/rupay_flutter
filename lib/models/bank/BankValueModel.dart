import 'package:rupay/models/account/AccountModel.dart';
import 'package:rupay/models/daybook/DaybookModel.dart';
import 'package:rupay/models/item/ItemModel.dart';
import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'BankValueModel.freezed.dart';
part 'BankValueModel.g.dart';


@freezed
class BankValueModel with _$BankValueModel {
  factory BankValueModel({
    required String status,
    required int code,
    required String message,
    String? data,
    List<DaybookModel>? daybooks,
    List<AccountModel>? parties,
  }) = _BankValueModel;

  factory BankValueModel.fromJson(JSON json) => _$BankValueModelFromJson(json);
}

