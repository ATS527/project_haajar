import 'dart:async';

import 'package:flutter/material.dart';
import 'package:haajar_final/controllers/attendence_controller.dart';
import 'package:light_flutter_nearby_connections/light_flutter_nearby_connections.dart';
import 'package:signals/signals_flutter.dart';

class AttendenceListingScreen extends StatefulWidget {
  const AttendenceListingScreen({super.key});

  @override
  State<AttendenceListingScreen> createState() =>
      _AttendenceListingScreenState();
}

class _AttendenceListingScreenState extends State<AttendenceListingScreen> {
  late NearbyService nearbyService;
  late StreamSubscription subscription;

  final discoveredDevices = signal([]);

  bool isInit = false;

  @override
  void initState() {
    // TODO: implement initState
    attendenceController.init(context, "browser");
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    attendenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Attendence Listing',
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: Watch(
          (context) => ListView.builder(
            itemCount: attendenceController.discoveredDevices.value.length,
            itemBuilder: (context, index) {
              if (attendenceController.discoveredDevices.value.isEmpty) {
                return const Center(
                  child: Text("No devices found"),
                );
              }
              return ListTile(
                title: Text(attendenceController
                    .discoveredDevices.value[index].deviceName),
                subtitle: Text(attendenceController
                    .discoveredDevices.value[index].deviceId),
              );
            },
          ),
        ));
  }
}
