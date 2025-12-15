import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rupay/models/screenCode/ScreenCodeModel.dart';

part 'ScreenCodeListModel.freezed.dart';
part 'ScreenCodeListModel.g.dart';


@freezed
class ScreenCodeListModel with _$ScreenCodeListModel {
  factory ScreenCodeListModel({
    required String status,
    required int code,
    required String message,
    List<ScreenCodeModel>? data,
  }) = _ScreenCodeListModel;

  factory ScreenCodeListModel.fromJson(JSON json) => _$ScreenCodeListModelFromJson(json);
}

