import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:haajar_final/controllers/authentication_controller.dart';
import 'package:light_flutter_nearby_connections/light_flutter_nearby_connections.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:signals/signals_flutter.dart';

class AttendenceController {
  late NearbyService nearbyService;
  late StreamSubscription subscription;

  final discoveredDevices = signal([]);

  bool isInit = false;

  void init(BuildContext context, String type) async {
    nearbyService = NearbyService();
    String devInfo = '';
    await askPermissions(context);
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      devInfo = androidInfo.model;
    }
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      devInfo = iosInfo.localizedModel;
    }
    await nearbyService.init(
        serviceType: 'mpconn',
        deviceName: auth.currentlyLoggedInUser.value?.displayName,
        strategy: Strategy.Wi_Fi_P2P,
        callback: (isRunning) async {
          if (isRunning) {
            if (type == "browser") {
              await nearbyService.stopBrowsingForPeers();
              await Future.delayed(const Duration(microseconds: 200));
              await nearbyService.startBrowsingForPeers();
            } else {
              await nearbyService.stopAdvertisingPeer();
              await nearbyService.stopBrowsingForPeers();
              await Future.delayed(const Duration(microseconds: 200));
              await nearbyService.startAdvertisingPeer();
              await nearbyService.startBrowsingForPeers();
            }
          }
        });
    subscription =
        nearbyService.stateChangedSubscription(callback: (devicesList) {
      devicesList.forEach((element) {
        print(
            " deviceId: ${element.deviceId} | deviceName: ${element.deviceName} | state: ${element.state}");

        if (Platform.isAndroid) {
          if (element.state == SessionState.connected) {
            nearbyService.stopBrowsingForPeers();
          } else {
            nearbyService.startBrowsingForPeers();
          }
        }
      });

      discoveredDevices.value.clear();
      discoveredDevices.value.addAll(devicesList);
    });
  }

  void dispose() {
    subscription.cancel();
    nearbyService.stopBrowsingForPeers();
    nearbyService.stopAdvertisingPeer();
  }

  Future<void> askPermissions(BuildContext context) async {
    final info = await DeviceInfoPlugin().androidInfo;
    var errors = [];
    final explicitPermissions = [
      Permission.locationWhenInUse, // Always?
      Permission.location, // Always?
      // Android 12 and higher
      if (info.version.sdkInt >= 31) Permission.bluetoothAdvertise,
      if (info.version.sdkInt >= 31) Permission.bluetoothConnect,
      if (info.version.sdkInt >= 31) Permission.bluetoothScan,
      // Android 13 and higher
      if (info.version.sdkInt >= 33) Permission.nearbyWifiDevices,
    ];
    try {
      if (explicitPermissions.isNotEmpty) {
        final other = await explicitPermissions.request();
        final locationStatus = await Permission.location.status;
        if (!locationStatus.isGranted) {
          errors.add("Location is not enabled");
        }
        final otherPermissions =
            !other.values.any((element) => !element.isGranted);
        if (!otherPermissions) {
          errors.add("Some permissions weren't given");
        }
        log("requestPermissions granted: $other");
      }
    } catch (e) {
      errors.add("Error occurred while requesting permissions");
    }
    if (errors.isNotEmpty) {
      log("ERROR: requestPermissions failed: $errors");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text("Errors:\n\n${errors.join("\n")}"),
        ),
      );
    }
  }
}

final attendenceController = AttendenceController();
