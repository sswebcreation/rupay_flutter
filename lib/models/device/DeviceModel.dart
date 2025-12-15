import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'DeviceModel.freezed.dart';
part 'DeviceModel.g.dart';


@freezed
class DeviceModel with _$DeviceModel {
  factory DeviceModel({
    required int ID,
    required String UID,
    required String IMEI,
    required String MODEL,
    required String OS,
    required String LOGINAT,
    String? UPDATEDAT,
  }) = _DeviceModel;

  factory DeviceModel.fromJson(JSON json) => _$DeviceModelFromJson(json);
}
