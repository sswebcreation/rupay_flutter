import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/shared/typedef.dart';
import 'package:rupay/services/networking/ApiService.dart';

class PurchaseRepository {
  final ApiService apiService;

  PurchaseRepository(this.apiService);

  Future<JSON> fetch(String token, String endpoint) async {
    var response = await apiService.get(endpoint: ApiConstants.purchaseAPI+endpoint, token: token);
    return response;
  }

  Future<JSON> fetchByColumn(String token, String endpoint, Map<String, dynamic> data) async {
    var response = await apiService.post(endpoint: ApiConstants.purchaseAPI+endpoint, token: token, body: data);
    return response;
  }

  Future<JSON> delete(String endpoint, String token, Map<String, dynamic> data) async {
    var response = await apiService.post(endpoint: ApiConstants.purchaseAPI+endpoint, body: data, token: token);

    return response;
  }
}
