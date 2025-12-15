import 'package:rupay/models/company/CompanyModel.dart';
import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'CompanyListModel.freezed.dart';
part 'CompanyListModel.g.dart';


@freezed
class CompanyListModel with _$CompanyListModel {
  factory CompanyListModel({
    required String status,
    required int code,
    required String message,
    List<CompanyModel>? data
  }) = _CompanyListModel;

  factory CompanyListModel.fromJson(JSON json) => _$CompanyListModelFromJson(json);
}
