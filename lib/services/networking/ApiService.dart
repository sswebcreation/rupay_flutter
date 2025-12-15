import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rupay/constants/CommonConstants.dart';
import 'package:rupay/essential/Essential.dart';
import 'package:rupay/models/company/CompanyModel.dart';
import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:rupay/services/networking/BaseProvider.dart';
import 'package:rupay/shared/typedef.dart';

class ApiService {
  final BaseProvider baseProvider;

  ApiService(this.baseProvider);

  Future<JSON> get<T>({
    required String endpoint,
    JSON? query,
    required String token,
  }) async {
    try {
      final storage = GetStorage();
      CompanyModel? company;

      print(storage.read("company"));
      print(storage.read("company")!=null);

      if(storage.read("company")!=null) {
        company = storage.read("company") is CompanyModel ? storage.read("company") : CompanyModel.fromJson(storage.read("company"));
      }

      final response = await baseProvider.get(
          endpoint,
          query: query,
          headers: {
            ApiConstants.token: token, ApiConstants.cocode : company?.CODE??""
          }
      );
      print("response.body");
      print(response.body);
      print(response.statusCode);
      print("response.bodyyy");

      if(response.statusCode==401 || response.statusCode==403) {
        print("403 get");
        Essential.logout();
      }
      else {
        Map<String, dynamic> data = (response.body is String ? json.decode(
            response.body) : response.body);

        if (data['code'] == 0) {
          Essential.logout();
        }
      }
      return response.body is String ? json.decode(response.body) : response.body;
    }
    catch(ex) {
      print(ex);
      print(ex.toString());
      Get.back();
      return {"status" : "Failure", "message" : "Please, try again later", "code" : -1};
    }
  }

  Future<JSON> post<T>({
    required String endpoint,
    JSON? body,
    JSON? query,
    bool requiresAuthToken = false,
    required String token,
  }) async {

    try {
      final storage = GetStorage();
      CompanyModel? company;

      if(storage.read("company")!=null) {
        company = storage.read("company") is CompanyModel ? storage.read("company") : CompanyModel.fromJson(storage.read("company"));
      }


      final response = await baseProvider.post(
          endpoint,
          body,
          query: query,
          headers: {
            ApiConstants.token: token, ApiConstants.cocode : company?.CODE??""
          }
      );
      if(response.statusCode==401 || response.statusCode==403) {
        print("403 get");
        Essential.logout();
      }
      else {
        print("response.body");
        print(response.body);
        print("response.bodyyy");
        Map<String, dynamic> data = (response.body is String ? json.decode(
            response.body) : response.body);

        if (data['code'] == 0) {
          Essential.logout();
        }
      }
      return response.body is String ? json.decode(response.body) : response.body;
    }
    catch(ex) {
      return {"status" : "Failure", "message" : "Please, try again later", "code" : -1};
    }
  }

  Future<JSON> file<T>({
    required String endpoint,
    required FormData body,
    JSON? query,
    bool requiresAuthToken = false,
    required String token,
  }) async {

    try {
      final storage = GetStorage();
      CompanyModel? company;

      if(storage.read("company")!=null) {
        company = storage.read("company") is CompanyModel ? storage.read("company") : CompanyModel.fromJson(storage.read("company"));
      }


      final response = await baseProvider.post(
          endpoint,
          body,
          headers: {
            ApiConstants.token: token, ApiConstants.cocode : company?.CODE??""
          },
          query: query
      );

      if(response.statusCode==401 || response.statusCode==403) {
        print("403 get");
        Essential.logout();
      }
      else {
        Map<String, dynamic> data = (response.body is String ? json.decode(
            response.body) : response.body);
        if (data['code'] == 0) {
          Essential.logout();
        }
      }
      return response.body is String ? json.decode(response.body) : response.body;
    }
    catch(ex) {
      Get.back();
      return {"status" : "Failure", "message" : "Please, try again later", "code" : -1};
    }
  }

  Future<JSON> put<T>({
    required String endpoint,
    JSON? body,
    JSON? query,
    bool requiresAuthToken = false,
  }) async {

    final response = await baseProvider.put(
        endpoint,
        body,
        query: query
    );

    return json.decode(response.body);
  }

  Future<JSON> delete<T>({
    required String endpoint,
    JSON? body,
    JSON? query,
    bool requiresAuthToken = false,
  }) async {

    final response = await baseProvider.delete(
        endpoint,
        query: query
    );

    return json.decode(response.body);
  }
}
