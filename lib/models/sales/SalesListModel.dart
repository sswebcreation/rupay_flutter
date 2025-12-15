import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rupay/models/sales/SalesModel.dart';
part 'SalesListModel.freezed.dart';
part 'SalesListModel.g.dart';


@freezed
class SalesListModel with _$SalesListModel {
  factory SalesListModel({
    required String status,
    required int code,
    required String message,
    List<SalesModel>? data,
  }) = _SalesListModel;

  factory SalesListModel.fromJson(JSON json) => _$SalesListModelFromJson(json);
}

