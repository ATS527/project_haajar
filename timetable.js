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
                subject = getRandomSubject(s7Subjects, day.subjectsS7[i - 1]);
            }
            coolDownFaculties.push(findFaculty(subject));
            day.subjectsS7[i] = subject;
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
                subject = getRandomSubject(s5Subjects, day.subjectsS5[i - 1]);
            }
            coolDownFaculties.push(findFaculty(subject));
            day.subjectsS5[i] = subject;
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
                subject = getRandomSubject(s3CSSubjects, day.subjectsS3CS[i - 1]);
            }
            coolDownFaculties.push(findFaculty(subject));
            day.subjectsS3CS[i] = subject;
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
                subject = getRandomSubject(s3AISubjects, day.subjectsS3AI[i - 1]);
            }
            coolDownFaculties.push(findFaculty(subject));
            day.subjectsS3AI[i] = subject;
            subjectsWithHoursInWeek[subject] -= 1;
            if (subjectsWithHoursInWeek[subject] == 0) {
                s3AISubjects.splice(s3AISubjects.indexOf(subject), 1);
            }
            facultiesWithSubjects[findFaculty(subject)]["hours"] -= 1;
        }
        coolDownFaculties = [];
    }
}

console.log(timeTable);

console.log(subjectsWithHoursInWeek);

console.log(facultiesWithSubjects);

function getRandomSubject(subjects, previousSubject) {
    var randomSubject = subjects[Math.floor(Math.random() * subjects.length)];
    var faculty = findFaculty(randomSubject);

    if (randomSubject == previousSubject) {
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