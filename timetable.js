var facultiesWithSubjects = {
    "Syama S R": {
        "subjects": ["LSD_CS", "LSD_AI", "Seminar"],
        "hours": 13
    },
    "Suma L S": {
        "subjects": ["Compiler Lab/Project", "Project", "CN", "MINOR_CS"],
        "hours": 5
    },
    "Leena Silvoster": {
        "subjects": ["ML/Web", "SS", "OOPS/DS Lab_CS"],
        "hours": 10
    },
    "Remya R S": {
        "subjects": ["Compiler Lab/Project", "Project", "Seminar", "Flat"],
        "hours": 14
    },
    "Meenu Mohan": {
        "subjects": ["ML/Web", "Compiler Lab/Project", "SS and MP Lab/DBMS Lab"],
        "hours": 16
    },
    "Arya Murali": {
        "subjects": ["MSW", "SS and MP Lab/DBMS Lab", "OOPS_CS", "OOPS/DS Lab_CS"],
        "hours": 16
    },
    "Vani R": {
        "subjects": ["Disaster"],
        "hours": 2
    },
    "Mechanical Guest": {
        "subjects": ["DE_AI"],
        "hours": 2
    },
    "Laxmi Kant": {
        "subjects": ["ISE", "SE_AI", "SE_CS"],
        "hours": 7
    },
    "Dancy Kurian": {
        "subjects": ["DS_CS", "DS_AI", "OOPS/DS Lab_AI", "OOPS/DS Lab_CS", "MINOR_AI"],
        "hours": 16
    },
    "Shijina J Salim": {
        "subjects": ["AI", "MP", "SS and MP Lab/DBMS Lab", "OOPS/DS Lab_CS", "MINOR_AI"],
        "hours": 16
    },
    "Shaima Rahim": {
        "subjects": ["SS and MP Lab/DBMS Lab", "DE_CS", "OOPS/DS Lab_AI", "OOPS_AI"],
        "hours": 16
    },
    "Rasmiya": {
        "subjects": ["Compiler Lab/Project", "Seminar", "OOPS/DS Lab_AI", "ProjectA"],
        "hours": 14
    },
    "Neethu R Nair": {
        "subjects": ["OE"],
        "hours": 4
    },
    "Manoj S": {
        "subjects": ["DM_AI", "DM_CS"],
        "hours": 8
    }
};

var subjectsWithHoursInWeek = {
    "LSD_AI": 4,
    "LSD_CS": 4,
    "CN": 4,
    "SS": 4,
    "MP": 4,
    "Flat": 5,
    "ML/Web": 4,
    "MSW": 4,
    "OOPS_AI": 4,
    "OOPS_CS": 4,
    "Disaster": 2,
    "DM_AI": 4,
    "DM_CS": 4,
    "DE_AI": 2,
    "DE_CS": 2,
    "ISE": 4,
    "SE_AI": 2,
    "SE_CS": 2,
    "DS_AI": 4,
    "DS_CS": 4,
    "AI": 4,
    "OE": 4,
};

var s7Subjects = ["ML/Web", "ISE", "AI", "OE"];
var s5Subjects = ["CN", "SS", "MSW", "Disaster", "Flat", "MP"];
var s3AISubjects = ["OOPS_AI", "SE_AI", "LSD_AI", "DE_AI", "DM_AI", "DS_AI"];
var s3CSSubjects = ["OOPS_CS", "SE_CS", "LSD_CS", "DE_CS", "DM_CS", "DS_CS"];


var timeTable = [
    {
        "day": "Monday",
        "subjectsS7": ["subject", "subject", "subject", "subject", "Project", "Project"],
        "subjectsS5": ["subject", "subject", "subject", "subject", "subject", "subject"],
        "subjectsS3CS": ["subject", "subject", "subject", "OOPS/DS Lab_CS", "OOPS/DS Lab_CS", "OOPS/DS Lab_CS"],
        "subjectsS3AI": ["subject", "subject", "subject", "subject", "subject", "subject"],
    },
    {
        "day": "Tuesday",
        "subjectsS7": ["Compiler Lab/Project", "Compiler Lab/Project", "Compiler Lab/Project", "subject", "subject", "subject"],
        "subjectsS5": ["subject", "subject", "subject", "subject", "subject", "subject"],
        "subjectsS3CS": ["subject", "subject", "subject", "subject", "subject", "subject"],
        "subjectsS3AI": ["subject", "subject", "subject", "OOPS/DS Lab_AI", "OOPS/DS Lab_AI", "OOPS/DS Lab_AI"],
    },
    {
        "day": "Wednesday",
        "subjectsS7": ["subject", "subject", "subject", "Seminar", "Seminar", "Seminar"],
        "subjectsS5": ["subject", "subject", "subject", "SS and MP Lab/DBMS Lab", "SS and MP Lab/DBMS Lab", "SS and MP Lab/DBMS Lab"],
        "subjectsS3CS": ["OOPS/DS Lab_CS", "OOPS/DS Lab_CS", "OOPS/DS Lab_CS", "subject", "subject", "MINOR_CS"],
        "subjectsS3AI": ["subject", "subject", "subject", "subject", "subject", "MINOR_AI"],
    },
    {
        "day": "Thursday",
        "subjectsS7": ["subject", "subject", "subject", "Compiler Lab/Project", "Compiler Lab/Project", "Compiler Lab/Project"],
        "subjectsS5": ["subject", "subject", "subject", "subject", "subject", "subject"],
        "subjectsS3CS": ["subject", "subject", "subject", "subject", "subject", "MINOR_CS"],
        "subjectsS3AI": ["OOPS/DS Lab_AI", "OOPS/DS Lab_AI", "OOPS/DS Lab_AI", "subject", "subject", "MINOR_AI"],
    },
    {
        "day": "Friday",
        "subjectsS7": ["subject", "subject", "subject", "Project", "Project", "Project"],
        "subjectsS5": ["SS and MP Lab/DBMS Lab", "SS and MP Lab/DBMS Lab", "SS and MP Lab/DBMS Lab", "subject", "subject", "subject"],
        "subjectsS3CS": ["MINOR_CS", "subject", "subject", "subject", "subject", "MINOR_CS"],
        "subjectsS3AI": ["MINOR_AI", "subject", "subject", "subject", "subject", "MINOR_AI"],
    }
];

var coolDownFaculties = [];

for (var day of timeTable) {
    for (var i = 0; i < day.subjectsS7.length; i++) {
        if (day.subjectsS7[i] == "subject" && s7Subjects.length > 0) {
            var subject;
            if (i == 0) {
                subject = getRandomSubject(s7Subjects, "");
            } else {
                subject = getRandomSubject(s7Subjects, day.subjectsS7[i - 1]["subject"]);
            }
            var faculty = findFaculty(subject)
            coolDownFaculties.push(faculty);
            day.subjectsS7[i] = {
                "subject": subject,
                "faculty": faculty
            };
            subjectsWithHoursInWeek[subject] -= 1;
            if (subjectsWithHoursInWeek[subject] == 0) {
                s7Subjects.splice(s7Subjects.indexOf(subject), 1);
            }
            facultiesWithSubjects[findFaculty(subject)]["hours"] -= 1;
        }

        if (day.subjectsS5[i] == "subject" && s5Subjects.length > 0) {
            var subject;
            if (i == 0) {
                subject = getRandomSubject(s5Subjects, "");
            } else {
                subject = getRandomSubject(s5Subjects, day.subjectsS5[i - 1]["subject"]);
            }
            var faculty = findFaculty(subject)
            coolDownFaculties.push(faculty);
            day.subjectsS5[i] = {
                "subject": subject,
                "faculty": faculty
            };
            subjectsWithHoursInWeek[subject] -= 1;
            if (subjectsWithHoursInWeek[subject] == 0) {
                s5Subjects.splice(s5Subjects.indexOf(subject), 1);
            }
            facultiesWithSubjects[findFaculty(subject)]["hours"] -= 1;
        }

        if (day.subjectsS3CS[i] == "subject" && s3CSSubjects.length > 0) {
            var subject;
            if (i == 0) {
                subject = getRandomSubject(s3CSSubjects, "");
            } else {
                subject = getRandomSubject(s3CSSubjects, day.subjectsS3CS[i - 1]["subject"]);
            }
            var faculty = findFaculty(subject)
            coolDownFaculties.push(faculty);
            day.subjectsS3CS[i] = {
                "subject": subject,
                "faculty": faculty
            };
            subjectsWithHoursInWeek[subject] -= 1;
            if (subjectsWithHoursInWeek[subject] == 0) {
                s3CSSubjects.splice(s3CSSubjects.indexOf(subject), 1);
            }
            facultiesWithSubjects[findFaculty(subject)]["hours"] -= 1;
        }

        if (day.subjectsS3AI[i] == "subject" && s3AISubjects.length > 0) {
            var subject;
            if (i == 0) {
                subject = getRandomSubject(s3AISubjects, "");
            } else {
                subject = getRandomSubject(s3AISubjects, day.subjectsS3AI[i - 1]["subject"]);
            }
            var faculty = findFaculty(subject)
            coolDownFaculties.push(faculty);
            day.subjectsS3AI[i] = {
                "subject": subject,
                "faculty": faculty
            };
            subjectsWithHoursInWeek[subject] -= 1;
            if (subjectsWithHoursInWeek[subject] == 0) {
                s3AISubjects.splice(s3AISubjects.indexOf(subject), 1);
            }
            facultiesWithSubjects[findFaculty(subject)]["hours"] -= 1;
        }
        coolDownFaculties = [];
    }
}

for (var i of timeTable) {
    console.log(i);
}

console.log(subjectsWithHoursInWeek);

function getRandomSubject(subjects, previousSubject) {
    var randomSubject = subjects[Math.floor(Math.random() * subjects.length)];
    var faculty = findFaculty(randomSubject);

    if (randomSubject === previousSubject) {
        if (subjects.length == 1) {
            return randomSubject;
        }
        return getRandomSubject(subjects, previousSubject);
    }

    if (faculty in coolDownFaculties) {
        return getRandomSubject(subjects);
    }

    return randomSubject;
}

function findFaculty(subject) {
    let faculty;

    for (const [key, value] of Object.entries(facultiesWithSubjects)) {
        if (value["subjects"].includes(subject)) {
            faculty = key;
        }
    }

    return faculty;
}




// List<Map<String, dynamic>> timeTable = [
//   {
//     "day": 'Monday',
//     "subjectsS7": [
//       {"subject": 'OE', "faculty": 'Neethu R Nair'},
//       {"subject": 'ISE', "faculty": 'Laxmi Kant'},
//       {"subject": 'AI', "faculty": 'Shijina J Salim'},
//       {"subject": 'ISE', "faculty": 'Laxmi Kant'},
//       {"subject": "Project", "faculty": "Suma L S,Remya R S"},
//       {"subject": "Project", "faculty": "Suma L S,Remya R S"},
//     ],
//     "subjectsS5": [
//       {"subject": 'Disaster', "faculty": 'Vani R'},
//       {"subject": 'MSW', "faculty": 'Arya Murali'},
//       {"subject": 'Disaster', "faculty": 'Vani R'},
//       {"subject": 'MP', "faculty": 'Shijina J Salim'},
//       {"subject": 'SS', "faculty": 'Leena Silvoster'},
//       {"subject": 'Flat', "faculty": 'Remya R S'}
//     ],
//     "subjectsS3CS": [
//       {"subject": 'OOPS_CS', "faculty": 'Arya Murali'},
//       {"subject": 'LSD_CS', "faculty": 'Syama S R'},
//       {"subject": 'DM_CS', "faculty": 'Manoj S'},
//       {
//         "subject": "OOPS/DS Lab_CS",
//         "faculty": "Arya Murali,Shijina J Salim/Dancy Kurian,Leena Silvoster"
//       },
//       {
//         "subject": "OOPS/DS Lab_CS",
//         "faculty": "Arya Murali,Shijina J Salim/Dancy Kurian,Leena Silvoster"
//       },
//       {
//         "subject": "OOPS/DS Lab_CS",
//         "faculty": "Arya Murali,Shijina J Salim/Dancy Kurian,Leena Silvoster"
//       }
//     ],
//     "subjectsS3AI": [
//       {"subject": 'DS_AI', "faculty": 'Dancy Kurian'},
//       {"subject": 'LSD_AI', "faculty": 'Syama S R'},
//       {"subject": 'OOPS_AI', "faculty": 'Shaima Rahim'},
//       {"subject": 'DM_AI', "faculty": 'Manoj S'},
//       {"subject": 'SE_AI', "faculty": 'Laxmi Kant'},
//       {"subject": 'DE_AI', "faculty": 'Mechanical Guest'}
//     ]
//   },
//   {
//     "day": 'Tuesday',
//     "subjectsS7": [
//       {
//         "subject": "Compiler Lab/Project",
//         "faculty": "Meenu Mohan,Rasmiya/Suma L S,Remya R S"
//       },
//       {
//         "subject": "Compiler Lab/Project",
//         "faculty": "Meenu Mohan,Rasmiya/Suma L S,Remya R S"
//       },
//       {
//         "subject": "Compiler Lab/Project",
//         "faculty": "Meenu Mohan,Rasmiya/Suma L S,Remya R S"
//       },
//       {"subject": 'ML/Web', "faculty": 'Meenu Mohan'},
//       {"subject": 'ISE', "faculty": 'Laxmi Kant'},
//       {"subject": 'OE', "faculty": 'Neethu R Nair'}
//     ],
//     "subjectsS5": [
//       {"subject": 'CN', "faculty": 'Suma L S'},
//       {"subject": 'SS', "faculty": 'Leena Silvoster'},
//       {"subject": 'MSW', "faculty": 'Arya Murali'},
//       {"subject": 'CN', "faculty": 'Suma L S'},
//       {"subject": 'SS', "faculty": 'Leena Silvoster'},
//       {"subject": 'MP', "faculty": 'Shijina J Salim'}
//     ],
//     "subjectsS3CS": [
//       {"subject": 'OOPS_CS', "faculty": 'Arya Murali'},
//       {"subject": 'LSD_CS', "faculty": 'Syama S R'},
//       {"subject": 'OOPS_CS', "faculty": 'Arya Murali'},
//       {"subject": 'SE_CS', "faculty": 'Laxmi Kant'},
//       {"subject": 'DM_CS', "faculty": 'Manoj S'},
//       {"subject": 'LSD_CS', "faculty": 'Syama S R'}
//     ],
//     "subjectsS3AI": [
//       {"subject": 'DS_AI', "faculty": 'Dancy Kurian'},
//       {"subject": 'SE_AI', "faculty": 'Laxmi Kant'},
//       {"subject": 'OOPS_AI', "faculty": 'Shaima Rahim'},
//       {
//         "subject": "OOPS/DS Lab_AI",
//         "faculty": "Shaima Rahim,Suma L S/Dancy Kurian,Syama S R"
//       },
//       {
//         "subject": "OOPS/DS Lab_AI",
//         "faculty": "Shaima Rahim,Suma L S/Dancy Kurian,Syama S R"
//       },
//       {
//         "subject": "OOPS/DS Lab_AI",
//         "faculty": "Shaima Rahim,Suma L S/Dancy Kurian,Syama S R"
//       },
//     ]
//   },
//   {
//     "day": 'Wednesday',
//     "subjectsS7": [
//       {"subject": 'OE', "faculty": 'Neethu R Nair'},
//       {"subject": 'ML/Web', "faculty": 'Meenu Mohan'},
//       {"subject": 'AI', "faculty": 'Shijina J Salim'},
//       {"subject": "Seminar", "faculty": "Remya R S,Syama S R,Rasmiya"},
//       {"subject": "Seminar", "faculty": "Remya R S,Syama S R,Rasmiya"},
//       {"subject": "Seminar", "faculty": "Remya R S,Syama S R,Rasmiya"}
//     ],
//     "subjectsS5": [
//       {"subject": 'MP', "faculty": 'Shijina J Salim'},
//       {"subject": 'SS', "faculty": 'Leena Silvoster'},
//       {"subject": 'MP', "faculty": 'Shijina J Salim'},
//       {
//         "subject": "SS and MP Lab/DBMS Lab",
//         "faculty": "Shijina J Salim,Shaima Rahim/Arya Murali,Meenu Mohan"
//       },
//       {
//         "subject": "SS and MP Lab/DBMS Lab",
//         "faculty": "Shijina J Salim,Shaima Rahim/Arya Murali,Meenu Mohan"
//       },
//       {
//         "subject": "SS and MP Lab/DBMS Lab",
//         "faculty": "Shijina J Salim,Shaima Rahim/Arya Murali,Meenu Mohan"
//       }
//     ],
//     "subjectsS3CS": [
//       {
//         "subject": "OOPS/DS Lab_CS",
//         "faculty": "Arya Murali,Shijina J Salim/Dancy Kurian,Leena Silvoster"
//       },
//       {
//         "subject": "OOPS/DS Lab_CS",
//         "faculty": "Arya Murali,Shijina J Salim/Dancy Kurian,Leena Silvoster"
//       },
//       {
//         "subject": "OOPS/DS Lab_CS",
//         "faculty": "Arya Murali,Shijina J Salim/Dancy Kurian,Leena Silvoster"
//       },
//       {"subject": 'DM_CS', "faculty": 'Manoj S'},
//       {"subject": 'DE_CS', "faculty": 'Shaima Rahim'},
//       {"subject": 'MINOR_CS', "faculty": "Suma L S"}
//     ],
//     "subjectsS3AI": [
//       {"subject": 'DE_AI', "faculty": 'Mechanical Guest'},
//       {"subject": 'LSD_AI', "faculty": 'Syama S R'},
//       {"subject": 'DM_AI', "faculty": 'Manoj S'},
//       {"subject": 'OOPS_AI', "faculty": 'Shaima Rahim'},
//       {"subject": 'DS_AI', "faculty": 'Dancy Kurian'},
//       {"subject": 'MINOR_AI', "faculty": "Shijina J Salim"}
//     ]
//   },
//   {
//     "day": 'Thursday',
//     "subjectsS7": [
//       {"subject": 'OE', "faculty": 'Neethu R Nair'},
//       {"subject": 'ML/Web', "faculty": 'Meenu Mohan'},
//       {"subject": 'ISE', "faculty": 'Laxmi Kant'},
//       {
//         "subject": "Compiler Lab/Project",
//         "faculty": "Meenu Mohan,Rasmiya/Suma L S,Remya R S"
//       },
//       {
//         "subject": "Compiler Lab/Project",
//         "faculty": "Meenu Mohan,Rasmiya/Suma L S,Remya R S"
//       },
//       {
//         "subject": "Compiler Lab/Project",
//         "faculty": "Meenu Mohan,Rasmiya/Suma L S,Remya R S"
//       }
//     ],
//     "subjectsS5": [
//       {"subject": 'CN', "faculty": 'Suma L S'},
//       {"subject": 'Flat', "faculty": 'Remya R S'},
//       {"subject": 'CN', "faculty": 'Suma L S'},
//       {"subject": 'MSW', "faculty": 'Arya Murali'},
//       {"subject": 'Flat', "faculty": 'Remya R S'},
//       {"subject": 'MSW', "faculty": 'Arya Murali'}
//     ],
//     "subjectsS3CS": [
//       {"subject": 'DS_CS', "faculty": 'Dancy Kurian'},
//       {"subject": 'DE_CS', "faculty": 'Shaima Rahim'},
//       {"subject": 'SE_CS', "faculty": 'Laxmi Kant'},
//       {"subject": 'LSD_CS', "faculty": 'Syama S R'},
//       {"subject": 'DM_CS', "faculty": 'Manoj S'},
//       {"subject": 'MINOR_CS', "faculty": "Suma L S"}
//     ],
//     "subjectsS3AI": [
//       {
//         "subject": "OOPS/DS Lab_AI",
//         "faculty": "Shaima Rahim,Suma L S/Dancy Kurian,Syama S R"
//       },
//       {
//         "subject": "OOPS/DS Lab_AI",
//         "faculty": "Shaima Rahim,Suma L S/Dancy Kurian,Syama S R"
//       },
//       {
//         "subject": "OOPS/DS Lab_AI",
//         "faculty": "Shaima Rahim,Suma L S/Dancy Kurian,Syama S R"
//       },
//       {"subject": 'DM_AI', "faculty": 'Manoj S'},
//       {"subject": 'DS_AI', "faculty": 'Dancy Kurian'},
//       {"subject": 'MINOR_AI', "faculty": "Shijina J Salim"}
//     ]
//   },
//   {
//     "day": 'Friday',
//     "subjectsS7": [
//       {"subject": 'AI', "faculty": 'Shijina J Salim'},
//       {"subject": 'ML/Web', "faculty": 'Meenu Mohan'},
//       {"subject": 'AI', "faculty": 'Shijina J Salim'},
//       {"subject": "Project", "faculty": "Suma L S,Remya R S"},
//       {"subject": "Project", "faculty": "Suma L S,Remya R S"},
//       {"subject": "Project", "faculty": "Suma L S,Remya R S"},
//     ],
//     "subjectsS5": [
//       {
//         "subject": "SS and MP Lab/DBMS Lab",
//         "faculty": "Shijina J Salim,Shaima Rahim/Arya Murali,Meenu Mohan"
//       },
//       {
//         "subject": "SS and MP Lab/DBMS Lab",
//         "faculty": "Shijina J Salim,Shaima Rahim/Arya Murali,Meenu Mohan"
//       },
//       {
//         "subject": "SS and MP Lab/DBMS Lab",
//         "faculty": "Shijina J Salim,Shaima Rahim/Arya Murali,Meenu Mohan"
//       },
//       {"subject": 'Flat', "faculty": 'Remya R S'},
//       {"subject": 'Flat', "faculty": 'Remya R S'},
//       {"subject": 'CN', "faculty": 'Suma L S'},
//     ],
//     "subjectsS3CS": [
//       {"subject": 'MINOR_CS', "faculty": "Suma L S"},
//       {"subject": 'OOPS_CS', "faculty": 'Arya Murali'},
//       {"subject": 'DS_CS', "faculty": 'Dancy Kurian'},
//       {"subject": 'DS_CS', "faculty": 'Dancy Kurian'},
//       {"subject": 'DS_CS', "faculty": 'Dancy Kurian'},
//       {"subject": 'MINOR_CS', "faculty": "Suma L S"}
//     ],
//     "subjectsS3AI": [
//       {"subject": 'MINOR_AI', "faculty": "Shijina J Salim"},
//       {"subject": 'DM_AI', "faculty": 'Manoj S'},
//       {"subject": 'LSD_AI', "faculty": 'Syama S R'},
//       {"subject": 'OOPS_AI', "faculty": 'Shaima Rahim'},
//       {"subject": 'LSD_AI', "faculty": 'Syama S R'},
//       {"subject": 'MINOR_AI', "faculty": "Shijina J Salim"}
//     ]
//   }
// ];