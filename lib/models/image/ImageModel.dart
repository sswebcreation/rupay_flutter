import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ImageModel.freezed.dart';
part 'ImageModel.g.dart';


@freezed
class ImageModel with _$ImageModel {
  factory ImageModel({
    required int id,
    required int p_id,
    required String path,
  }) = _ImageModel;

  factory ImageModel.fromJson(JSON json) => _$ImageModelFromJson(json);
}
