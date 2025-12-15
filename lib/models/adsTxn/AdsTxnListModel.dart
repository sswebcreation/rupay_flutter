import 'package:rupay/models/adsTxn/AdsTxnModel.dart';
import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'AdsTxnListModel.freezed.dart';
part 'AdsTxnListModel.g.dart';


@freezed
class AdsTxnListModel with _$AdsTxnListModel {
  factory AdsTxnListModel({
    required String status,
    required int code,
    required String message,
    List<AdsTxnModel>? adsTxn,
  }) = _AdsTxnListModel;

  factory AdsTxnListModel.fromJson(JSON json) => _$AdsTxnListModelFromJson(json);
}

