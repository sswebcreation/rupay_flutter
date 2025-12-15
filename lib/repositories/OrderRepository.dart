import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/shared/typedef.dart';
import 'package:rupay/services/networking/ApiService.dart';

class OrderRepository {
  final ApiService apiService;

  OrderRepository(this.apiService);

  Future<JSON> fetch(String token, String endpoint) async {
    var response = await apiService.get(endpoint: ApiConstants.orderAPI+endpoint, token: token);
    return response;
  }

  Future<JSON> fetchByColumn(String token, String endpoint, Map<String, dynamic> data) async {
    var response = await apiService.post(endpoint: ApiConstants.orderAPI+endpoint, token: token, body: data);
    return response;
  }
}
