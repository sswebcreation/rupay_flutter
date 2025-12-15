import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rupay/models/cash/CashModel.dart';

part 'CashListModel.freezed.dart';
part 'CashListModel.g.dart';


@freezed
class CashListModel with _$CashListModel {
  factory CashListModel({
    required String status,
    required int code,
    required String message,
    List<CashModel>? data,
  }) = _CashListModel;

  factory CashListModel.fromJson(JSON json) => _$CashListModelFromJson(json);
}

