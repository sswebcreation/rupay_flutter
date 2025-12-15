import 'package:rupay/models/daybook/DaybookListModel.dart';
import 'package:rupay/repositories/DaybookRepository.dart';
class DaybookProvider {
  final DaybookRepository daybookRepository;

  DaybookProvider(this.daybookRepository);

  Future<DaybookListModel> fetch(String token, String endpoint) async {
    var daybookListModel = await daybookRepository.fetch(token, endpoint);

    return DaybookListModel.fromJson(daybookListModel);
  }
}
