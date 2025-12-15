import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rupay/models/outstanding/OutstandingModel.dart';

part 'OutstandingListModel.freezed.dart';
part 'OutstandingListModel.g.dart';


@freezed
class OutstandingListModel with _$OutstandingListModel {
  factory OutstandingListModel({
    required String status,
    required int code,
    required String message,
    List<OutstandingModel>? data,
  }) = _OutstandingListModel;

  factory OutstandingListModel.fromJson(JSON json) => _$OutstandingListModelFromJson(json);
}

