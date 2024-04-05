import 'package:flutter/material.dart';
import 'package:haajar_final/models/attendence.dart';

class AttendenceSummarizerScreen extends StatefulWidget {
  const AttendenceSummarizerScreen({
    super.key,
    required this.attendence,
  });

  final List<Attendence> attendence;

  @override
  State<AttendenceSummarizerScreen> createState() =>
      _AttendenceSummarizerScreenState();
}

class _AttendenceSummarizerScreenState
    extends State<AttendenceSummarizerScreen> {
  @override
  void initState() {
    // TODO: implement initState
    widget.attendence.sort();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendence Summarize"),
      ),
      body: ListView(
        children: [
          ...widget.attendence.map((e) {
            return ListTile(
              title: Text(e.userName),
              subtitle: Text(
                "Total: ${e.id} | Attended: ${e.serviceId}",
              ),
            );
          }),
        ],
      ),
    );
  }
}
