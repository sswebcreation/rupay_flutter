import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/controllers/device/DeviceController.dart';
import 'package:rupay/models/device/DeviceModel.dart';

class Device extends StatelessWidget {
  Device({ Key? key }) : super(key: key);

  final DeviceController deviceController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeviceController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Devices",
              style: GoogleFonts.manrope(
                fontSize: 16.0,
                color: MyColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: false,
            backgroundColor: MyColors.colorPrimary,
            iconTheme: IconThemeData(
              color: MyColors.white
            ),
            elevation: 0,
            actions: deviceController.selected_devices.isNotEmpty ?
            [
              GestureDetector(
                onTap: () {
                  deviceController.changeSelectAll();
                },
                child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      deviceController.selected_devices.length==deviceController.devices.length ? "DESELECT ALL" : "SELECT ALL",
                      style: GoogleFonts.manrope(
                        fontSize: 14.0,
                        color: MyColors.white,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                ),
              ),
              GestureDetector(
                onTap: () {
                  deviceController.delete();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                      Icons.delete
                  ),
                ),
              ),
            ] : null,
          ),
          backgroundColor: MyColors.white,
          body: deviceController.load ?
          ListView.separated(
            itemCount: deviceController.devices.length,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            separatorBuilder: (BuildContext buildContext, int index) {
              return SizedBox(
                height: 3,
              );
            },
            itemBuilder: (BuildContext buildContext, int index) {
              return getDeviceDesign(deviceController.devices[index]);
            },
          )
          : Center(
            child: CircularProgressIndicator(
              color: MyColors.colorPrimary,
            ),
          ),
        );
      },
    );
  }

  Widget getDeviceDesign(DeviceModel device) {
    return GestureDetector(
      onTap: () {
        if(deviceController.selected_devices.isNotEmpty) {
          deviceController.changeSelectedDevice(device);
        }
      },
      onLongPress: () {
        deviceController.changeSelectedDevice(device);
      },
      child: Card(
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6),
          decoration: BoxDecoration(
              color: deviceController.selected_devices.contains(device) ? MyColors.colorLightPrimary.withOpacity(0.5) : MyColors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      device.OS,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.manrope(
                        fontSize: 12.0,
                        color: MyColors.black,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      device.MODEL,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.manrope(
                        fontSize: 12.0,
                        color: MyColors.black,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      device.IMEI,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.manrope(
                        fontSize: 12.0,
                        color: MyColors.black,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}