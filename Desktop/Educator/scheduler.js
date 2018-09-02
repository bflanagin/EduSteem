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

                        var coursenumber = classes[classnum].split(
                                    ":")[1].split(",")[0]

                        if (classes[classnum].split(":")[1].split(
                                    ",")[week] === "true") {

                            var subject = Courses.pullField(
                                                             "Subject",
                                                             "course",
                                                             coursenumber)

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

                            Courses.lessonControlADD(coursenumber)

                            dayList.append({
                                               "coursenumber": coursenumber,
                                               "name": Courses.pullField(
                                                                 "Name",
                                                                 "course",
                                                                 coursenumber),
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
    console.log("pulling in list for: "+(selected_dow % 7) + 1)

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
                    if (theclass[(selected_dow % 7)+1] !== "false") {
                        if (Courses.pullField( "Name","lesson",
                                      theclass[0]).length > 2) {



                            daysClasses.append({
                                                   "cnum": theclass[0],
                                                   "name": Courses.pullField(
                                                               "Name",
                                                               "lesson",
                                                               theclass[0]),
                                                   "about": Courses.pullField(
                                                                "About",
                                                                "lesson",   
                                                                theclass[0]),
                                                   "unit": Courses.pullField(
                                                               "Unit",
                                                               "lesson",
                                                               theclass[0]),
                                                   "duration": Courses.pullField(
                                                                   "Duration",
                                                                   "lesson",
                                                                   theclass[0]),
                                                   "fullday":day[num].split(":")[1],
                                                   "fulldata":pull.rows.item(0).day
                                               })
                        }
                    } else {

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

                className = Courses.pullField("Name", "course",  theclass[0])

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


function move_Class(month,fullday,direction) {
    var d = new Date()
    var change = 0

    if(direction === "up") {
     change = -1
    } else {
        change = 1
    }


     db.transaction(function (tx) {
         var dataSTR = "SELECT * FROM Schedule WHERE schoolcode ='" + schoolCode
                 + "' AND month=" + month
                var pull = tx.executeSql(dataSTR)

                if(pull.rows.length === 1) {

                    var dayToMove = "0:"+fullday
                    var days = pull.rows.item(0).day.split(";")
                    var currentIndex = days.indexOf(dayToMove)

                    days.splice(currentIndex,1)
                    days.splice(currentIndex+change,0,dayToMove)
                    var newdays = days.join(";")

                   if(currentIndex+change >= 0) {
                    tx.executeSql("UPDATE Schedule SET day = ? , editdate = ? WHERE schoolcode = ? AND month = ?", [newdays,d.getTime(),schoolCode, month])
                    }

                }



     })


}

function save_schedule(month, day, repeatMode, editMode, movement) {
    var d = new Date()
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
                    var data = [userID, monthnum, day
                                + ";", schoolCode, userCode, d.getTime(
                                    ), d.getTime()]
                    var dtable = "INSERT INTO Schedule VALUES(?,?,?,?,?,?,?)"

                    var dataSTR = "SELECT * FROM Schedule WHERE schoolcode ='"
                            + schoolCode + "' AND month=" + monthnum

                    var pull = tx.executeSql(dataSTR)
                    if (pull.rows.length === 0) {
                        tx.executeSql(dtable, data)
                    } else {
                        var daysTasks = pull.rows.item(0).day
                            console.log(daysTasks.search(day.split(":")[1]))
                        if (daysTasks.search(day.split(":")[1]) === -1) {
                            console.log(monthnum,day)
                            tx.executeSql("UPDATE Schedule SET day=? , editdate =? WHERE schoolcode =? AND month = ?"
                                          ,[daysTasks + day+ ";", d.getTime(), schoolCode, monthnum])
                        } else {
                            console.log("Class already added")
                        }
                    }
                })

                num = num + 1
            }
        }
    } else {
        //var d = new Date()
        db.transaction(function (tx) {
            var data = [userID, num + schoolStartMonth, day + ";", schoolCode, userCode, d.getTime(
                            ), d.getTime()]
            var dtable = "INSERT INTO Schedule VALUES(?,?,?,?,?,?,?)"

            var dataSTR = "SELECT * FROM Schedule WHERE schoolcode ='"
                    + schoolCode + "' AND month=" + month

            var pull = tx.executeSql(dataSTR)
            var daysTasks = pull.rows.item(0).day.split(";")
            var classesBefore = []
            var classesAfter = []
            var before = 0
            var after = 0
            while (before < daysTasks.length - 1) {

                if (daysTasks[before].split(":")[1].split(
                            ",")[0] !== classNum.toString()) {
                    classesBefore.push(daysTasks[before])
                } else {
                    after = before + 1
                    break
                }
                before = before + 1
            }
            while (after < daysTasks.length - 1) {
                classesAfter.push(daysTasks[after])
                after = after + 1
            }
            if (repeatMode !== 0) {
                tx.executeSql(
                            "UPDATE Schedule SET day='" + classesBefore.join(
                                ";") + ";" + day + ";" + classesAfter.join(";")
                            + ";' , editdate =" + d.getTime(
                                ) + " WHERE schoolcode ='" + schoolCode + "' AND month =" + month)
            } else {
                tx.executeSql(
                            "UPDATE Schedule SET day='" + classesBefore.join(
                                ";") + ";" + classesAfter.join(";") + ";' , editdate =" + d.getTime(
                                ) + " WHERE schoolcode ='" + schoolCode + "' AND month =" + month)
            }
        })
    }
}

