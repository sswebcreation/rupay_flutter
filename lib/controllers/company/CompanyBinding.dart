import 'package:get/get.dart';
import 'package:rupay/controllers/company/CompanyController.dart';
import 'package:rupay/controllers/company/SelectCompanyController.dart';
import 'package:rupay/providers/CompanyProvider.dart';
import 'package:rupay/providers/UserProvider.dart';
import 'package:rupay/repositories/CompanyRepository.dart';
import 'package:rupay/repositories/UserRepository.dart';

class CompanyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyController>(() => CompanyController());
    Get.lazyPut<SelectCompanyController>(() => SelectCompanyController());

    Get.lazyPut<CompanyRepository>(() => CompanyRepository(Get.find()));
    Get.lazyPut<CompanyProvider>(() => CompanyProvider(Get.find()));

    Get.lazyPut<UserRepository>(() => UserRepository(Get.find()));
    Get.lazyPut<UserProvider>(() => UserProvider(Get.find()));
  }
}
