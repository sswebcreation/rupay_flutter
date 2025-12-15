import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'OutstandingModel.freezed.dart';
part 'OutstandingModel.g.dart';


@freezed
class OutstandingModel with _$OutstandingModel {
  factory OutstandingModel({
    int? ID,
    String? UID,
    String? COCODE,
    String? TYP,
    String? OSTypeName,
    String? AccountAddress,
    String? TrSourceCity,
    int? OSType,
    String? DaybookCodeID,
    String? TxnDate,
    String? DaybookCode,
    String? DocNumber,
    String? DocumentNumber,
    String? DocumentDate,
    String? DocNo,
    String? AccountCode,
    String? AccountName,
    String? BillRemarks,
    String? BrokerNAme,
    String? DueDate,
    int? DueDays,
    int? TxnDays,
    String? DeliveryName,
    double? BasicAmount,
    double? NetAmount,
    double? OtherAmount1,
    String? ChequeDate,
    String? AdjTxnDate,
    String? AdjDaybookCode,
    String? BankCode,
    String? ChequeNo,
    double? ReturnAdjAmount,
    double? OtherAdjAmount,
    double? AdjustedAmount,
    double? ReturnTotalAdjAmount,
    double? OtherTotalAdjAmount,
    double? TotalAdjAmount,
    double? BalanceAmount,
    double? NetOSAmount,
    String? ADD1,
    String? ADD2,
    String? PINCODE,
    String? CITY,
    String? GSTIN,
    String? MOBILE,
  }) = _OutstandingModel;

  factory OutstandingModel.fromJson(JSON json) => _$OutstandingModelFromJson(json);
}
