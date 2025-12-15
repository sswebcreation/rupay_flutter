import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rupay/models/ledger/LedgerModel.dart';

part 'LedgerListModel.freezed.dart';
part 'LedgerListModel.g.dart';


@freezed
class LedgerListModel with _$LedgerListModel {
  factory LedgerListModel({
    required String status,
    required int code,
    required String message,
    List<LedgerModel>? data,
  }) = _LedgerListModel;

  factory LedgerListModel.fromJson(JSON json) => _$LedgerListModelFromJson(json);
}

