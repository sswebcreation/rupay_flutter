import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:rupay/models/voucher/VoucherListModel.dart';
import 'package:rupay/models/login/LoginModel.dart';
import 'package:rupay/models/response/ResponseModel.dart';
import 'package:rupay/repositories/VoucherRepository.dart';

class VoucherProvider {
  final VoucherRepository voucherRepository;

  VoucherProvider(this.voucherRepository);

  Future<VoucherListModel> fetch(String token, String endpoint) async {
    var voucherListModel = await voucherRepository.fetch(token, endpoint);

    return VoucherListModel.fromJson(voucherListModel);
  }

}
