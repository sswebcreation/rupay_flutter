import 'package:rupay/models/bank/BankListModel.dart';
import 'package:rupay/models/bank/BankValueModel.dart';
import 'package:rupay/models/response/ResponseModel.dart';
import 'package:rupay/repositories/BankRepository.dart';

class BankProvider {
  final BankRepository bankRepository;

  BankProvider(this.bankRepository);

  Future<BankValueModel> fetchValue(String token, String endpoint) async {
    var bankValueModel = await bankRepository.fetch(token, endpoint);

    return BankValueModel.fromJson(bankValueModel);
  }

  Future<BankValueModel> fetchLastBill(String token, String endpoint, Map<String, dynamic> data) async {
    var bankValueModel = await bankRepository.fetchByColumn(token, endpoint, data);

    return BankValueModel.fromJson(bankValueModel);
  }
  
  Future<BankListModel> fetch(String token, String endpoint) async {
    var bankListModel = await bankRepository.fetch(token, endpoint);

    return BankListModel.fromJson(bankListModel);
  }

  Future<BankListModel> fetchByColumn(String token, String endpoint, Map<String, String> data) async {
    var bankListModel = await bankRepository.fetchByColumn(token, endpoint, data);

    return BankListModel.fromJson(bankListModel);
  }

  Future<ResponseModel> add(String token, String endpoint, Map<String, dynamic> data) async {
    var responseModel = await bankRepository.fetchByColumn(token, endpoint, data);

    return ResponseModel.fromJson(responseModel);
  }

  Future<ResponseModel> deleteMultiple(String endpoint, String token, Map<String, dynamic> data) async {
    var response = await bankRepository.delete(endpoint, token, data);

    return ResponseModel.fromJson(response);
  }
}
