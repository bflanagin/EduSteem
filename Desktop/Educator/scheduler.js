function load_Day(month, day, weekday) {

    dayList.clear()
    db.readTransaction(function (tx) {

        var num = 0
        var dataSTR = "SELECT day FROM Schedule WHERE schoolcode ='"
                + schoolCode + "' AND month =" + month
        var pull = tx.executeSql(dataSTR)

        while (pull.rows.length > num) {

            if (pull.rows.item(num).day.split(":")[0] === day) {
                dayList.append({
                                   "name": pull.rows.item(num).day.split(":")[1]
                               })
                break
            } else {
                var classes = pull.rows.item(num).day.split(";")
                var week = (weekday % 7) + 1

                for (var classnum = 0; classnum < (classes.length - 1); classnum = classnum + 1) {
                    if (selected_month === month || educator === "login") {

                        if (classes[classnum].split(":")[1].split(
                                    ",")[week] === "true") {

                            var subject = Schedule.pullField(
                                        "course", "Subject",
                                        classes[classnum].split(
                                            ":")[1].split(",")[0])

                            var color = "gray"

                            if (subject !== "") {

                                var getSubjectInfo = "SELECT * FROM Subjects WHERE schoolCode='"
                                        + schoolCode + "' AND subjectNumber=" + subject

                                var info = tx.executeSql(getSubjectInfo)

                                if (info.rows.length === 1) {
                                    if (info.rows.item(
                                                0).subjectColor !== null) {
                                        color = info.rows.item(0).subjectColor
                                    }
                                }
                            }

                            var coursenumber = classes[classnum].split(
                                        ":")[1].split(",")[0]

                            Scripts.lessonControlADD(coursenumber)

                            dayList.append({
                                               "coursenumber": coursenumber,
                                               "name": pullField(
                                                           "course", "Name",
                                                           classes[classnum].split(
                                                               ":")[1].split(
                                                               ",")[0]),
                                               "coursecolor": color
                                           })
                        }
                    }
                }
            }

            num = num + 1
        }
    })
}

function load_Classes(month, day) {

    daysClasses.clear()
    db.readTransaction(function (tx) {

        var dataSTR = "SELECT * FROM Schedule WHERE schoolcode ='" + schoolCode
                + "' AND month=" + month

        var pull = tx.executeSql(dataSTR)

        if (pull.rows.length === 1) {
            var day = pull.rows.item(0).day.split(";")
            var num = 0
            while (day.length > num) {

                if (day[num].split(":")[0] === "0") {
                    var theclass = day[num].split(":")[1].split(",")
                    if (theclass[selected_dow] !== "false") {
                        if (pullField("lesson", "Name",
                                      theclass[0]).length > 2) {
                            daysClasses.append({
                                                   "cnum": theclass[0],
                                                   "name": pullField(
                                                               "lesson",
                                                               "Name",
                                                               theclass[0]),
                                                   "about": pullField(
                                                                "lesson",
                                                                "About",
                                                                theclass[0]),
                                                   "unit": pullField(
                                                               "lesson",
                                                               "Unit",
                                                               theclass[0]),
                                                   "duration": pullField(
                                                                   "lesson",
                                                                   "Duration",
                                                                   theclass[0])
                                               })
                        }
                    }
                }

                num = num + 1
            }
        }
    })
}

function load_Class(classNum, month) {

    db.readTransaction(function (tx) {

        var dataSTR = "SELECT * FROM Schedule WHERE schoolcode ='" + schoolCode
                + "' AND month=" + month

        var pull = tx.executeSql(dataSTR)
        var days = pull.rows.item(0).day.split(";")
        var num = 0

        while (days.length > num) {
            if (days[num].split(":")[1].split(",")[0] === classNum.toString()) {

                var theclass = days[num].split(":")[1].split(",")

                className = pullField("course", "Name", theclass[0])

                if (theclass[1] === "true") {
                    sunday.checked = true
                } else {
                    sunday.checked = false
                }
                if (theclass[2] === "true") {
                    monday.checked = true
                } else {
                    monday.checked = false
                }
                if (theclass[3] === "true") {
                    tuesday.checked = true
                } else {
                    tuesday.checked = false
                }
                if (theclass[4] === "true") {
                    wednesday.checked = true
                } else {
                    wednesday.checked = false
                }
                if (theclass[5] === "true") {
                    thursday.checked = true
                } else {
                    thursday.checked = false
                }
                if (theclass[6] === "true") {
                    friday.checked = true
                } else {
                    friday.checked = false
                }
                if (theclass[7] === "true") {
                    saturday.checked = true
                } else {
                    saturday.checked = false
                }

                break
            }
            num = num + 1
        }
    })
}

function save_schedule(month, day, repeatMode, editMode) {

    if (editMode === false) {

        if (repeatMode === 0) {

            db.transaction(function (tx) {
                var data = [userID, month, day + ";", schoolCode, userCode, d.getTime(
                                ), d.getTime()]
                var dtable = "INSERT INTO Schedule VALUES(?,?,?,?,?,?,?)"

                var dataSTR = "SELECT * FROM Schedule WHERE schoolcode ='"
                        + schoolCode + "'AND month=" + month

                var pull = tx.executeSql(dataSTR)
                if (pull.rows.length !== 1) {
                    tx.executeSql(dtable, data)
                } else {
                    var daysTasks = pull.rows.item(0).day

                    if (daysTasks.search(day.split(":")[1]) === -1) {
                        tx.executeSql("UPDATE Schedule SET day='" + daysTasks
                                      + day + ";' , editdate =" + d.getTime(
                                          ) + " WHERE schoolcode ='"
                                      + schoolCode + "' AND month =" + month)
                    } else {
                        console.log("Class already added")
                    }
                }
            })
        } else {
            var num = 0
            var monthsInSchool = schoolYearLength / 30
            while (num < monthsInSchool) {
                var monthnum = 0

                if (num + schoolStartMonth > 12) {
                    monthnum = num + schoolStartMonth
                } else {
                    monthnum = (num + schoolStartMonth) - 12
                }

                db.transaction(function (tx) {
                    var data = [userID, num + schoolStartMonth, day
                                + ";", schoolCode, userCode, d.getTime(
                                    ), d.getTime()]
                    var dtable = "INSERT INTO Schedule VALUES(?,?,?,?,?,?,?)"

                    var dataSTR = "SELECT * FROM Schedule WHERE schoolcode ='"
                            + schoolCode + "' AND month=" + (num + schoolStartMonth)

                    var pull = tx.executeSql(dataSTR)
                    if (pull.rows.length === 0) {
                        tx.executeSql(dtable, data)
                    } else {
                        var daysTasks = pull.rows.item(0).day

                        if (daysTasks.search(day.split(":")[1]) === -1) {
                            tx.executeSql(
                                        "UPDATE Schedule SET day='" + daysTasks
                                        + day + ";' , editdate =" + d.getTime(
                                            ) + " WHERE schoolcode ='" + schoolCode
                                        + "' AND month =" + num + schoolStartMonth)
                        } else {
                            console.log("Class already added")
                        }
                    }
                })

                num = num + 1
            }
        }
    } else {
        var d = new Date()
        db.transaction(function (tx) {
            var data = [userID, num + schoolStartMonth, day
                        + ";", schoolCode, userCode, d.getTime(
                            ), d.getTime()]
            var dtable = "INSERT INTO Schedule VALUES(?,?,?,?,?,?,?)"

            var dataSTR = "SELECT * FROM Schedule WHERE schoolcode ='"
                    + schoolCode + "' AND month=" + (month)

            var pull = tx.executeSql(dataSTR)
                var daysTasks = pull.rows.item(0).day.split(";")
                    var classesBefore = []
                    var classesAfter = []
                    var before = 0
                    var after = 0
                    while(before < daysTasks.length -1) {

                        if(daysTasks[before].split(":")[1].split(",")[0] !== classNum.toString()) {
                            classesBefore.push(daysTasks[before])
                        } else {
                            after = before + 1;
                            break;
                        }
                        before = before+1
                    }
                    while(after < daysTasks.length -1) {
                        classesAfter.push(daysTasks[after])
                       after = after+1
                    }

                console.log("Before "+classesBefore)
                    console.log("Editing "+day)
                console.log("After "+classesAfter)

                    tx.executeSql(
                                "UPDATE Schedule SET day='" + classesBefore.join(";")+";"+day+";"+classesAfter.join(";")
                                + ";' , editdate =" + d.getTime(
                                    ) + " WHERE schoolcode ='" + schoolCode
                                + "' AND month =" + month)
            })
    }
}

function pullField(where, type, id) {

    var table = ""
    var field = ""

    var returned = ""

    switch (where) {
    case "course":
        table = "Courses"
        break
    case "unit":
        table = "Units"
        break
    case "lesson":
        table = "Lessons"
        break
    }

    db.readTransaction(function (tx) {
        var dataSTR = ""
        if (table !== "Lessons") {
            dataSTR = "SELECT * FROM " + table + " WHERE creationdate =" + id
        } else {
            dataSTR = "SELECT * FROM " + table + " WHERE coursenumber =" + parseInt(
                        id)
        }

        var pull = tx.executeSql(dataSTR)

        if (pull.rows.length !== 0) {
            switch (type) {
            case "Name":
                returned = pull.rows.item(0).name.replace(/_/g, " ")
                break
            case "About":
                returned = pull.rows.item(0).about
                break
            case "Objective":
                returned = pull.rows.item(0).objective
                break
            case "Resources":
                returned = pull.rows.item(0).resources
                break
            case "Unit":
                returned = pull.rows.item(0).unitnumber
                break
            case "Duration":
                returned = pull.rows.item(0).duration
                break
            case "Supplies":
                returned = pull.rows.item(0).supplies
                break
            case "gq":
                returned = pull.rows.item(0).guidingQuestions
                break
            case "Sequence":
                returned = pull.rows.item(0).lessonSequence
                break
            case "rq":
                returned = pull.rows.item(0).reviewQuestions
                break
            case "Product":
                returned = pull.rows.item(0).studentProduct
                break
            case "Subject":
                returned = pull.rows.item(0).subject
                break
            }
        } else {
            switch (id) {
            case "12":
                switch (type) {
                case "Name":
                    returned = "Lunch"
                    break
                case "About":
                    returned = "Food Time"
                    break
                case "Duration":
                    returned = 60
                    break
                }
                break
            case "10":
                switch (type) {
                case "Name":
                    returned = "Read to Self"
                    break
                case "About":
                    returned = "Read for pleasure"
                    break
                case "Duration":
                    returned = 45
                    break
                }
                break
            case "8":
                switch (type) {
                case "Name":
                    returned = "P.E."
                    break
                case "About":
                    returned = "Morning Walk"
                    break
                case "Duration":
                    returned = 90
                    break
                case "Subject":
                    returned = "8"
                }
                break
            }
        }
    })

    return returned
}
