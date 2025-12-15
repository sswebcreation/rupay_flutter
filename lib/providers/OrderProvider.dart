import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:rupay/models/order/OrderListModel.dart';
import 'package:rupay/models/login/LoginModel.dart';
import 'package:rupay/models/response/ResponseModel.dart';
import 'package:rupay/models/screenCode/ScreenCodeListModel.dart';
import 'package:rupay/repositories/OrderRepository.dart';

class OrderProvider {
  final OrderRepository orderRepository;

  OrderProvider(this.orderRepository);

  Future<OrderListModel> fetch(String token, String endpoint) async {
    var orderListModel = await orderRepository.fetch(token, endpoint);

    return OrderListModel.fromJson(orderListModel);
  }

  Future<OrderListModel> fetchByColumn(String token, String endpoint, Map<String, String> data) async {
    var orderListModel = await orderRepository.fetchByColumn(token, endpoint, data);

    return OrderListModel.fromJson(orderListModel);
  }

  Future<ScreenCodeListModel> fetchScreenCodes(String token, String endpoint) async {
    var screenCodeListModel = await orderRepository.fetch(token, endpoint);

    return ScreenCodeListModel.fromJson(screenCodeListModel);
  }

  Future<ResponseModel> add(String token, String endpoint, Map<String, dynamic> data) async {
    var responseModel = await orderRepository.fetchByColumn(token, endpoint, data);

    return ResponseModel.fromJson(responseModel);
  }

}
