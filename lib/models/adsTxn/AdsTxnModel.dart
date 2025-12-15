import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'AdsTxnModel.freezed.dart';
part 'AdsTxnModel.g.dart';


@freezed
class AdsTxnModel with _$AdsTxnModel {
  factory AdsTxnModel({
    required int id,
    required String image,
    required int cus_id,
    int? cat_id,
  }) = _AdsTxnModel;

  factory AdsTxnModel.fromJson(JSON json) => _$AdsTxnModelFromJson(json);
}
