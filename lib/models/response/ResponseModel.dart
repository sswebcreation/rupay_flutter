import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ResponseModel.freezed.dart';
part 'ResponseModel.g.dart';

@freezed
class ResponseModel with _$ResponseModel {
  factory ResponseModel({
    required String status,
    required int code,
    required String message,
    int? data
  }) = _ResponseModel;

  factory ResponseModel.fromJson(JSON json) => _$ResponseModelFromJson(json);
}
