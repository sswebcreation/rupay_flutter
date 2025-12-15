import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'BannerModel.freezed.dart';
part 'BannerModel.g.dart';


@freezed
class BannerModel with _$BannerModel {
  factory BannerModel({
    required int id,
    required String image,
    required String type,
    int? cat_id,
    // required String start_date,
    // required String end_date,
  }) = _BannerModel;

  factory BannerModel.fromJson(JSON json) => _$BannerModelFromJson(json);
}
