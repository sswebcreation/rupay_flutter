import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'VoucherModel.freezed.dart';
part 'VoucherModel.g.dart';


@freezed
class VoucherModel with _$VoucherModel {
  factory VoucherModel({
    required int id,
    required String name,
    required int cat_id,
    required String category,
  }) = _VoucherModel;

  factory VoucherModel.fromJson(JSON json) => _$VoucherModelFromJson(json);
}
