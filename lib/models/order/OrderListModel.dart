import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rupay/models/order/OrderModel.dart';

part 'OrderListModel.freezed.dart';
part 'OrderListModel.g.dart';


@freezed
class OrderListModel with _$OrderListModel {
  factory OrderListModel({
    required String status,
    required int code,
    required String message,
    List<OrderModel>? data,
  }) = _OrderListModel;

  factory OrderListModel.fromJson(JSON json) => _$OrderListModelFromJson(json);
}

