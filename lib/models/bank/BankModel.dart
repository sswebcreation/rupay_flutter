import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'BankModel.freezed.dart';
part 'BankModel.g.dart';


@freezed
class BankModel with _$BankModel {
  factory BankModel({
    int? ID,
    String? ACCOUNTNAME,
    String? TXNDATE,
    String? ChequeNo,
    String? Particulars,
    double? Amount,
    String? DOCNUMBER,
    String? ContraAccountName,
    String? DAYBOOKNAME,
  }) = _BankModel;

  factory BankModel.fromJson(JSON json) => _$BankModelFromJson(json);
}
