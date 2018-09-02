function saveCourse(userid, name, subject, language, about, creationdate) {

    var d = new Date()

    db.transaction(function (tx) {
        var data = [userid, name.replace(/ /g, "_"), subject, language, about, d.getTime(), d.getTime()]
        var dtable = "INSERT INTO Courses VALUES(?,?,?,?,?,?,?)"

        var dataSTR = "SELECT * FROM Courses WHERE id ='" + userid
                + "' AND creationdate =" + creationdate

        var pull = tx.executeSql(dataSTR)
        if (pull.rows.length !== 1) {
            tx.executeSql(dtable, data)
        }
    })
}

function saveUnit(userid, coursenumber, unitnum, name, objective, about, creationdate) {

    var d = new Date()

    if(creationdate === 0) {
        creationdate =d.getTime()
    }

    db.transaction(function (tx) {
        var data = [userid, coursenumber, unitnum, name.replace(/ /g, "_"), objective, about, d.getTime(), d.getTime()]
        console.log(data)
        var dtable = "INSERT INTO Units VALUES(?,?,?,?,?,?,?,?)"

        var dataSTR = "SELECT * FROM Units WHERE id ='" + userid
                + "' AND creationdate =" + creationdate

        var pull = tx.executeSql(dataSTR)
        if (pull.rows.length !== 1) {
            tx.executeSql(dtable, data)
        }
    })
}

function saveLesson(userid, coursenumber, unitnumber, name, lessonNum, duration, about, objective, supplies, resources, guidingQuestions, lessonSequence, reviewQuestions, creationdate) {

    var d = new Date()

    db.transaction(function (tx) {
        var data = [userid, userCode, 0, coursenumber, unitnumber, name.replace(
                        / /g,
                        "_"), lessonNum, duration, about, objective, supplies, resources, guidingQuestions, lessonSequence, " ", reviewQuestions, d.getTime(
                        ), d.getTime()]
        var dtable = "INSERT INTO Lessons VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"

        var dataSTR = "SELECT * FROM Lessons WHERE id ='" + userid
                + "' AND creationdate =" + creationdate

        var pull = tx.executeSql(dataSTR)
        if (pull.rows.length !== 1) {
            tx.executeSql(dtable, data)
        }
    })
}

function loadCourses(userid) {
    db.readTransaction(function (tx) {
        courseList.clear()

        var dataSTR = "SELECT * FROM Courses WHERE id ='" + userid + "'"

        var pull = tx.executeSql(dataSTR)
        var num = 0
        while (pull.rows.length > num) {

            courseList.append({
                                  "name": pull.rows.item(num).name.replace(
                                              /_/g, " "),
                                  "cdate": pull.rows.item(num).creationdate,
                                  "edate": pull.rows.item(num).editdate
                              })

            lessonControlADD(pull.rows.item(num).creationdate)

            num = num + 1
        }
    })
}

function loadQuestions(type) {
    var num = 1
    if (type === 0) {
        gqList.clear()

        while (guidedQuestions.length > num) {
            gqList.append({
                              "question": guidedQuestions[num].split(":::")[0],
                              "answer": guidedQuestions[num].split(":::")[1]
                          })
            num = num + 1
        }
    } else {
        rqList.clear()

        while (reviewQuestions.length > num) {
            rqList.append({
                              "question": reviewQuestions[num].split(":::")[0],
                              "answer": reviewQuestions[num].split(":::")[1]
                          })
            num = num + 1
        }
    }
}

function loadUnits(userid, coursenumber) {

    db.readTransaction(function (tx) {
        unitList.clear()

        var dataSTR = "SELECT * FROM Units WHERE id ='" + userid
                + "' AND coursenumber =" + coursenumber + " ORDER BY unitNum ASC"

        var pull = tx.executeSql(dataSTR)
        var num = 0
        while (pull.rows.length > num) {

            unitList.append({
                                "name": pull.rows.item(num).name.replace(/_/g, " "),
                                "cdate": pull.rows.item(num).creationdate,
                                "edate": pull.rows.item(num).editdate,
                                "about": pull.rows.item(num).objective
                            })
            unitCount = num
            num = num + 1
        }
    })
}

function loadLessons(userid, unitnumber) {

    db.readTransaction(function (tx) {
        lessonList.clear()

        var dataSTR = "SELECT * FROM Lessons WHERE id ='" + userid
                + "' AND unitnumber =" + unitnumber + " ORDER BY lessonNum ASC"

        var pull = tx.executeSql(dataSTR)
        var num = 0
        while (pull.rows.length > num) {

            var aboutblock = ""

            if (pull.rows.item(num).objective.length > 10) {
                aboutblock = pull.rows.item(num).objective
            } else {
                aboutblock = pull.rows.item(num).about
            }

            lessonList.append({
                                  "name": pull.rows.item(num).name.replace(
                                              /_/g, " "),
                                  "cdate": pull.rows.item(num).creationdate,
                                  "edate": pull.rows.item(num).editdate,
                                  "about": aboutblock,
                                  "duration": pull.rows.item(num).duration
                              })

            num = num + 1
        }
    })
}

function loadCourse(userid, coursenumber) {

    db.readTransaction(function (tx) {

        var dataSTR = "SELECT * FROM Courses WHERE id ='" + userid
                + "' AND creationdate =" + coursenumber

        var pull = tx.executeSql(dataSTR)

        if (pull.rows.length === 1) {

            courseName = pull.rows.item(0).name.replace(/_/g, " ")
            courseAbout = pull.rows.item(0).about
            courseSubject = pull.rows.item(0).subject
            courseDate = new Date(pull.rows.item(
                                      0).creationdate).toLocaleDateString()
        }
    })
}

function loadUnit(userid, unitnumber) {

    db.transaction(function (tx) {

        var dataSTR = "SELECT * FROM Units WHERE id ='" + userid
                + "' AND creationdate =" + unitnumber

        var pull = tx.executeSql(dataSTR)

        if (pull.rows.length === 1) {

            unitTitle = pull.rows.item(0).name.replace(/_/g, " ")
            unitAbout = pull.rows.item(0).about
            unitObjective = pull.rows.item(0).objective
        }
    })
}

function loadLesson(userid, lessonnumber) {

    db.readTransaction(function (tx) {

        var dataSTR = "SELECT * FROM Lessons WHERE id ='" + userid
                + "' AND creationdate =" + lessonnumber

        var pull = tx.executeSql(dataSTR)

        if (pull.rows.length === 1) {

            var d = new Date(pull.rows.item(0).creationdate)
            lessonAuthor = pull.rows.item(0).educatorID
            lessonPublished = pull.rows.item(0).published
            lessonTitle = pull.rows.item(0).name.replace(/_/g, " ")
            lessonAbout = pull.rows.item(0).about
            lessonObjective = pull.rows.item(0).objective

            lessonResources = pull.rows.item(0).resources
            lessonSupplies = pull.rows.item(0).supplies
            lessonSequence = pull.rows.item(0).lessonSequence
            lessonSP = pull.rows.item(0).studentProduct

            lessonGQ = pull.rows.item(0).guidingQuestions
            //lessonRQ = pull.rows.item(0).reviewQuestions
            guidedQuestions = pull.rows.item(0).guidingQuestions
           // reviewQuestions = pull.rows.item(0).reviewQuestions.split(",")
            reviewQuestions = ""

            lessonDuration = pull.rows.item(0).duration
            lessonOrder = pull.rows.item(0).lessonNum
            lessonDate = d.toLocaleDateString()


        }
    })
            lessonStatus = lessonControlINFO("any","status","all",lessonnumber)
    loadQuestions(1)
}

function editField(type, where, id, change) {

    var table = ""
    var field = ""

    var d = new Date()

    switch (type) {
    case "Title":
        field = "name"
        break
    case "About":
        field = "about"
        break
    case "Objective":
        field = "objective"
        break
    case "Resources":
        field = "resources"
        break
    case "Supplies":
        field = "supplies"
        break
    case "gq":
        field = "guidingQuestions"
        break
    case "Sequence":
        field = "lessonSequence"
        break
    case "rq":
        field = "reviewQuestions"
        break
    case "studentProduct":
        field = "studentProduct"
        break
    }

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

        var dataSTR = "SELECT * FROM " + table + " WHERE id ='" + userID
                + "' AND creationdate =" + id
        var pull = tx.executeSql(dataSTR)

        if (pull.rows.length === 1) {
            console.log(pull.rows.item(0).name)

            tx.executeSql(
                        "UPDATE " + table + " SET " + field + "='" + change
                        + "', editdate=" + d.getTime(
                            ) + " WHERE id ='" + userID + "' AND creationdate =" + id)
        }
    })
}

function pullField(type, where, id) {

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
    case "subject":
        table = "Subjects"
        break
    case "educator":
        table = "Users"
    }

    db.readTransaction(function (tx) {

        var dataSTR = ""
        switch (table) {
        case "Subjects":dataSTR = "SELECT * FROM " + table + " WHERE schoolCode ='" + schoolCode
                    + "' AND subjectNumber =" + id
                 break
        case "Users":dataSTR = "SELECT * FROM " + table + " WHERE  code ='" + id+"'"
                break
        default: dataSTR = "SELECT * FROM " + table + " WHERE id ='" + userID
                + "' AND creationdate =" + id
            break
        }
        var pull = tx.executeSql(dataSTR)

        if (pull.rows.length === 1) {
            switch (type) {
            case "Title":
                returned = pull.rows.item(0).name.replace(/_/g, " ")
                break
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
            case "studentProduct":
                returned = pull.rows.item(0).studentProduct
                break
            case "Product":
                returned = pull.rows.item(0).studentProduct
                break
            case "Subject":
                returned = pull.rows.item(0).subject
                break
            case "Color":
                returned = pull.rows.item(0).subjectColor
                break
             case "FullName":
                 returned = pull.rows.item(0).firstname+" "+pull.rows.item(0).lastname
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

function pullAssignmentTypes(category) {


    /* For now we'll make this a simple as possible but later we will want this stored in a database */
    switch (category) {
    case "Journaling":
        assSelect = ["Simple", "Journal+Image", "Journal+Prompt"]
        break
    case "Writing":
        assSelect = ["Simple", "Writing+Prompt"]
        break
    case "Web":
        assSelect = ["Site Only", "Site+Notes", "Site+Questions"]
        break
    case "Video":
        assSelect = ["Video Only", "Video+Notes", "Video+Questions"]
        break
    case "Reading":
        assSelect = ["Simple", "Book+Notes", "Book+Questions"]
        break
    default:
        assSelect = []
        break
    }
}

function assignmentInfo(category, type) {

    var theinfo = ""
    switch (category) {
    case "Journaling":
        switch (type) {
        case "Simple":
            theinfo = "Free writing area that when done will be found in the students journaling area."
            break
        case "Journal+Image":
            theinfo = "Image upload area plus a free writing area used for student journaling."
            break
        case "Journal+Prompt":
            theinfo = "Prompt inspired journal writing. "
            break
        default:
            theinfo = "No information for this assignement type"
            break
        }
        break
    case "Writing":
        switch (type) {
        case "Simple":
            theinfo = "Large writing space used for writing assignments. Differs from journaling in teacher options"
            break
        case "Writing+Prompt":
            theinfo = "Writing based on supplied prompt."
            break
        default:
            theinfo = "No information for this assignement type"
            break
        }
        break
    case "Web":
        switch (type) {
        case "Site Only":
            theinfo = "For use when you only want the students to read or experience the content on a site"
            break
        case "Site+Notes":
            theinfo = "Site and note taking area, used for students to collect their thoughts on the provided information"
            break
        default:
            theinfo = "No information for this assignement type"
            break
        }
        break
    case "Video":
        switch (type) {
        case "Video Only":
            theinfo = "Simple Video player window "
            break
        case "Video+Notes":
            theinfo = "Site and note taking area, used for students to collect their thoughts on the provided video"
            break
        default:
            theinfo = "No information for this assignement type"
            break
        }
        break
    case "Reading":
        switch (type) {
        case "Simple":
            theinfo = "No information for this assignement type"
            break
        case "Book+Notes":
            theinfo = "No information for this assignement type"
            break
        default:
            theinfo = "No information for this assignement type"
            break
        }
        break
    default:
        switch (type) {
        default:
            theinfo = "No information for this assignement type"
            break
        }
        break
    }

    return theinfo
}


/* The lessonControl functions setup the flow of the program from the educators side. Each lesson will be started and set complete by the teacher or autmatically by the program.
  The statuses of the lesson are as follows:
  0: Not started = Default for all lessons
  1: Started = The teacher has initilazed the lesson to be completed by the students
  2: Teacher set Complete = The teacher manually set the class as completed
  3: automatic close = All students have completed the assignment
  4: continuous = for the classes and lessons that never end. This is a special condition for things like Daily Reviews.

  */
function lessonControlINFO(course, type, status, lessonID) {
    var check = ""
    var returned = ""

    console.log(course, status, lessonID)
    db.readTransaction(function (tx) {

        if(lessonID === undefined) {
        switch (status) {
        case "all":
            check = tx.executeSql(
                        "SELECT * FROM Lesson_Control WHERE coursenumber = ?",
                        [course])
            break
        case "new":
            check = tx.executeSql(
                        "SELECT * FROM Lesson_Control WHERE coursenumber =? AND status < 2",
                        [course])
            break
        case "started":
            check = tx.executeSql(
                        "SELECT * FROM Lesson_Control WHERE coursenumber =? AND status = 1",
                        [course])
            break
        case "tc":
            check = tx.executeSql(
                        "SELECT * FROM Lesson_Control WHERE coursenumber =? AND status = 2",
                        [course])
            break
        case "ac":
            check = tx.executeSql(
                        "SELECT * FROM Lesson_Control WHERE coursenumber =? AND status = 3",
                        [course])
            break
        case "continuous":
            check = tx.executeSql(
                        "SELECT * FROM Lesson_Control WHERE coursenumber =? AND status = 4",
                        [course])
            break
        }

        } else {
            console.log("using lesson ID")
            check = tx.executeSql(
                                    "SELECT * FROM Lesson_Control WHERE lessonID =?",
                                    [lessonID])
        }

        if (check.rows.length === 0) {



            switch (type) {
            case "lessonNumber":
                returned = 0
                break
            case "unitNumber":
                returned = 0
                break
            case "lessonName":
                returned = "No Lessons Found"
                break
            case "unitName":
                returned = "No Units"
                break
            case "status":
                returned = "unknown"
                break
            }
        } else {
            switch (type) {
            case "lessonNumber":
                returned = check.rows.item(0).lessonID
                break
            case "unitNumber":
                returned = check.rows.item(0).unitnumber
                break
            case "lessonName":
                returned = pullField("Title", "lesson",
                                     check.rows.item(0).lessonID)
                break
            case "unitName":
                returned = pullField("Title", "unit",
                                     check.rows.item(0).unitnumber)
                break
            case "status":
                returned = check.rows.item(0).status
                break

            }
        }
    })

    return returned
}

function lessonControlADD(course) {
    var check = ""
    var returned = 0
    var d = new Date()

    db.transaction(function (tx) {

        check = tx.executeSql("SELECT * FROM Lessons WHERE coursenumber= ?",
                              [course])

        if (check.rows.length !== 0) {

            var num = 0
            while (check.rows.length > num) {
                var coursenumber = check.rows.item(num).coursenumber
                var unitnumber = check.rows.item(num).unitnumber
                var lessonID = check.rows.item(num).creationdate

                var data = [userID, coursenumber, unitnumber, lessonID, 0, userCode, d.getTime(
                                ), d.getTime()]

                var dataSTR = "INSERT INTO Lesson_Control VALUES(?,?,?,?,?,?,?,?)"

                var exists = tx.executeSql(
                            "SELECT coursenumber FROM Lesson_Control WHERE lessonID=?",
                            [lessonID])

                if (userID.length > 4 && userCode.length > 4
                        && exists.rows.length === 0) {
                    tx.executeSql(dataSTR, data)
                }

                num = num + 1
            }
        }
    })
}

function lessonControlUpdate(lessonID, status) {

    var check = ""
    var returned = 0
    var d = new Date()
    var data = []
    var dataSTR =""

    db.transaction(function (tx) {

        check = tx.executeSql("SELECT * FROM Lesson_Control WHERE lessonID= ?",
                              [lessonID])

        if (check.rows.length === 1) {

            data = [status, userCode, d.getTime(), lessonID]

            dataSTR = "UPDATE Lesson_Control SET status = ?, educatorcode =? , editdate= ? WHERE lessonID= ?"

            tx.executeSql(dataSTR, data)

        } else if (check.rows.length === 0) {

            data = [status, userCode, d.getTime(), lessonID]

            dataSTR = "INSERT INTO Lesson_Control VALUES(?,?,?,?)"

            tx.executeSql(dataSTR, data)

        }
    })
}

function lessonControlNext(type) {

    var check = ""
    var returned = 0

    db.readTransaction(function (tx) {

        check = tx.executeSql("SELECT * FROM Lesson_Control WHERE status= 1")

        console.log("from Lesson Control Next:" + check.rows.length)

        if (check.rows.length === 1) {

            switch (type) {
            case "lessonNumber":
                returned = check.rows.item(0).lessonID
                break
            case "unitNumber":
                returned = check.rows.item(0).unitnumber
                break
            case "courseNumber":
                returned = check.rows.item(0).coursenumber
                break
            case "courseColor":
                returned = check.rows.item(0).coursenumber
                break
            case "lessonName":
                returned = pullField("Title", "lesson",
                                     check.rows.item(0).lessonID)
                break
            case "unitName":
                returned = pullField("Title", "unit",
                                     check.rows.item(0).unitnumber)
                break
            }
        }
    })

return returned
}


