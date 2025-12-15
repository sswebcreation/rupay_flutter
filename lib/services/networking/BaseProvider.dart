import 'package:get/get_connect.dart';
import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/services/networking/interceptors/RequestInterceptor.dart';
import 'package:rupay/services/networking/interceptors/ResponseInterceptor.dart';

class BaseProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = ApiConstants.baseUrl;
    httpClient.addRequestModifier(requestInterceptor);
    httpClient.addResponseModifier(responseInterceptor);
  }
}
