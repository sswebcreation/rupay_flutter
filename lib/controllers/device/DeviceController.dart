import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rupay/essential/Essential.dart';
import 'package:rupay/models/device/DeviceModel.dart';
import 'package:rupay/providers/UserProvider.dart';
import 'package:rupay/services/networking/ApiConstants.dart';

class DeviceController extends GetxController {
  DeviceController();

  final storage = GetStorage();

  late UserProvider userProvider = Get.find();

  List<DeviceModel> devices = [];
  List<DeviceModel> selected_devices = [];
  DeviceModel? device;

  late bool load;

  @override
  void onInit() {
    super.onInit();
    if(Get.arguments!=null) {
      load = true;
      devices = Get.arguments??[];
    }
    else {
      load = false;
      devices = [];
    }
    selected_devices = [];
    start();
  }

  void start() {
    getDevices();
  }

  void getDevices() {
    load = false;
    selected_devices = [];
    update();
    
    userProvider.fetchDevices(storage.read("access"), ApiConstants.device).then((response) async {
      print(response.toJson());

      if(response.code==1) {
        devices = response.data??[];
      }
      else {
        Essential.showSnackBar(response.message);
      }
      load = true;
      update();
    });
  }

  void changeSelectedDevice(DeviceModel sale) {
    if(selected_devices.contains(sale)) {
      selected_devices.remove(sale);
    }
    else {
      selected_devices.add(sale);
    }
    update();
  }

  void changeSelectAll() {
    if(selected_devices.length==devices.length) {
      selected_devices = [];
    }
    else {
      selected_devices = [];
      selected_devices.addAll(devices);
    }
    update();
  }
  
  goto(String path, {dynamic arguments}) {
    print(path);
    Get.offAllNamed(path, arguments: arguments);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void delete() {
    load = false;
    update();

    Map<String, String> data = {
      "id" : getDeviceIDs()
    };

    userProvider.deleteMultiple(ApiConstants.device+ApiConstants.delete, storage.read("access"), data).then((response) async {
      print(response.toJson());

      if(response.code==1) {
        getDevices();
      }
      else {
        load = true;
        update();
        Essential.showSnackBar(response.message);
      }
    });
  }

  String getDeviceIDs() {
    String id = "";
    for (var element in selected_devices) {
      id+=",${element.ID}";
    }
    return id.isNotEmpty ? id.substring(1) : "";
  }
}
