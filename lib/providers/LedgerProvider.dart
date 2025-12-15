import 'package:rupay/models/ledger/LedgerListModel.dart';
import 'package:rupay/repositories/LedgerRepository.dart';

class LedgerProvider {
  final LedgerRepository ledgerRepository;

  LedgerProvider(this.ledgerRepository);

  Future<LedgerListModel> fetch(String token, String endpoint) async {
    var ledgerListModel = await ledgerRepository.fetch(token, endpoint);

    return LedgerListModel.fromJson(ledgerListModel);
  }

  Future<LedgerListModel> fetchByColumn(String token, String endpoint, Map<String, String> data) async {
    var ledgerListModel = await ledgerRepository.fetchByColumn(token, endpoint, data);

    return LedgerListModel.fromJson(ledgerListModel);
  }


}
