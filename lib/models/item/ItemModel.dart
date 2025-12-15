import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ItemModel.freezed.dart';
part 'ItemModel.g.dart';


@freezed
class ItemModel with _$ItemModel {
  factory ItemModel({
    required int ID,
    required String UID,
    required String COCODE,
    required String CODE,
    required String NAME,
    required String ITEMGROUP,
    String? HSN,
    String? SAC,
    required double HSNPer,
    required double SACPer,
    double? SALEPRICE,
    double? PURCHASECOST,
    String? BARCODENO,
    String? UNIT,
    int? RATEPER,
    double? BALANCEQUANTITY,
  }) = _ItemModel;

  factory ItemModel.fromJson(JSON json) => _$ItemModelFromJson(json);
}
