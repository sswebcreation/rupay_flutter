import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'LedgerModel.freezed.dart';
part 'LedgerModel.g.dart';


@freezed
class LedgerModel with _$LedgerModel {
  factory LedgerModel({
    int? ID,
    String? UID,
    String? COCODE,
    String? ACCOUNTCODE,
    String? ACCOUNTNAME,
    String? DOCNUMBER,
    String? TXNDATE,
    String? DOCNUMBER1,
    String? DAYBOOKCODE,
    String? DAYBOOKNAME,
    int? DAYBOOKTYPE,
    String? DayBookAccountName,
    String? ChequeNo,
    String? ChequeDate,
    String? ContraAccountName,
    String? Particulars,
    double? Amount,
    String? ADD1,
    String? ADD2,
    String? PINCODE,
    String? CITY,
    String? GSTIN,
    String? MOBILE,
  }) = _LedgerModel;

  factory LedgerModel.fromJson(JSON json) => _$LedgerModelFromJson(json);
}
