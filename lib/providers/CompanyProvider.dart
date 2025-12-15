import 'package:rupay/models/company/CompanyListModel.dart';
import 'package:rupay/repositories/CompanyRepository.dart';
class CompanyProvider {
  final CompanyRepository companyRepository;

  CompanyProvider(this.companyRepository);

  Future<CompanyListModel> fetch(String token, String endpoint) async {
    var companyListModel = await companyRepository.fetch(token, endpoint);

    return CompanyListModel.fromJson(companyListModel);
  }

  Future<CompanyListModel> fetchByColumn(String token, String endpoint, Map<String, String> data) async {
    var companyListModel = await companyRepository.fetchByColumn(token, endpoint, data);

    return CompanyListModel.fromJson(companyListModel);
  }

}
