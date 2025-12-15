import 'package:rupay/models/response/ResponseModel.dart';
import 'package:rupay/models/sales/SalesListModel.dart';
import 'package:rupay/models/sales/SalesResponseModel.dart';
import 'package:rupay/models/sales/SalesValueModel.dart';
import 'package:rupay/repositories/SalesRepository.dart';
class SalesProvider {
  final SalesRepository salesRepository;

  SalesProvider(this.salesRepository);

  Future<SalesValueModel> fetchValue(String token, String endpoint) async {
    var salesValueModel = await salesRepository.fetch(token, endpoint);

    return SalesValueModel.fromJson(salesValueModel);
  }

  Future<SalesValueModel> fetchLastBill(String token, String endpoint, Map<String, dynamic> data) async {
    var salesValueModel = await salesRepository.fetchByColumn(token, endpoint, data);

    return SalesValueModel.fromJson(salesValueModel);
  }

  Future<SalesListModel> fetch(String token, String endpoint) async {
    var salesListModel = await salesRepository.fetch(token, endpoint);

    return SalesListModel.fromJson(salesListModel);
  }

  Future<SalesListModel> fetchByColumn(String token, String endpoint, Map<String, String> data) async {
    var salesListModel = await salesRepository.fetchByColumn(token, endpoint, data);

    return SalesListModel.fromJson(salesListModel);
  }

  Future<SalesResponseModel> singleFetch(String token, String endpoint) async {
    var salesResponseModel = await salesRepository.fetch(token, endpoint);

    return SalesResponseModel.fromJson(salesResponseModel);
  }

  Future<ResponseModel> add(String token, String endpoint, Map<String, dynamic> data) async {
    var responseModel = await salesRepository.fetchByColumn(token, endpoint, data);

    return ResponseModel.fromJson(responseModel);
  }

  Future<ResponseModel> deleteMultiple(String endpoint, String token, Map<String, dynamic> data) async {
    var response = await salesRepository.delete(endpoint, token, data);

    return ResponseModel.fromJson(response);
  }
}
