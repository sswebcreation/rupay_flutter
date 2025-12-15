import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:rupay/models/device/DeviceListModel.dart';
import 'package:rupay/models/login/LoginModel.dart';
import 'package:rupay/models/response/ResponseModel.dart';
import 'package:rupay/repositories/UserRepository.dart';

class UserProvider {
  final UserRepository userRepository;

  UserProvider(this.userRepository);

  Future<LoginModel> login(Map<String, dynamic> data, String token, String endpoint) async {
    var loginResponse = await userRepository.login(data, token, endpoint);

    return LoginModel.fromJson(loginResponse);
  }

  Future<ResponseModel> logout(String token, String endpoint) async {
    var loginResponse = await userRepository.logout(token, endpoint);

    return ResponseModel.fromJson(loginResponse);
  }

  Future<ResponseModel> update(Map<String, dynamic> data, String token) async {
    var response = await userRepository.update(data, token);

    return ResponseModel.fromJson(response);
  }

  Future<LoginModel> add(FormData formData, String token) async {
    var loginResponse = await userRepository.add(formData, token);

    return LoginModel.fromJson(loginResponse);
  }

  Future<DeviceListModel> fetchDevices(String token, String endpoint) async {
    var deviceListModel = await userRepository.fetch(token, endpoint);

    return DeviceListModel.fromJson(deviceListModel);
  }

  Future<ResponseModel> deleteMultiple(String endpoint, String token, Map<String, dynamic> data) async {
    var response = await userRepository.delete(endpoint, token, data);

    return ResponseModel.fromJson(response);
  }

}
