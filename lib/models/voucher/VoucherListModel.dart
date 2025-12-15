import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rupay/models/voucher/VoucherModel.dart';

part 'VoucherListModel.freezed.dart';
part 'VoucherListModel.g.dart';


@freezed
class VoucherListModel with _$VoucherListModel {
  factory VoucherListModel({
    required String status,
    required int code,
    required String message,
    List<VoucherModel>? data,
  }) = _VoucherListModel;

  factory VoucherListModel.fromJson(JSON json) => _$VoucherListModelFromJson(json);
}

