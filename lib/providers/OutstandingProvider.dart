import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:rupay/models/outstanding/OutstandingListModel.dart';
import 'package:rupay/models/login/LoginModel.dart';
import 'package:rupay/models/response/ResponseModel.dart';
import 'package:rupay/repositories/OutstandingRepository.dart';

class OutstandingProvider {
  final OutstandingRepository outstandingRepository;

  OutstandingProvider(this.outstandingRepository);

  Future<OutstandingListModel> fetch(String token, String endpoint) async {
    var outstandingListModel = await outstandingRepository.fetch(token, endpoint);

    return OutstandingListModel.fromJson(outstandingListModel);
  }

  Future<OutstandingListModel> fetchByColumn(String token, String endpoint, Map<String, String> data) async {
    var outstandingListModel = await outstandingRepository.fetchByColumn(token, endpoint, data);

    return OutstandingListModel.fromJson(outstandingListModel);
  }

}
