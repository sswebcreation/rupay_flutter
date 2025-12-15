import 'package:rupay/models/adsTxn/AdsTxnModel.dart';
import 'package:rupay/models/company/CompanyModel.dart';
import 'package:rupay/models/dashboard/DashboardModel.dart';
import 'package:rupay/models/product/ProductModel.dart';
import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rupay/models/banner/BannerModel.dart';

part 'CompanyResponseModel.freezed.dart';
part 'CompanyResponseModel.g.dart';


@freezed
class CompanyResponseModel with _$CompanyResponseModel {
  factory CompanyResponseModel({
    required String status,
    required int code,
    required String message,
    CompanyModel? data,
    DashboardModel? dashboard
  }) = _CompanyResponseModel;

  factory CompanyResponseModel.fromJson(JSON json) => _$CompanyResponseModelFromJson(json);
}

