function load_Day(month, day, weekday) {

    dayList.clear()
    db.transaction(function (tx) {

        var num = 0
        var dataSTR = "SELECT day FROM Schedule WHERE schoolcode ='"
                + schoolCode + "' AND month =" + month
        var pull = tx.executeSql(dataSTR)


        /* if (selected_month !== month) {
            monthoffset = monthoffset + 1
        } */
        while (pull.rows.length > num) {

            if (pull.rows.item(num).day.split(":")[0] === day) {
                dayList.append({
                                   name: pull.rows.item(num).day.split(":")[1]
                               })
                break
            } else {
                var classes = pull.rows.item(num).day.split(";")
                /*var dom = (weekday - monthoffset) + 1 */
                var week = (weekday % 7) + 1

                /* var dow = dom - week */
                for (var classnum = 0; classnum < (classes.length - 1); classnum = classnum + 1) {
                    if (selected_month === month || educator === "login") {

                        if (classes[classnum].split(":")[1].split(
                                    ",")[week] === "true") {

                            dayList.append({
                                               name: pullField(
                                                         "course", "Name",
                                                         classes[classnum].split(
                                                             ":")[1].split(
                                                             ",")[0])
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
    db.transaction(function (tx) {

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
                                                   name: pullField("lesson",
                                                                   "Name",
                                                                   theclass[0]),
                                                   about: pullField(
                                                              "lesson",
                                                              "About",
                                                              theclass[0]),
                                                   unit: pullField("lesson",
                                                                   "Unit",
                                                                   theclass[0]),
                                                   duration: pullField(
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

function save_schedule(month, day) {

    db.transaction(function (tx) {
        var data = [userid, month, day + ";", schoolCode, userCode, d.getTime(
                        ), d.getTime()]
        var dtable = "INSERT INTO Schedule VALUES(?,?,?,?,?,?,?)"

        var dataSTR = "SELECT * FROM Schedule WHERE schoolcode ='" + schoolCode + "'"

        var pull = tx.executeSql(dataSTR)
        if (pull.rows.length !== 1) {
            tx.executeSql(dtable, data)
        } else {
            var daysTasks = pull.rows.item(0).day

            if (daysTasks.search(day.split(":")[1]) === -1) {
                tx.executeSql(
                            "UPDATE Schedule SET day='" + daysTasks + day
                            + ";' , editdate =" + d.getTime(
                                ) + " WHERE schoolcode ='" + schoolCode + "' AND month =" + month)
            } else {
                console.log("Class already added")
            }
        }
    })
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

    db.transaction(function (tx) {
        var dataSTR = ""
        if (table !== "Lessons") {
            dataSTR = "SELECT * FROM " + table + " WHERE creationdate =" + id
        } else {
            dataSTR = "SELECT * FROM " + table + " WHERE coursenumber =" + id
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
                }
                break
            }
        }
    })

    return returned
}
