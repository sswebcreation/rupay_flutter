import 'package:rupay/models/device/DeviceModel.dart';
import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'DeviceListModel.freezed.dart';
part 'DeviceListModel.g.dart';


@freezed
class DeviceListModel with _$DeviceListModel {
  factory DeviceListModel({
    required String status,
    required int code,
    required String message,
    List<DeviceModel>? data
  }) = _DeviceListModel;

  factory DeviceListModel.fromJson(JSON json) => _$DeviceListModelFromJson(json);
}
