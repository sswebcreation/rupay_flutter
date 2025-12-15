import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'CompanyModel.freezed.dart';
part 'CompanyModel.g.dart';


@freezed
class CompanyModel with _$CompanyModel {
  factory CompanyModel({
    int? ID,
    required String UID,
    required String CODE,
    required String NAME,
    required String YEAR,
    required String FROMDATE,
    required String TODATE,
    required int PINCODE,
    String? LOGO,
    required String MOBILE1,
    String? MOBILE2,
    String? EMAIL,
    String? BANK1NAME,
    String? BANK1IFSC,
    String? BANK1ACNO,
    String? BANK2NAME,
    String? BANK2IFSC,
    String? BANK2ACNO,
    String? Q1,
    String? Q2,
    String? Q3,
    String? GSTIN,
    String? ADD1,
    String? ADD2,
    String? ADD3,
    String? CITY,
    String? STATE,
    required String TNC,
    required String LASTSYNCDATE,
  }) = _CompanyModel;

  factory CompanyModel.fromJson(JSON json) => _$CompanyModelFromJson(json);
}
