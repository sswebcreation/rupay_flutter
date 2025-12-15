import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rupay/models/account/AccountModel.dart';

part 'AccountListModel.freezed.dart';
part 'AccountListModel.g.dart';


@freezed
class AccountListModel with _$AccountListModel {
  factory AccountListModel({
    required String status,
    required int code,
    required String message,
    List<AccountModel>? data,
  }) = _AccountListModel;

  factory AccountListModel.fromJson(JSON json) => _$AccountListModelFromJson(json);
}

