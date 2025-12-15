import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rupay/models/sales/SalesModel.dart';
part 'SalesResponseModel.freezed.dart';
part 'SalesResponseModel.g.dart';


@freezed
class SalesResponseModel with _$SalesResponseModel {
  factory SalesResponseModel({
    required String status,
    required int code,
    required String message,
    SalesModel? data,
  }) = _SalesResponseModel;

  factory SalesResponseModel.fromJson(JSON json) => _$SalesResponseModelFromJson(json);
}

