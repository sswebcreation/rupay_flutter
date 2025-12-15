import 'package:rupay/models/cash/CashListModel.dart';
import 'package:rupay/models/cash/CashValueModel.dart';
import 'package:rupay/models/response/ResponseModel.dart';
import 'package:rupay/repositories/CashRepository.dart';

class CashProvider {
  final CashRepository cashRepository;

  CashProvider(this.cashRepository);

  Future<CashValueModel> fetchValue(String token, String endpoint) async {
    var cashValueModel = await cashRepository.fetch(token, endpoint);

    return CashValueModel.fromJson(cashValueModel);
  }

  Future<CashValueModel> fetchLastBill(String token, String endpoint, Map<String, dynamic> data) async {
    var cashValueModel = await cashRepository.fetchByColumn(token, endpoint, data);

    return CashValueModel.fromJson(cashValueModel);
  }
  
  Future<CashListModel> fetch(String token, String endpoint) async {
    var cashListModel = await cashRepository.fetch(token, endpoint);

    return CashListModel.fromJson(cashListModel);
  }

  Future<CashListModel> fetchByColumn(String token, String endpoint, Map<String, String> data) async {
    var cashListModel = await cashRepository.fetchByColumn(token, endpoint, data);

    return CashListModel.fromJson(cashListModel);
  }

  Future<ResponseModel> add(String token, String endpoint, Map<String, dynamic> data) async {
    var responseModel = await cashRepository.fetchByColumn(token, endpoint, data);

    return ResponseModel.fromJson(responseModel);
  }

  Future<ResponseModel> deleteMultiple(String endpoint, String token, Map<String, dynamic> data) async {
    var response = await cashRepository.delete(endpoint, token, data);

    return ResponseModel.fromJson(response);
  }
}
