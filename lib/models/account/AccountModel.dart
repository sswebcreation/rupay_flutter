import 'package:rupay/models/company/CompanyModel.dart';
import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'AccountModel.freezed.dart';
part 'AccountModel.g.dart';


@freezed
class AccountModel with _$AccountModel {
  factory AccountModel({
    required int ID,
    required String UID,
    required String COCODE,
    required String CODE,
    required String NAME,
    required String GLGROUPCODE,
    required String GLGROUP,
    required String ADD1,
    required String ADD2,
    required String PINCODE,
    required String CITY,
    required String STATE,
    required String GSTIN,
    required String MOBILE,
    required String EMAIL,
    required String AREACODE,
    required String AREANAME,
    required String BROKER,
    required double BALANCE,
    required int TYP,
    required String TYPCAPTION,
    required int ISBLACKLIST,
    required int STATUS,
  }) = _AccountModel;

  factory AccountModel.fromJson(JSON json) => _$AccountModelFromJson(json);
}
