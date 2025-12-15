import 'package:rupay/models/account/AccountListModel.dart';
import 'package:rupay/repositories/AccountRepository.dart';
class AccountProvider {
  final AccountRepository accountRepository;

  AccountProvider(this.accountRepository);

  Future<AccountListModel> fetch(String token, String endpoint) async {
    var accountListModel = await accountRepository.fetch(token, endpoint);

    return AccountListModel.fromJson(accountListModel);
  }

  Future<AccountListModel> fetchByColumn(String token, String endpoint, Map<String, String> data) async {
    var accountListModel = await accountRepository.fetchByColumn(token, endpoint, data);

    return AccountListModel.fromJson(accountListModel);
  }

}
