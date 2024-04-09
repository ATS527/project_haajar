import 'package:haajar_final/models/attendence.dart';
import 'package:location/location.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:signals/signals_flutter.dart';

class AttendenceController {
  final discoveredDevices = ListSignal<Attendence>([]);

  final nearbyConnection = Nearby();

  Future<void> initialise() async {
    // location permission
    await Permission.location.isGranted; // Check
    await Permission.location.request(); // Ask

// location enable dialog
    await Location.instance.requestService();

// external storage permission
    await Permission.storage.isGranted; // Check
    await Permission.storage.request(); // Ask

// Bluetooth permissions
    bool granted = !(await Future.wait([
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

  void disposeAdvertiser() async {
    await nearbyConnection.stopAdvertising();
  }

  void disposeDiscoverer() async {
    await nearbyConnection.stopDiscovery();
  }

  Future<void> startAdvertising(String? username) async {
    try {
      await nearbyConnection.startAdvertising(
        username!,
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
    } catch (e) {
      // platform exceptions like unable to start bluetooth or insufficient permissions
      print(e);
    }
  }

  void startDiscovering(String? username) async {
    try {
      await nearbyConnection.startDiscovery(
        username!,
        Strategy.P2P_STAR,
        onEndpointFound: (String id, String userName, String serviceId) {
          // called when an advertiser is found
          print("Endpoint found: $userName");
          discoveredDevices.value.add(Attendence(
            id: id,
            userName: userName,
            serviceId: serviceId,
          ));
        },
        onEndpointLost: (String? id) {
          //called when an advertiser is lost (only if we weren't connected to it )
          print("Endpoint lost: $username");
          discoveredDevices.value.removeWhere((element) => element.id == id);
        },
        serviceId: "com.example.haajar_final", // uniquely identifies your app
      );
    } catch (e) {
      // platform exceptions like unable to start bluetooth or insufficient permissions
      print(e);
    }
  }
}

final attendenceController = AttendenceController();
