import 'package:flutter/material.dart';
import 'package:haajar_final/controllers/attendence_controller.dart';
import 'package:haajar_final/controllers/authentication_controller.dart';
import 'package:haajar_final/screens/attendence_listing_screen.dart';
import 'package:nearby_connections/nearby_connections.dart';

class AttendenceManagementScreen extends StatefulWidget {
  const AttendenceManagementScreen({super.key});

  @override
  State<AttendenceManagementScreen> createState() =>
      _AttendenceManagementScreenState();
}

class _AttendenceManagementScreenState
    extends State<AttendenceManagementScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    Nearby().stopAdvertising();

    super.dispose();
  }

  bool isInit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Attendence Management',
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                attendenceController.takePermission().then((value) {
                  attendenceController.discoveredDevices.value = [];
                  attendenceController.startScanning(
                    auth.currentlyLoggedInUser.value?.displayName,
                  );
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const AttendenceListingScreen();
                  }));
                }).catchError((err) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        err.toString(),
                      ),
                    ),
                  );
                });
              },
              child: const Text(
                "Start Attendence",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                attendenceController
                    .startAdvertising(
                        auth.currentlyLoggedInUser.value?.displayName)
                    .then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Attendence Given",
                      ),
                    ),
                  );
                }).catchError((err) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        err.toString(),
                      ),
                    ),
                  );
                });
              },
              child: const Text(
                "Give Attendence",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
