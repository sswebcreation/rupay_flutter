import 'package:rupay/models/sales/SalesListModel.dart';
import 'package:rupay/models/sales/SalesResponseModel.dart';
import 'package:rupay/repositories/SalesReturnRepository.dart';
class SalesReturnProvider {
  final SalesReturnRepository salesReturnRepository;

  SalesReturnProvider(this.salesReturnRepository);

  Future<SalesListModel> fetch(String token, String endpoint) async {
    var salesListModel = await salesReturnRepository.fetch(token, endpoint);

    return SalesListModel.fromJson(salesListModel);
  }

  Future<SalesListModel> fetchByColumn(String token, String endpoint, Map<String, String> data) async {
    var salesListModel = await salesReturnRepository.fetchByColumn(token, endpoint, data);

    return SalesListModel.fromJson(salesListModel);
  }

  Future<SalesResponseModel> singleFetch(String token, String endpoint) async {
    var salesResponseModel = await salesReturnRepository.fetch(token, endpoint);

    return SalesResponseModel.fromJson(salesResponseModel);
  }

}
