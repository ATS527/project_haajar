import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  Widget headerContainer(String text) {
    return Container(
      height: 100,
      width: 600,
      //add a border
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Center(child: Text(text)),
    );
  }

  Widget sideContainer(String text) {
    return Container(
      height: 100,
      width: 100,
      //add a border
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Center(child: Text(text)),
    );
  }

  List<Map<String, dynamic>> timeTable = [
    {
      "day": 'Monday',
      "subjectsS7": [
        {"subject": 'OE', "faculty": 'Neethu R Nair'},
        {"subject": 'ISE', "faculty": 'Laxmi Kant'},
        {"subject": 'AI', "faculty": 'Shijina J Salim'},
        {"subject": 'ISE', "faculty": 'Laxmi Kant'},
        {"subject": "Project", "faculty": "Suma L S,Remya R S"},
        {"subject": "Project", "faculty": "Suma L S,Remya R S"},
      ],
      "subjectsS5": [
        {"subject": 'Disaster', "faculty": 'Vani R'},
        {"subject": 'MSW', "faculty": 'Arya Murali'},
        {"subject": 'Disaster', "faculty": 'Vani R'},
        {"subject": 'MP', "faculty": 'Shijina J Salim'},
        {"subject": 'SS', "faculty": 'Leena Silvoster'},
        {"subject": 'Flat', "faculty": 'Remya R S'}
      ],
      "subjectsS3CS": [
        {"subject": 'OOPS_CS', "faculty": 'Arya Murali'},
        {"subject": 'LSD_CS', "faculty": 'Syama S R'},
        {"subject": 'DM_CS', "faculty": 'Manoj S'},
        'OOPS/DS Lab_CS',
        'OOPS/DS Lab_CS',
        'OOPS/DS Lab_CS'
      ],
      "subjectsS3AI": [
        {"subject": 'DS_AI', "faculty": 'Dancy Kurian'},
        {"subject": 'LSD_AI', "faculty": 'Syama S R'},
        {"subject": 'OOPS_AI', "faculty": 'Shaima Rahim'},
        {"subject": 'DM_AI', "faculty": 'Manoj S'},
        {"subject": 'SE_AI', "faculty": 'Laxmi Kant'},
        {"subject": 'DE_AI', "faculty": 'Mechanical Guest'}
      ]
    },
    {
      "day": 'Tuesday',
      "subjectsS7": [
        'Compiler Lab/Project',
        'Compiler Lab/Project',
        'Compiler Lab/Project',
        {"subject": 'ML/Web', "faculty": 'Meenu Mohan'},
        {"subject": 'ISE', "faculty": 'Laxmi Kant'},
        {"subject": 'OE', "faculty": 'Neethu R Nair'}
      ],
      "subjectsS5": [
        {"subject": 'CN', "faculty": 'Suma L S'},
        {"subject": 'SS', "faculty": 'Leena Silvoster'},
        {"subject": 'MSW', "faculty": 'Arya Murali'},
        {"subject": 'CN', "faculty": 'Suma L S'},
        {"subject": 'SS', "faculty": 'Leena Silvoster'},
        {"subject": 'MP', "faculty": 'Shijina J Salim'}
      ],
      "subjectsS3CS": [
        {"subject": 'OOPS_CS', "faculty": 'Arya Murali'},
        {"subject": 'LSD_CS', "faculty": 'Syama S R'},
        {"subject": 'OOPS_CS', "faculty": 'Arya Murali'},
        {"subject": 'SE_CS', "faculty": 'Laxmi Kant'},
        {"subject": 'DM_CS', "faculty": 'Manoj S'},
        {"subject": 'LSD_CS', "faculty": 'Syama S R'}
      ],
      "subjectsS3AI": [
        {"subject": 'DS_AI', "faculty": 'Dancy Kurian'},
        {"subject": 'SE_AI', "faculty": 'Laxmi Kant'},
        {"subject": 'OOPS_AI', "faculty": 'Shaima Rahim'},
        'OOPS/DS Lab_AI',
        'OOPS/DS Lab_AI',
        'OOPS/DS Lab_AI'
      ]
    },
    {
      "day": 'Wednesday',
      "subjectsS7": [
        {"subject": 'OE', "faculty": 'Neethu R Nair'},
        {"subject": 'ML/Web', "faculty": 'Meenu Mohan'},
        {"subject": 'AI', "faculty": 'Shijina J Salim'},
        'Seminar',
        'Seminar',
        'Seminar'
      ],
      "subjectsS5": [
        {"subject": 'MP', "faculty": 'Shijina J Salim'},
        {"subject": 'SS', "faculty": 'Leena Silvoster'},
        {"subject": 'MP', "faculty": 'Shijina J Salim'},
        'SS and MP Lab/DBMS Lab',
        'SS and MP Lab/DBMS Lab',
        'SS and MP Lab/DBMS Lab'
      ],
      "subjectsS3CS": [
        'OOPS/DS Lab_CS',
        'OOPS/DS Lab_CS',
        'OOPS/DS Lab_CS',
        {"subject": 'DM_CS', "faculty": 'Manoj S'},
        {"subject": 'DE_CS', "faculty": 'Shaima Rahim'},
        'MINOR_CS'
      ],
      "subjectsS3AI": [
        {"subject": 'DE_AI', "faculty": 'Mechanical Guest'},
        {"subject": 'LSD_AI', "faculty": 'Syama S R'},
        {"subject": 'DM_AI', "faculty": 'Manoj S'},
        {"subject": 'OOPS_AI', "faculty": 'Shaima Rahim'},
        {"subject": 'DS_AI', "faculty": 'Dancy Kurian'},
        'MINOR_AI'
      ]
    },
    {
      "day": 'Thursday',
      "subjectsS7": [
        {"subject": 'OE', "faculty": 'Neethu R Nair'},
        {"subject": 'ML/Web', "faculty": 'Meenu Mohan'},
        {"subject": 'ISE', "faculty": 'Laxmi Kant'},
        'Compiler Lab/Project',
        'Compiler Lab/Project',
        'Compiler Lab/Project'
      ],
      "subjectsS5": [
        {"subject": 'CN', "faculty": 'Suma L S'},
        {"subject": 'Flat', "faculty": 'Remya R S'},
        {"subject": 'CN', "faculty": 'Suma L S'},
        {"subject": 'MSW', "faculty": 'Arya Murali'},
        {"subject": 'Flat', "faculty": 'Remya R S'},
        {"subject": 'MSW', "faculty": 'Arya Murali'}
      ],
      "subjectsS3CS": [
        {"subject": 'DS_CS', "faculty": 'Dancy Kurian'},
        {"subject": 'DE_CS', "faculty": 'Shaima Rahim'},
        {"subject": 'SE_CS', "faculty": 'Laxmi Kant'},
        {"subject": 'LSD_CS', "faculty": 'Syama S R'},
        {"subject": 'DM_CS', "faculty": 'Manoj S'},
        'MINOR_CS'
      ],
      "subjectsS3AI": [
        'OOPS/DS Lab_AI',
        'OOPS/DS Lab_AI',
        'OOPS/DS Lab_AI',
        {"subject": 'DM_AI', "faculty": 'Manoj S'},
        {"subject": 'DS_AI', "faculty": 'Dancy Kurian'},
        'MINOR_AI'
      ]
    },
    {
      "day": 'Friday',
      "subjectsS7": [
        {"subject": 'AI', "faculty": 'Shijina J Salim'},
        {"subject": 'ML/Web', "faculty": 'Meenu Mohan'},
        {"subject": 'AI', "faculty": 'Shijina J Salim'},
        'Project',
        'Project',
        'Project'
      ],
      "subjectsS5": [
        'SS and MP Lab/DBMS Lab',
        'SS and MP Lab/DBMS Lab',
        'SS and MP Lab/DBMS Lab',
        {"subject": 'Flat', "faculty": 'Remya R S'},
        {"subject": 'Flat', "faculty": 'Remya R S'},
        'subject'
      ],
      "subjectsS3CS": [
        'MINOR_CS',
        {"subject": 'OOPS_CS', " faculty": 'Arya Murali'},
        {"subject": 'DS_CS', "faculty": 'Dancy Kurian'},
        {"subject": 'DS_CS', "faculty": 'Dancy Kurian'},
        {"subject": 'DS_CS', "faculty": 'Dancy Kurian'},
        'MINOR_CS'
      ],
      "subjectsS3AI": [
        'MINOR_AI',
        {"subject": 'DM_AI', "faculty": 'Manoj S'},
        {"subject": 'LSD_AI', "faculty": 'Syama S R'},
        {"subject": 'OOPS_AI', "faculty": 'Shaima Rahim'},
        {"subject": 'LSD_AI', "faculty": 'Syama S R'},
        'MINOR_AI'
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Time Table Generation",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 30,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    sideContainer("Department"),
                    headerContainer("Monday"),
                    headerContainer("Tuesday"),
                    headerContainer("Wednesday"),
                    headerContainer("Thursday"),
                    headerContainer("Friday"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    sideContainer("S7 CS"),
                    Row(
                      children: [
                        for (var i = 0; i < 6; i++)
                          Container(
                            height: 100,
                            width: 100,
                            //add a border
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                timeTable[0]["subjectsS7"][i]["subject"],
                              ),
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
