import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'CashModel.freezed.dart';
part 'CashModel.g.dart';


@freezed
class CashModel with _$CashModel {
  factory CashModel({
    int? ID,
    String? ACCOUNTNAME,
    String? TXNDATE,
    String? ChequeNo,
    String? Particulars,
    double? Amount,
    String? DOCNUMBER,
    String? ContraAccountName,
    String? DAYBOOKNAME,
  }) = _CashModel;

  factory CashModel.fromJson(JSON json) => _$CashModelFromJson(json);
}
