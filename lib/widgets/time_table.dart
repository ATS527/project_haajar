import 'package:flutter/material.dart';

class Timetable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(// Use LayoutBuilder for responsiveness
        builder: (context, constraints) {
      return SingleChildScrollView(
        // Make DataTable scrollable
        scrollDirection: Axis.horizontal, // Enable horizontal scrolling
        child: ConstrainedBox(
          // Constrain the width of the table
          constraints: BoxConstraints(minWidth: constraints.maxWidth),
          child: DataTable(
            columns: [
              DataColumn(label: Text('Activity Id')),
              DataColumn(label: Text('Day')),
              DataColumn(label: Text('Hour')),
              DataColumn(label: Text('Students Sets')),
              DataColumn(label: Text('Subject')),
              DataColumn(label: Text('Teachers')),
              DataColumn(label: Text('Activity Tags')),
              DataColumn(label: Text('Room')),
              DataColumn(label: Text('Comments')),
            ],
            rows: [
              DataRow(
                cells: [
                  DataCell(Text('5')),
                  DataCell(Text('Monday')),
                  DataCell(Text('Hour 7')),
                  DataCell(Text('4CS')),
                  DataCell(Text('Progra Parad/soft computing')),
                  DataCell(Text('Meenu+Leena')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('6')),
                  DataCell(Text('Friday')),
                  DataCell(Text('Hour 1')),
                  DataCell(Text('4CS')),
                  DataCell(Text('Progra Parad/soft computing')),
                  DataCell(Text('Meenu+Leena')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('7')),
                  DataCell(Text('Thursday')),
                  DataCell(Text('Hour 1')),
                  DataCell(Text('4CS')),
                  DataCell(Text('Progra Parad/soft computing')),
                  DataCell(Text('Meenu+Leena')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('123')),
                  DataCell(Text('Monday')),
                  DataCell(Text('Hour 3')),
                  DataCell(Text('2AI')),
                  DataCell(Text('Digital Lab/OS Lab')),
                  DataCell(Text('Meenu+Arya+Sini+Rasmiya')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
