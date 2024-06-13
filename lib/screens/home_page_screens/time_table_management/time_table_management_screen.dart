import 'package:flutter/material.dart';
import 'package:project_haajar/controllers/timetable_controller.dart';
import 'package:project_haajar/models/timetable_display.dart';
import 'package:project_haajar/screens/home_page_screens/time_table_management/add_time_table_screen.dart';
import 'package:project_haajar/widgets/time_table.dart';

class TimeTableManagementScreen extends StatefulWidget {
  const TimeTableManagementScreen({super.key});

  @override
  State<TimeTableManagementScreen> createState() =>
      _TimeTableManagementScreenState();
}

class _TimeTableManagementScreenState extends State<TimeTableManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              const Text(
                "Manage TimeTables here",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              FutureBuilder(
                future: timeTableManagement.getAllTimeTable(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Expanded(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Center(
                              child: Text("No TimeTable found"),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AddTimeTableScreen(),
                                  ),
                                );
                              },
                              child: const Text("Add TimeTable"),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Row(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    columns: _buildTableColumns(),
                                    rows: _buildTableRows(snapshot.data!),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Timetable();
                  } else {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DataColumn> _buildTableColumns() {
    List<DataColumn> columns = [
      DataColumn(label: Text('Year/Class')),
    ];

    // Add hours as columns
    for (String hour in [
      'Hour 1',
      'Hour 2',
      'Hour 3',
      'Hour 4',
      'Hour 5',
      'Hour 6'
    ]) {
      columns.add(DataColumn(label: Text(hour)));
    }

    return columns;
  }

  List<DataRow> _buildTableRows(List<TimeTableDisplay> schedules) {
    List<DataRow> rows = [];

    for (var schedule in schedules) {
      // Initialize map to store subjects for each hour of the day
      Map<String, List<String>> dayToHoursAndSubjects = {
        'Monday': List.filled(6, ''),
        'Tuesday': List.filled(6, ''),
        'Wednesday': List.filled(6, ''),
        'Thursday': List.filled(6, ''),
        'Friday': List.filled(6, ''),
      };

      // Associate each hour with its corresponding day
      for (int i = 0; i < schedule.hours.length; i++) {
        String hour = schedule.hours[i];
        String day = schedule.days[i];
        String subject = schedule.subjects[i];

        // Determine the index of the hour within the day
        int hourIndex = int.parse(hour.split(' ')[1]) - 1;

        // Set the subject for the corresponding day and hour
        dayToHoursAndSubjects[day]?[hourIndex] =
            '$subject (${schedule.teachers[i]})';
      }

      // Add cells for each day and hour
      for (String day in [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday'
      ]) {
        List<DataCell> cells = [DataCell(Text(schedule.yearWithClass))];

        for (String subject in dayToHoursAndSubjects[day]!) {
          cells.add(DataCell(Text(subject)));
        }

        // If there are fewer than 6 subjects for the day, add empty cells
        if (cells.length < 7) {
          int emptyCellCount = 7 - cells.length;
          for (int i = 0; i < emptyCellCount; i++) {
            cells.add(DataCell(Text('')));
          }
        }

        rows.add(DataRow(cells: cells));
      }
    }

    return rows;
  }
}
