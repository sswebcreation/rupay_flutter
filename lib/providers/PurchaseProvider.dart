import 'package:rupay/models/purchase/PurchaseListModel.dart';
import 'package:rupay/models/purchase/PurchaseResponseModel.dart';
import 'package:rupay/models/purchase/PurchaseValueModel.dart';
import 'package:rupay/models/response/ResponseModel.dart';
import 'package:rupay/repositories/PurchaseRepository.dart';
class PurchaseProvider {
  final PurchaseRepository purchaseRepository;

  PurchaseProvider(this.purchaseRepository);

  Future<PurchaseValueModel> fetchValue(String token, String endpoint) async {
    var purchaseValueModel = await purchaseRepository.fetch(token, endpoint);

    return PurchaseValueModel.fromJson(purchaseValueModel);
  }
  
  Future<PurchaseListModel> fetch(String token, String endpoint) async {
    var purchaseListModel = await purchaseRepository.fetch(token, endpoint);

    return PurchaseListModel.fromJson(purchaseListModel);
  }

  Future<PurchaseListModel> fetchByColumn(String token, String endpoint, Map<String, String> data) async {
    var purchaseListModel = await purchaseRepository.fetchByColumn(token, endpoint, data);

    return PurchaseListModel.fromJson(purchaseListModel);
  }

  Future<PurchaseResponseModel> singleFetch(String token, String endpoint) async {
    var purchaseResponseModel = await purchaseRepository.fetch(token, endpoint);

    return PurchaseResponseModel.fromJson(purchaseResponseModel);
  }

  Future<ResponseModel> add(String token, String endpoint, Map<String, dynamic> data) async {
    var responseModel = await purchaseRepository.fetchByColumn(token, endpoint, data);

    return ResponseModel.fromJson(responseModel);
  }

  Future<ResponseModel> deleteMultiple(String endpoint, String token, Map<String, dynamic> data) async {
    var response = await purchaseRepository.delete(endpoint, token, data);

    return ResponseModel.fromJson(response);
  }
}
