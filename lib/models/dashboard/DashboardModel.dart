import 'package:rupay/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'DashboardModel.freezed.dart';
part 'DashboardModel.g.dart';


@freezed
class DashboardModel with _$DashboardModel {
  factory DashboardModel({
    required double SALES,
    required double PURCHASE,
    required double SRETURN,
    required double PRETURN,
    required double SALESOS,
    required double PURCHASEOS,
    required double CASH,
    required double BANK,
  }) = _DashboardModel;

  factory DashboardModel.fromJson(JSON json) => _$DashboardModelFromJson(json);
}

