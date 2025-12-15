import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rupay/models/bank/BankModel.dart';

part 'BankListModel.freezed.dart';
part 'BankListModel.g.dart';


@freezed
class BankListModel with _$BankListModel {
  factory BankListModel({
    required String status,
    required int code,
    required String message,
    List<BankModel>? data,
  }) = _BankListModel;

  factory BankListModel.fromJson(JSON json) => _$BankListModelFromJson(json);
}

