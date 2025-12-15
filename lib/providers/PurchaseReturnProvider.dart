import 'package:rupay/models/purchase/PurchaseListModel.dart';
import 'package:rupay/models/purchase/PurchaseResponseModel.dart';
import 'package:rupay/repositories/PurchaseReturnRepository.dart';
class PurchaseReturnProvider {
  final PurchaseReturnRepository purchaseReturnRepository;

  PurchaseReturnProvider(this.purchaseReturnRepository);

  Future<PurchaseListModel> fetch(String token, String endpoint) async {
    var purchaseListModel = await purchaseReturnRepository.fetch(token, endpoint);

    return PurchaseListModel.fromJson(purchaseListModel);
  }

  Future<PurchaseListModel> fetchByColumn(String token, String endpoint, Map<String, String> data) async {
    var purchaseListModel = await purchaseReturnRepository.fetchByColumn(token, endpoint, data);

    return PurchaseListModel.fromJson(purchaseListModel);
  }

  Future<PurchaseResponseModel> singleFetch(String token, String endpoint) async {
    var purchaseResponseModel = await purchaseReturnRepository.fetch(token, endpoint);

    return PurchaseResponseModel.fromJson(purchaseResponseModel);
  }

}
