import 'package:rupay/models/lineItem/LineItemModel.dart';
import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'SalesModel.freezed.dart';
part 'SalesModel.g.dart';


@freezed
class SalesModel with _$SalesModel {
  factory SalesModel({
    int? ID,
    String? UID,
    String? COCODE,
    String? DOCNUMBER,
    String? TXNDATE,
    String? ORIGINALBILLNO,
    String? ORIGINALBILLDT,
    String? DAYBOOK,
    String? ACCOUNTCODE,
    String? ACCOUNTNAME,
    String? LRNO,
    String? TRANSPORT,
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
    String? StateName,
    String? EWayBillNO,
    String? EWayBillDt,
    String? LRDate,
    String? NoOfParcel,
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
    LineItemModel? item,
  }) = _SalesModel;

  factory SalesModel.fromJson(JSON json) => _$SalesModelFromJson(json);
}

