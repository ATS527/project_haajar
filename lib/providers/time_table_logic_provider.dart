// import 'dart:math';

// import 'package:project_haajar/models/faculty.dart';
// import 'package:project_haajar/models/subject_with_faculty.dart';
// import 'package:project_haajar/models/subject_with_hour.dart';
// import 'package:project_haajar/models/timetable.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'time_table_logic_provider.g.dart';

// @riverpod
// class TimeTableLogic extends _$TimeTableLogic {
//   @override
//   void build() {}

//   List<Faculty> faculties = [
//     Faculty(
//       name: "Syama S R",
//       subjects: ["LSD_CS", "LSD_AI", "Seminar"],
//       hours: 13,
//     ),
//     Faculty(
//       name: "Suma L S",
//       subjects: ["Compiler Lab/Project", "Project", "CN", "MINOR_CS"],
//       hours: 5,
//     ),
//     Faculty(
//       name: "Leena Silvoster",
//       subjects: ["ML/Web", "SS", "OOPS/DS Lab_CS"],
//       hours: 10,
//     ),
//     Faculty(
//       name: "Remya R S",
//       subjects: ["Compiler Lab/Project", "Project", "Seminar", "Flat"],
//       hours: 14,
//     ),
//     Faculty(
//       name: "Meenu Mohan",
//       subjects: ["ML/Web", "Compiler Lab/Project", "SS and MP Lab/DBMS Lab"],
//       hours: 16,
//     ),
//     Faculty(
//       name: "Arya Murali",
//       subjects: ["MSW", "SS and MP Lab/DBMS Lab", "OOPS_CS", "OOPS/DS Lab_CS"],
//       hours: 16,
//     ),
//     Faculty(
//       name: "Vani R",
//       subjects: ["Disaster"],
//       hours: 2,
//     ),
//     Faculty(
//       name: "Mechanical Guest",
//       subjects: ["DE_AI"],
//       hours: 2,
//     ),
//     Faculty(
//       name: "Laxmi Kant",
//       subjects: ["ISE", "SE_AI", "SE_CS"],
//       hours: 7,
//     ),
//     Faculty(
//       name: "Dancy Kurian",
//       subjects: [
//         "DS_CS",
//         "DS_AI",
//         "OOPS/DS Lab_AI",
//         "OOPS/DS Lab_CS",
//         "MINOR_AI"
//       ],
//       hours: 16,
//     ),
//     Faculty(
//       name: "Shijina J Salim",
//       subjects: [
//         "AI",
//         "MP",
//         "SS and MP Lab/DBMS Lab",
//         "OOPS/DS Lab_CS",
//         "MINOR_AI"
//       ],
//       hours: 16,
//     ),
//     Faculty(
//       name: "Shaima Rahim",
//       subjects: [
//         "SS and MP Lab/DBMS Lab",
//         "DE_CS",
//         "OOPS/DS Lab_AI",
//         "OOPS_AI"
//       ],
//       hours: 16,
//     ),
//     Faculty(
//       name: "Rasmiya",
//       subjects: [
//         "Compiler Lab/Project",
//         "Seminar",
//         "OOPS/DS Lab_AI",
//         "ProjectA"
//       ],
//       hours: 14,
//     ),
//     Faculty(
//       name: "Neethu R Nair",
//       subjects: ["OE"],
//       hours: 4,
//     ),
//     Faculty(
//       name: "Manoj S",
//       subjects: ["DM_AI", "DM_CS"],
//       hours: 8,
//     ),
//   ];

//   List<SubjectWithHour> subjectsWithHoursInWeek = [
//     SubjectWithHour(subject: "LSD_AI", hours: 4),
//     SubjectWithHour(subject: "LSD_CS", hours: 4),
//     SubjectWithHour(subject: "CN", hours: 4),
//     SubjectWithHour(subject: "SS", hours: 4),
//     SubjectWithHour(subject: "MP", hours: 4),
//     SubjectWithHour(subject: "Flat", hours: 5),
//     SubjectWithHour(subject: "ML/Web", hours: 4),
//     SubjectWithHour(subject: "MSW", hours: 4),
//     SubjectWithHour(subject: "OOPS_AI", hours: 4),
//     SubjectWithHour(subject: "OOPS_CS", hours: 4),
//     SubjectWithHour(subject: "Disaster", hours: 2),
//     SubjectWithHour(subject: "DM_AI", hours: 4),
//     SubjectWithHour(subject: "DM_CS", hours: 4),
//     SubjectWithHour(subject: "DE_AI", hours: 2),
//     SubjectWithHour(subject: "DE_CS", hours: 2),
//     SubjectWithHour(subject: "ISE", hours: 4),
//     SubjectWithHour(subject: "SE_AI", hours: 2),
//     SubjectWithHour(subject: "SE_CS", hours: 2),
//     SubjectWithHour(subject: "DS_AI", hours: 4),
//     SubjectWithHour(subject: "DS_CS", hours: 4),
//     SubjectWithHour(subject: "AI", hours: 4),
//     SubjectWithHour(subject: "OE", hours: 4),
//   ];

//   List<String> _s7Subjects = [
//     "ML/Web",
//     "ISE",
//     "AI",
//     "OE",
//   ];
//   List<String> _s5Subjects = [
//     "CN",
//     "SS",
//     "MSW",
//     "Disaster",
//     "Flat",
//     "MP",
//   ];
//   List<String> _s3AISubjects = [
//     "OOPS_AI",
//     "SE_AI",
//     "LSD_AI",
//     "DE_AI",
//     "DM_AI",
//     "DS_AI"
//   ];
//   List<String> _s3CSSubjects = [
//     "OOPS_CS",
//     "SE_CS",
//     "LSD_CS",
//     "DE_CS",
//     "DM_CS",
//     "DS_CS"
//   ];

//   List<TimeTable> timeTableS7 = [
//     TimeTable(
//       day: "Monday",
//       subjects: [
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "Project", faculty: "Suma L S,Remya R S"),
//         SubjectWithFaculty(subject: "Project", faculty: "Suma L S,Remya R S"),
//         SubjectWithFaculty(subject: "Project", faculty: "Suma L S,Remya R S"),
//       ],
//     ),
//     TimeTable(
//       day: "Tuesday",
//       subjects: [
//         SubjectWithFaculty(
//             subject: "Compiler Lab/Project",
//             faculty: "Meenu Mohan,Rasmiya/Suma L S,Remya R S"),
//         SubjectWithFaculty(
//             subject: "Compiler Lab/Project",
//             faculty: "Meenu Mohan,Rasmiya/Suma L S,Remya R S"),
//         SubjectWithFaculty(
//             subject: "Compiler Lab/Project",
//             faculty: "Meenu Mohan,Rasmiya/Suma L S,Remya R S"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//       ],
//     ),
//     TimeTable(
//       day: "Wednesday",
//       subjects: [
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(
//             subject: "Seminar", faculty: "Remya R S,Syama S R,Rasmiya"),
//         SubjectWithFaculty(
//             subject: "Seminar", faculty: "Remya R S,Syama S R,Rasmiya"),
//         SubjectWithFaculty(
//             subject: "Seminar", faculty: "Remya R S,Syama S R,Rasmiya"),
//       ],
//     ),
//     TimeTable(
//       day: "Thursday",
//       subjects: [
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(
//             subject: "Compiler Lab/Project",
//             faculty: "Meenu Mohan,Rasmiya/Suma L S,Remya R S"),
//         SubjectWithFaculty(
//             subject: "Compiler Lab/Project",
//             faculty: "Meenu Mohan,Rasmiya/Suma L S,Remya R S"),
//         SubjectWithFaculty(
//             subject: "Compiler Lab/Project",
//             faculty: "Meenu Mohan,Rasmiya/Suma L S,Remya R S"),
//       ],
//     ),
//     TimeTable(
//       day: "Friday",
//       subjects: [
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "Project", faculty: "Suma L S,Remya R S"),
//         SubjectWithFaculty(subject: "Project", faculty: "Suma L S,Remya R S"),
//         SubjectWithFaculty(subject: "Project", faculty: "Suma L S,Remya R S"),
//       ],
//     ),
//   ];

//   List<TimeTable> timeTableS5 = [
//     TimeTable(
//       day: "Monday",
//       subjects: [
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//       ],
//     ),
//     TimeTable(
//       day: "Tuesday",
//       subjects: [
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//       ],
//     ),
//     TimeTable(
//       day: "Wednesday",
//       subjects: [
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(
//             subject: "SS and MP Lab/DBMS Lab",
//             faculty: "Shijina J Salim,Shaima Rahim/Arya Murali,Meenu Mohan"),
//         SubjectWithFaculty(
//             subject: "SS and MP Lab/DBMS Lab",
//             faculty: "Shijina J Salim,Shaima Rahim/Arya Murali,Meenu Mohan"),
//         SubjectWithFaculty(
//             subject: "SS and MP Lab/DBMS Lab",
//             faculty: "Shijina J Salim,Shaima Rahim/Arya Murali,Meenu Mohan"),
//       ],
//     ),
//     TimeTable(
//       day: "Thursday",
//       subjects: [
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//       ],
//     ),
//     TimeTable(
//       day: "Friday",
//       subjects: [
//         SubjectWithFaculty(
//             subject: "SS and MP Lab/DBMS Lab",
//             faculty: "Shijina J Salim,Shaima Rahim/Arya Murali,Meenu Mohan"),
//         SubjectWithFaculty(
//             subject: "SS and MP Lab/DBMS Lab",
//             faculty: "Shijina J Salim,Shaima Rahim/Arya Murali,Meenu Mohan"),
//         SubjectWithFaculty(
//             subject: "SS and MP Lab/DBMS Lab",
//             faculty: "Shijina J Salim,Shaima Rahim/Arya Murali,Meenu Mohan"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//       ],
//     ),
//   ];

//   List<TimeTable> timeTableS3AI = [
//     TimeTable(
//       day: "Monday",
//       subjects: [
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//       ],
//     ),
//     TimeTable(
//       day: "Tuesday",
//       subjects: [
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(
//             subject: "OOPS/DS Lab_AI",
//             faculty: "Shaima Rahim,Suma L S/Dancy Kurian,Syama S R"),
//         SubjectWithFaculty(
//             subject: "OOPS/DS Lab_AI",
//             faculty: "Shaima Rahim,Suma L S/Dancy Kurian,Syama S R"),
//         SubjectWithFaculty(
//             subject: "OOPS/DS Lab_AI",
//             faculty: "Shaima Rahim,Suma L S/Dancy Kurian,Syama S R"),
//       ],
//     ),
//     TimeTable(
//       day: "Wednesday",
//       subjects: [
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "MINOR_AI", faculty: "Shijina J Salim"),
//       ],
//     ),
//     TimeTable(
//       day: "Thursday",
//       subjects: [
//         SubjectWithFaculty(
//             subject: "OOPS/DS Lab_AI",
//             faculty: "Shaima Rahim,Suma L S/Dancy Kurian,Syama S R"),
//         SubjectWithFaculty(
//             subject: "OOPS/DS Lab_AI",
//             faculty: "Shaima Rahim,Suma L S/Dancy Kurian,Syama S R"),
//         SubjectWithFaculty(
//             subject: "OOPS/DS Lab_AI",
//             faculty: "Shaima Rahim,Suma L S/Dancy Kurian,Syama S R"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "MINOR_AI", faculty: "Shijina J Salim"),
//       ],
//     ),
//     TimeTable(
//       day: "Friday",
//       subjects: [
//         SubjectWithFaculty(subject: "MINOR_AI", faculty: "Shijina J Salim"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "MINOR_AI", faculty: "Shijina J Salim"),
//       ],
//     ),
//   ];

//   List<TimeTable> timeTableS3CS = [
//     TimeTable(
//       day: "Monday",
//       subjects: [
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(
//             subject: "OOPS/DS Lab_CS",
//             faculty:
//                 "Arya Murali,Shijina J Salim/Dancy Kurian,Leena Silvoster"),
//         SubjectWithFaculty(
//             subject: "OOPS/DS Lab_CS",
//             faculty:
//                 "Arya Murali,Shijina J Salim/Dancy Kurian,Leena Silvoster"),
//         SubjectWithFaculty(
//             subject: "OOPS/DS Lab_CS",
//             faculty:
//                 "Arya Murali,Shijina J Salim/Dancy Kurian,Leena Silvoster"),
//       ],
//     ),
//     TimeTable(
//       day: "Tuesday",
//       subjects: [
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//         SubjectWithFaculty(subject: "subject", faculty: "nill"),
//       ],
//     ),
//     TimeTable(day: "Wednesday", subjects: [
//       SubjectWithFaculty(subject: "subject", faculty: "nill"),
//       SubjectWithFaculty(subject: "subject", faculty: "nill"),
//       SubjectWithFaculty(subject: "subject", faculty: "nill"),
      
//     ]),
//   ];

//   List<Map<String, dynamic>> _timeTable = [
//     {
//       "day": "Monday",
//       "subjectsS7": [
//         "subject",
//         "subject",
//         "subject",
//         "subject",
//         {"subject": "Project", "faculty": "Suma L S,Remya R S"},
//         {"subject": "Project", "faculty": "Suma L S,Remya R S"}
//       ],
//       "subjectsS5": [
//         "subject",
//         "subject",
//         "subject",
//         "subject",
//         "subject",
//         "subject"
//       ],
//       "subjectsS3CS": [
//         "subject",
//         "subject",
//         "subject",
//         {
//           "subject": "OOPS/DS Lab_CS",
//           "faculty": "Arya Murali,Shijina J Salim/Dancy Kurian,Leena Silvoster"
//         },
//         {
//           "subject": "OOPS/DS Lab_CS",
//           "faculty": "Arya Murali,Shijina J Salim/Dancy Kurian,Leena Silvoster"
//         },
//         {
//           "subject": "OOPS/DS Lab_CS",
//           "faculty": "Arya Murali,Shijina J Salim/Dancy Kurian,Leena Silvoster"
//         }
//       ],
//       "subjectsS3AI": [
//         "subject",
//         "subject",
//         "subject",
//         "subject",
//         "subject",
//         "subject"
//       ],
//     },
//     {
//       "day": "Tuesday",
//       "subjectsS7": [
//         {
//           "subject": "Compiler Lab/Project",
//           "faculty": "Meenu Mohan,Rasmiya/Suma L S,Remya R S"
//         },
//         {
//           "subject": "Compiler Lab/Project",
//           "faculty": "Meenu Mohan,Rasmiya/Suma L S,Remya R S"
//         },
//         {
//           "subject": "Compiler Lab/Project",
//           "faculty": "Meenu Mohan,Rasmiya/Suma L S,Remya R S"
//         },
//         "subject",
//         "subject",
//         "subject"
//       ],
//       "subjectsS5": [
//         "subject",
//         "subject",
//         "subject",
//         "subject",
//         "subject",
//         "subject"
//       ],
//       "subjectsS3CS": [
//         "subject",
//         "subject",
//         "subject",
//         "subject",
//         "subject",
//         "subject"
//       ],
//       "subjectsS3AI": [
//         "subject",
//         "subject",
//         "subject",
//         {
//           "subject": "OOPS/DS Lab_AI",
//           "faculty": "Shaima Rahim,Suma L S/Dancy Kurian,Syama S R"
//         },
//         {
//           "subject": "OOPS/DS Lab_AI",
//           "faculty": "Shaima Rahim,Suma L S/Dancy Kurian,Syama S R"
//         },
//         {
//           "subject": "OOPS/DS Lab_AI",
//           "faculty": "Shaima Rahim,Suma L S/Dancy Kurian,Syama S R"
//         },
//       ],
//     },
//     {
//       "day": "Wednesday",
//       "subjectsS7": [
//         "subject",
//         "subject",
//         "subject",
//         "Seminar",
//         "Seminar",
//         "Seminar"
//       ],
//       "subjectsS5": [
//         "subject",
//         "subject",
//         "subject",
//         {
//           "subject": "SS and MP Lab/DBMS Lab",
//           "faculty": "Shijina J Salim,Shaima Rahim/Arya Murali,Meenu Mohan"
//         },
//         {
//           "subject": "SS and MP Lab/DBMS Lab",
//           "faculty": "Shijina J Salim,Shaima Rahim/Arya Murali,Meenu Mohan"
//         },
//         {
//           "subject": "SS and MP Lab/DBMS Lab",
//           "faculty": "Shijina J Salim,Shaima Rahim/Arya Murali,Meenu Mohan"
//         }
//       ],
//       "subjectsS3CS": [
//         {
//           "subject": "OOPS/DS Lab_CS",
//           "faculty": "Arya Murali,Shijina J Salim/Dancy Kurian,Leena Silvoster"
//         },
//         {
//           "subject": "OOPS/DS Lab_CS",
//           "faculty": "Arya Murali,Shijina J Salim/Dancy Kurian,Leena Silvoster"
//         },
//         {
//           "subject": "OOPS/DS Lab_CS",
//           "faculty": "Arya Murali,Shijina J Salim/Dancy Kurian,Leena Silvoster"
//         },
//         "subject",
//         "subject",
//         {"subject": 'MINOR_CS', "faculty": "Suma L S"}
//       ],
//       "subjectsS3AI": [
//         "subject",
//         "subject",
//         "subject",
//         "subject",
//         "subject",
//         {"subject": 'MINOR_AI', "faculty": "Shijina J Salim"}
//       ],
//     },
//     {
//       "day": "Thursday",
//       "subjectsS7": [
//         "subject",
//         "subject",
//         "subject",
//         {
//           "subject": "Compiler Lab/Project",
//           "faculty": "Meenu Mohan,Rasmiya/Suma L S,Remya R S"
//         },
//         {
//           "subject": "Compiler Lab/Project",
//           "faculty": "Meenu Mohan,Rasmiya/Suma L S,Remya R S"
//         },
//         {
//           "subject": "Compiler Lab/Project",
//           "faculty": "Meenu Mohan,Rasmiya/Suma L S,Remya R S"
//         },
//       ],
//       "subjectsS5": [
//         "subject",
//         "subject",
//         "subject",
//         "subject",
//         "subject",
//         "subject"
//       ],
//       "subjectsS3CS": [
//         "subject",
//         "subject",
//         "subject",
//         "subject",
//         "subject",
//         {"subject": 'MINOR_CS', "faculty": "Suma L S"}
//       ],
//       "subjectsS3AI": [
//         "OOPS/DS Lab_AI",
//         "OOPS/DS Lab_AI",
//         "OOPS/DS Lab_AI",
//         "subject",
//         "subject",
//         {"subject": 'MINOR_AI', "faculty": "Shijina J Salim"}
//       ],
//     },
//     {
//       "day": "Friday",
//       "subjectsS7": [
//         "subject",
//         "subject",
//         "subject",
//         {"subject": "Project", "faculty": "Suma L S,Remya R S"},
//         {"subject": "Project", "faculty": "Suma L S,Remya R S"},
//         {"subject": "Project", "faculty": "Suma L S,Remya R S"},
//       ],
//       "subjectsS5": [
//         {
//           "subject": "SS and MP Lab/DBMS Lab",
//           "faculty": "Shijina J Salim,Shaima Rahim/Arya Murali,Meenu Mohan"
//         },
//         {
//           "subject": "SS and MP Lab/DBMS Lab",
//           "faculty": "Shijina J Salim,Shaima Rahim/Arya Murali,Meenu Mohan"
//         },
//         {
//           "subject": "SS and MP Lab/DBMS Lab",
//           "faculty": "Shijina J Salim,Shaima Rahim/Arya Murali,Meenu Mohan"
//         },
//         "subject",
//         "subject",
//         "subject"
//       ],
//       "subjectsS3CS": [
//         {"subject": 'MINOR_CS', "faculty": "Suma L S"},
//         "subject",
//         "subject",
//         "subject",
//         "subject",
//         {"subject": 'MINOR_CS', "faculty": "Suma L S"}
//       ],
//       "subjectsS3AI": [
//         {"subject": 'MINOR_AI', "faculty": "Shijina J Salim"},
//         "subject",
//         "subject",
//         "subject",
//         "subject",
//         {"subject": 'MINOR_AI', "faculty": "Shijina J Salim"}
//       ],
//     }
//   ];

//   List<String> _coolDownFaculties = [];
// }
