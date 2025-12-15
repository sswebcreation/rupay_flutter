import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rupay/models/daybook/DaybookModel.dart';

part 'DaybookListModel.freezed.dart';
part 'DaybookListModel.g.dart';


@freezed
class DaybookListModel with _$DaybookListModel {
  factory DaybookListModel({
    required String status,
    required int code,
    required String message,
    List<DaybookModel>? data,
  }) = _DaybookListModel;

  factory DaybookListModel.fromJson(JSON json) => _$DaybookListModelFromJson(json);
}

