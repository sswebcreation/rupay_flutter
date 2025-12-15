import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/shared/typedef.dart';
import 'package:rupay/services/networking/ApiService.dart';

class DashboardRepository {
  final ApiService apiService;

  DashboardRepository(this.apiService);

  Future<JSON> fetch(String token, Map<String, dynamic> data) async {
    var dashboard = await apiService.post(endpoint: ApiConstants.companyAPI+ApiConstants.dashboardAPI, token: token, body: data);
    return dashboard;
  }

  Future<JSON> fetchNew(String token, Map<String, dynamic> data) async {
    var dashboard = await apiService.post(endpoint: ApiConstants.companyAPI+ApiConstants.dashboardAPI+ApiConstants.latest, token: token, body: data);
    return dashboard;
  }
}
