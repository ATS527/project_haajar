import 'package:flutter/material.dart';
import 'package:haajar_final/controllers/attendence_controller.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:signals/signals_flutter.dart';

class AttendenceListingScreen extends StatefulWidget {
  const AttendenceListingScreen({super.key});

  @override
  State<AttendenceListingScreen> createState() =>
      _AttendenceListingScreenState();
}

class _AttendenceListingScreenState extends State<AttendenceListingScreen> {
  @override
  void dispose() {
    Nearby().stopDiscovery();
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
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: Watch(
        (context) {
          return ListView.builder(
            itemCount: attendenceController.discoveredDevices.value.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  attendenceController.discoveredDevices.value[index]
                      ['userName']!,
                ),
                subtitle: Text(
                  attendenceController.discoveredDevices.value[index]['id']!,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
