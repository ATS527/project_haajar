import 'package:nearby_connections/nearby_connections.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:signals/signals_flutter.dart';

class AttendenceController {
  final discoveredDevices = signal<List<Map<String, String>>>([]);

  Future<void> takePermission() async {
    // location permission
    if (!await Permission.location.isGranted) {
      await Permission.location.request(); // Ask
    }

    await Permission.nearbyWifiDevices.request();

// Bluetooth permissions
    !(await Future.wait([
      // Check
      Permission.bluetooth.isGranted,
      Permission.bluetoothAdvertise.isGranted,
      Permission.bluetoothConnect.isGranted,
      Permission.bluetoothScan.isGranted,
    ]))
        .any((element) => false);
    [
      // Ask
      Permission.bluetooth,
      Permission.bluetoothAdvertise,
      Permission.bluetoothConnect,
      Permission.bluetoothScan
    ].request();
  }

  Future<void> startAdvertising(String? userName) async {
    try {
      bool a = await Nearby().startAdvertising(
        userName!,
        Strategy.P2P_STAR,
        onConnectionInitiated: (String id, ConnectionInfo info) {
          // Called whenever a discoverer requests connection
        },
        onConnectionResult: (String id, Status status) {
          // Called when connection is accepted/rejected
        },
        onDisconnected: (String id) {
          // Callled whenever a discoverer disconnects from advertiser
        },
        serviceId: "com.example.haajar_final", // uniquely identifies your app
      );
    } catch (exception) {
      // platform exceptions like unable to start bluetooth or insufficient permissions
      rethrow;
    }
  }

  void startScanning(String? userName) async {
    try {
      bool a = await Nearby().startDiscovery(
        userName!,
        Strategy.P2P_STAR,
        onEndpointFound: (String id, String userName, String serviceId) {
          // called when an advertiser is found
          discoveredDevices.value.add({
            "id": id,
            "userName": userName,
            "serviceId": serviceId,
          });
        },
        onEndpointLost: (String? id) {
          //called when an advertiser is lost (only if we weren't connected to it )
          discoveredDevices.value.removeWhere((element) => element["id"] == id);
        },
        serviceId: "com.example.haajar_final", // uniquely identifies your app
      );
    } catch (e) {
      // platform exceptions like unable to start bluetooth or insufficient permissions
      rethrow;
    }
  }
}

final attendenceController = AttendenceController();
