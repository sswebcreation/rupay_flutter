import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/shared/typedef.dart';
import 'package:rupay/services/networking/ApiService.dart';

class UserRepository {
  final ApiService apiService;

  UserRepository(this.apiService);

  Future<JSON> login(Map<String, dynamic> data, String token, String endpoint) async {
    var login = await apiService.post(endpoint: ApiConstants.userAPI+endpoint, body: data, token: token);

    print(login);
    return login;
  }

  Future<JSON> logout(String token, String endpoint) async {
    var login = await apiService.get(endpoint: ApiConstants.userAPI+endpoint, token: token);

    print(login);
    return login;
  }

  Future<JSON> update(Map<String, dynamic> data, String token) async {
    var update = await apiService.post(endpoint: ApiConstants.customerAPI+ApiConstants.update, body: data, token: token);

    return update;
  }

  Future<JSON> delete(String endpoint, String token, Map<String, dynamic> data) async {
    var response = await apiService.post(endpoint: ApiConstants.userAPI+endpoint, body: data, token: token);

    return response;
  }

  Future<JSON> add(FormData formData, String token) async {
    var image = await apiService.file(endpoint: ApiConstants.customerAPI+ApiConstants.add, body: formData, token: token);

    return image;
  }
  Future<JSON> fetch(String token, String endpoint) async {
    var response = await apiService.get(endpoint: ApiConstants.userAPI+endpoint, token: token);

    print(response);
    return response;
  }

}
