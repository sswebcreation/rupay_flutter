import 'package:rupay/models/company/CompanyModel.dart';
import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'DaybookModel.freezed.dart';
part 'DaybookModel.g.dart';


@freezed
class DaybookModel with _$DaybookModel {
  factory DaybookModel({
    required String DAYBOOK,
    required String CODE,
  }) = _DaybookModel;

  factory DaybookModel.fromJson(JSON json) => _$DaybookModelFromJson(json);
}
