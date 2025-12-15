import 'package:rupay/models/lineItem/LineItemModel.dart';
import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'PurchaseModel.freezed.dart';
part 'PurchaseModel.g.dart';


@freezed
class PurchaseModel with _$PurchaseModel {
  factory PurchaseModel({
    int? ID,
    String? UID,
    String? COCODE,
    String? DOCNUMBER,
    String? TXNDATE,
    String? PARTYBILLNO,
    String? PARTYBILLDATE,
    String? DAYBOOK,
    String? ACCOUNTCODE,
    String? ACCOUNTNAME,
    double? GROSSAMT,
    double? TAXABLEAMT,
    double? GST,
    double? NETAMOUNT,
    double? RECAMT,
    String? PendingStatus,
    int? DocumentID,
    String? BROKERCODE,
    String? BILLTERM,
    String? DeliveryCode,
    String? StateOfSupply,
    String? STATENAME,
    double? GSTAmount,
    double? DUEDAYS,
    String? ADD1,
    String? ADD2,
    String? PINCODE,
    String? CITY,
    String? GSTIN,
    String? MOBILE,
    String? DNAME,
    String? DADD1,
    String? DADD2,
    String? DPINCODE,
    String? DCITY,
    String? DGSTIN,
    String? DMOBILE,
    String? BROKERNAME,
    String? LINEITEM,
    String? ITEMS,
    String? Q1,
    String? Q2,
    String? Q3,
    String? ORIGINALBILLNO,
    String? ORIGINALBILLDT,
    LineItemModel? item,
  }) = _PurchaseModel;

  factory PurchaseModel.fromJson(JSON json) => _$PurchaseModelFromJson(json);
}

