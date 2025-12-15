import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ScreenCodeModel.freezed.dart';
part 'ScreenCodeModel.g.dart';


@freezed
class ScreenCodeModel with _$ScreenCodeModel {
  factory ScreenCodeModel({
    required int id,
    required String code,
    required String name,
  }) = _ScreenCodeModel;

  factory ScreenCodeModel.fromJson(JSON json) => _$ScreenCodeModelFromJson(json);
}
