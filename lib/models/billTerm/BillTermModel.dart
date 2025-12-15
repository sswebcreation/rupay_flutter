import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'BillTermModel.freezed.dart';
part 'BillTermModel.g.dart';


@freezed
class BillTermModel with _$BillTermModel {
  factory BillTermModel({
    int? ID,
    int? HEADERID,
    String? TERMDESC,
    double? Percentage,
    double? Amount,
    int? Ordinal,
  }) = _BillTermModel;

  factory BillTermModel.fromJson(JSON json) => _$BillTermModelFromJson(json);
}
