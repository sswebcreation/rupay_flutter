import 'package:rupay/models/company/CompanyResponseModel.dart';
import 'package:rupay/models/dashboard/DashboardModel.dart';
import 'package:rupay/repositories/DashboardRepository.dart';

class DashboardProvider {
  final DashboardRepository dashboardRepository;

  DashboardProvider(this.dashboardRepository);


  Future<CompanyResponseModel> fetch(String token, Map<String, dynamic> data) async {
    var companyResponseModel = await dashboardRepository.fetch(token, data);

    return CompanyResponseModel.fromJson(companyResponseModel);
  }

  Future<CompanyResponseModel> fetchNew(String token, Map<String, dynamic> data) async {
    var companyResponseModel = await dashboardRepository.fetchNew(token, data);

    return CompanyResponseModel.fromJson(companyResponseModel);
  }
}
