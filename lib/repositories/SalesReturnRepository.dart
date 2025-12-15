import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/shared/typedef.dart';
import 'package:rupay/services/networking/ApiService.dart';

class SalesReturnRepository {
  final ApiService apiService;

  SalesReturnRepository(this.apiService);

  Future<JSON> fetch(String token, String endpoint) async {
    var response = await apiService.get(endpoint: ApiConstants.salesReturnAPI+endpoint, token: token);
    return response;
  }

  Future<JSON> fetchByColumn(String token, String endpoint, Map<String, String> data) async {
    var response = await apiService.post(endpoint: ApiConstants.salesReturnAPI+endpoint, token: token, body: data);
    return response;
  }

}
