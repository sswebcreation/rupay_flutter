import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rupay/models/item/ItemModel.dart';

part 'ItemListModel.freezed.dart';
part 'ItemListModel.g.dart';


@freezed
class ItemListModel with _$ItemListModel {
  factory ItemListModel({
    required String status,
    required int code,
    required String message,
    List<ItemModel>? data,
  }) = _ItemListModel;

  factory ItemListModel.fromJson(JSON json) => _$ItemListModelFromJson(json);
}

