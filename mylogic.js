
// var tempSubjectsWithHoursInWeek = subjectsWithHoursInWeek;

// var timeTableForS7 = [
//     {
//         "day": "Monday",
//         "subjects": []
//     },
//     {
//         "day": "Tuesday",
//         "subjects": []
//     },
//     {
//         "day": "Wednesday",
//         "subjects": []
//     },
//     {
//         "day": "Thursday",
//         "subjects": []
//     },
//     {
//         "day": "Friday",
//         "subjects": []
//     }
// ];


// var timeTableForS5 = [
//     {
//         "day": "Monday",
//         "subjects": []
//     },
//     {
//         "day": "Tuesday",
//         "subjects": []
//     },
//     {
//         "day": "Wednesday",
//         "subjects": []
//     },
//     {
//         "day": "Thursday",
//         "subjects": []
//     },
//     {
//         "day": "Friday",
//         "subjects": []
//     }
// ];




// var tempTimeTableForS5 = timeTableForS5; //for flushing incase of recursion hell

// var tempS5Subjects = s5Subjects; //recursion hell solution

// var day = 0;
// while (day <= 4) {
//     while (timeTableForS5[day]["subjects"].length < 6 && s5Subjects.length != 0) {
//         var subject = selectSubject(day, timeTableForS5[day]["subjects"].length, timeTableForS5[day]["subjects"][timeTableForS5[day]["subjects"].length - 1]);
//         if (subject == null) {
//             //restarting s5 timetable
//             s5Subjects = tempS5Subjects;
//             timeTableForS5 = tempTimeTableForS5;
//             day = 0;
//             facultiesWithSubjects = tempFacultiesWithSubjects;
//             subjectsWithHoursInWeek = tempSubjectsWithHoursInWeek;
//             continue;
//         }
//         if (isLab(subject)) {
//             if (timeTableForS5[day]["subjects"].length < 5) {
//                 timeTableForS5[day]["subjects"].push(subject);
//                 timeTableForS5[day]["subjects"].push(subject);
//                 timeTableForS5[day]["subjects"].push(subject);
//                 decrementHour(subject);
//             }
//         } else {
//             timeTableForS5[day]["subjects"].push(subject);
//             decrementHour(subject);
//         }
//     }
//     day++;
// }

// console.log(timeTableForS5);

// // console.log(facultiesWithSubjects);

// function selectSubject(day, timeOfDay, previousSubject) {
//     var subject = s5Subjects[Math.floor(Math.random() * s5Subjects.length)];

//     if (isLab(subject)) {
//         if (timeOfDay == 0) {
//             return subject;
//         } else if (timeOfDay == 3 && !isLab(previousSubject)) {
//             return subject;
//         } else {
//             if (s5Subjects.length == 1) {
//                 console.log("ran here too");
//                 return null;
//             }
//             console.log(subject, s5Subjects);
//             return selectSubject(day, timeOfDay, previousSubject);
//         }
//     } else if (subject == previousSubject) {
//         return selectSubject(day, timeOfDay, previousSubject);
//     } else {
//         return subject;
//     }
// }

// function decrementHour(subject) {
//     let faculty = findFaculty(subject);
//     if (isLab(subject)) {
//         facultiesWithSubjects[faculty[0]]["hours"] = facultiesWithSubjects[faculty[0]]["hours"] - 3;
//         facultiesWithSubjects[faculty[1]]["hours"] = facultiesWithSubjects[faculty[1]]["hours"] - 3;
//         facultiesWithSubjects[faculty[2]]["hours"] = facultiesWithSubjects[faculty[2]]["hours"] - 3;
//         facultiesWithSubjects[faculty[3]]["hours"] = facultiesWithSubjects[faculty[3]]["hours"] - 3;
//         subjectsWithHoursInWeek[subject] = subjectsWithHoursInWeek[subject] - 3;
//         if (subjectsWithHoursInWeek[subject] == 0) {
//             s5Subjects = s5Subjects.filter(e => e != subject);
//         }
//     } else {
//         facultiesWithSubjects[faculty[0]]["hours"] = facultiesWithSubjects[faculty[0]]["hours"] - 1;
//         subjectsWithHoursInWeek[subject] = subjectsWithHoursInWeek[subject] - 1;
//         if (subjectsWithHoursInWeek[subject] == 0) {
//             s5Subjects = s5Subjects.filter(e => e != subject);
//         }
//     }
// }

// function findFaculty(subject) {
//     let faculty = [];

//     for (const [key, value] of Object.entries(facultiesWithSubjects)) {
//         if (value["subjects"].includes(subject)) {
//             if (checkFacultyAvailability(key, subject)) {
//                 faculty.push(key);
//             } else {
//                 continue;
//             }
//         }
//     }

//     if (faculty.length == 0) {
//         console.log(subject + " not allowed");
//         console.log(facultiesWithSubjects);
//     }
//     return faculty;
// }

// function checkFacultyAvailability(faculty, subject) {

//     const faculty_details = facultiesWithSubjects[faculty];

//     if (isLab(subject)) {
//         if (faculty_details["hours"] >= 3) {
//             return true;
//         } else {
//             return false;
//         }
//     } else {
//         if (faculty_details["hours"] >= 1) {
//             return true;
//         } else {
//             return false;
//         }
//     }
// }

// function isLab(subject) {
//     if (subject.indexOf("Lab") > -1) {
//         return true;
//     }
//     return false;
// }

