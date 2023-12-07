var facultiesWithSubjects = {
    "Syama S R": {
        "subjects": ["LSD", "Seminar", "Remedial"],
        "hours": 16
    },
    "Suma L S": {
        "subjects": ["Compiler Lab/Project", "CN", "OOPS Lab"],
        "hours": 16
    },
    "Leena Silvoster": {
        "subjects": ["ML/Web", "SS", "MP", "DS Lab"],
        "hours": 16
    },
    "Remya R S": {
        "subjects": ["Compiler Lab/Project", "Seminar", "Flat"],
        "hours": 16

    },
    "Meenu Mohan": {
        "subjects": ["Web", "Compiler Lab/Project", "SS and MP Lab/DBMS Lab"],
        "hours": 16

    },
    "Arya Murali": {
        "subjects": ["MSW", "SS and MP Lab/DBMS Lab", "OOPS", "OOPS Lab"],
        "hours": 16

    },
    "Vani R": {
        "subjects": ["Disaster"],
        "hours": 2
    },
    "Mechanical Guest": {
        "subjects": ["DE"],
        "hours": 2
    },
    "Laxmi Kant": {
        "subjects": ["ISE", "SE"],
        "hours": 5
    },
    "Dancy Kurian": {
        "subjects": ["DS", "DS Lab", "Remedial"],
        "hours": 16
    },
    "Shijina J Salim": {
        "subjects": ["AI", "MP", "SS and MP Lab/DBMS Lab", "SS", "OOPS Lab"],
        "hours": 16

    },
    "Shaima Rahim": {
        "subjects": ["SS and MP Lab/DBMS Lab", "DE", "LSD", "OOPS Lab", "OOPS"],
        "hours": 16

    },
    "Rasmiya": {
        "subjects": ["Compiler Lab/Project", "Seminar", "DS Lab", "DS", "Compiler Lab/Project"],
        "hours": 16

    },
    "Neethu R Nair": {
        "subjects": ["OE"],
        "hours": 3

    },
    "Manoj S": {
        "subjects": ["DM"],
        "hours": 8
    }
};

var subjectsWithHoursInWeek = {
    "LSD": 4,
    "Seminar": 3,
    "Project": 3,
    "ProjectA": 3,  //additional standalone hour
    "CN": 5,
    "OOPS Lab": 3,
    "ML": 3,
    "SS": 5,
    "MP": 4,
    "DS Lab": 3,
    "Flat": 5,
    "Web": 3,
    "Compiler Lab": 3,
    "MSW": 3,
    "OOPS": 4,
    "Disaster": 2,
    "DM": 4,
    "DE": 2,
    "ISE": 3,
    "SE": 2,
    "DS": 4,
    "AI": 4,
    "SS and MP Lab/DBMS Lab": 6,
    "OE": 3
};


var timeTableForS7 = [
    {
        "day": "Monday",
        "subjects": []
    },
    {
        "day": "Tuesday",
        "subjects": []
    },
    {
        "day": "Wednesday",
        "subjects": []
    },
    {
        "day": "Thursday",
        "subjects": []
    },
    {
        "day": "Friday",
        "subjects": []
    }
];

var s7Subjects = ["ML/Web", "ISE", "AI", "OE", "Compiler Lab/Project", "ProjectA", "Seminar"];

var timeTableForS5 = [
    {
        "day": "Monday",
        "subjects": []
    },
    {
        "day": "Tuesday",
        "subjects": []
    },
    {
        "day": "Wednesday",
        "subjects": []
    },
    {
        "day": "Thursday",
        "subjects": []
    },
    {
        "day": "Friday",
        "subjects": []
    }
];

var s5Subjects = ["CN", "SS", "MSW", "Disaster", "Flat", "MP", "SS and MP Lab/DBMS Lab"];

var day = 0;
while (day <= 4) {
    while (timeTableForS5[day]["subjects"].length < 6 && s5Subjects.length != 0) {
        var subject = selectSubject(timeTableForS5[day]["subjects"].length, timeTableForS5[day]["subjects"][timeTableForS5[day]["subjects"].length - 1]);
        if (isLab(subject)) {
            if (timeTableForS5[day]["subjects"].length < 5) {
                timeTableForS5[day]["subjects"].push(subject);
                timeTableForS5[day]["subjects"].push(subject);
                timeTableForS5[day]["subjects"].push(subject);
                decrementHour(subject);
            }
        } else {
            timeTableForS5[day]["subjects"].push(subject);
            decrementHour(subject);
        }
    }
    day++;
}



console.log(timeTableForS5);

console.log(facultiesWithSubjects);

function selectSubject(timeOfDay, previousSubject) {
    var subject = s5Subjects[Math.floor(Math.random() * s5Subjects.length)];

    if (isLab(subject)) {
        if (timeOfDay == 0 || timeOfDay == 3) {
            return subject;
        } else {
            return selectSubject(timeOfDay, previousSubject);
        }
    } else if (subject == previousSubject) {
        return selectSubject(timeOfDay, previousSubject);
    } else {
        return subject;
    }
}



function decrementHour(subject) {
    let faculty = findFaculty(subject);
    if (isLab(subject)) {
        facultiesWithSubjects[faculty[0]]["hours"] = facultiesWithSubjects[faculty[0]]["hours"] - 3;
        facultiesWithSubjects[faculty[1]]["hours"] = facultiesWithSubjects[faculty[1]]["hours"] - 3;
        facultiesWithSubjects[faculty[2]]["hours"] = facultiesWithSubjects[faculty[2]]["hours"] - 3;
        facultiesWithSubjects[faculty[3]]["hours"] = facultiesWithSubjects[faculty[3]]["hours"] - 3;
        subjectsWithHoursInWeek[subject] = subjectsWithHoursInWeek[subject] - 3;
        if (subjectsWithHoursInWeek[subject] == 0) {
            s5Subjects = s5Subjects.filter(e => e != subject);
        }
    } else {
        facultiesWithSubjects[faculty[0]]["hours"] = facultiesWithSubjects[faculty[0]]["hours"] - 1;
        subjectsWithHoursInWeek[subject] = subjectsWithHoursInWeek[subject] - 1;
        if (subjectsWithHoursInWeek[subject] == 0) {
            s5Subjects = s5Subjects.filter(e => e != subject);
        }
    }
}

function findFaculty(subject) {
    let faculty = [];

    for (const [key, value] of Object.entries(facultiesWithSubjects)) {
        if (value["subjects"].includes(subject)) {
            if (checkFacultyAvailability(key, subject)) {
                faculty.push(key);
            } else {
                continue;
            }
        }
    }

    if (faculty.length == 0) {
        console.log(subject + " not allowed");
        console.log(facultiesWithSubjects);
    }
    return faculty;
}

function checkFacultyAvailability(faculty, subject) {

    const faculty_details = facultiesWithSubjects[faculty];

    if (isLab(subject)) {
        if (faculty_details["hours"] >= 3) {
            return true;
        } else {
            return false;
        }
    } else {
        if (faculty_details["hours"] >= 1) {
            return true;
        } else {
            return false;
        }
    }
}

function isLab(subject) {
    if (subject.indexOf("Lab") > -1) {
        return true;
    }
    return false;
}

