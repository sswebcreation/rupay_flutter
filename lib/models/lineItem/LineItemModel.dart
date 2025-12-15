import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'LineItemModel.freezed.dart';
part 'LineItemModel.g.dart';


@freezed
class LineItemModel with _$LineItemModel {
  factory LineItemModel({
    int? ID,
    int? HEADERID,
    String? ITEMCODE,
    String? ITEMNAME,
    String? SCREENNAME,
    String? Remarks,
    String? Notes,
    double? QTY1,
    double? QTY2,
    double? QTY3,
    double? ITEMRATE,
    double? AMOUNT,
    double? NETAMOUNT,
    String? HSN,
    double? TAXABLEVALUE,
    double? GSTPERCENT,
  }) = _LineItemModel;

  factory LineItemModel.fromJson(JSON json) => _$LineItemModelFromJson(json);
}
