import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/shared/typedef.dart';
import 'package:rupay/services/networking/ApiService.dart';

class VoucherRepository {
  final ApiService apiService;

  VoucherRepository(this.apiService);

  Future<JSON> fetch(String token, String endpoint) async {
    var response = await apiService.get(endpoint: ApiConstants.voucherAPI+endpoint, token: token);
    return response;
  }

}
