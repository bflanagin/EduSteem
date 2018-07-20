function saveCourse(userid, name, subject, language, about, creationdate) {

    var d = new Date()

    db.transaction(function (tx) {
        var data = [userid, name.replace(/ /g, "_"), subject.split(
                        " - ")[0], language, about, d.getTime(), d.getTime()]
        var dtable = "INSERT INTO Courses VALUES(?,?,?,?,?,?,?)"

        var dataSTR = "SELECT * FROM Courses WHERE id ='" + userid
                + "' AND creationdate =" + creationdate

        var pull = tx.executeSql(dataSTR)
        if (pull.rows.length !== 1) {
            tx.executeSql(dtable, data)
        }
    })
}

function saveUnit(userid, coursenumber, name, objective, about, creationdate) {

    var d = new Date()

    db.transaction(function (tx) {
        var data = [userid, coursenumber, name.replace(
                        / /g, "_"), objective, about, d.getTime(), d.getTime()]
        var dtable = "INSERT INTO Units VALUES(?,?,?,?,?,?,?)"

        var dataSTR = "SELECT * FROM Units WHERE id ='" + userid
                + "' AND creationdate =" + creationdate

        var pull = tx.executeSql(dataSTR)
        if (pull.rows.length !== 1) {
            tx.executeSql(dtable, data)
        }
    })
}

function saveLesson(userid, coursenumber, unitnumber, name, lessonNum, duration, about, objective, supplies, resources, guidingQuestions, lessonSequence, studentProduct, reviewQuestions, creationdate) {

    var d = new Date()

    db.transaction(function (tx) {
        var data = [userid, userCode, 0, coursenumber, unitnumber, name.replace(
                        / /g,
                        "_"), lessonNum, duration, about, objective, supplies, resources, guidingQuestions, lessonSequence, studentProduct, reviewQuestions, d.getTime(
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
                                  name: pull.rows.item(num).name.replace(/_/g,
                                                                         " "),
                                  cdate: pull.rows.item(num).creationdate,
                                  edate: pull.rows.item(num).editdate
                              })

            num = num + 1
        }
    })
}

function loadQuestions(type) {
    var num = 1
    if (type === 0) {
        gqList.clear()
       // console.log("Loading Guided Questions")
        while (guidedQuestions.length > num) {
            gqList.append({
                              question: guidedQuestions[num].split(":::")[0],
                              answer: guidedQuestions[num].split(":::")[1]
                          })
            num = num + 1
        }
    } else {
        rqList.clear()
          //  console.log("Loading Review Questions "+reviewQuestions)
        while (reviewQuestions.length > num) {
            rqList.append({
                              question: reviewQuestions[num].split(":::")[0],
                              answer: reviewQuestions[num].split(":::")[1]
                          })
            num = num + 1
        }
    }
}

function loadUnits(userid, coursenumber) {

    db.readTransaction(function (tx) {
        unitList.clear()

        var dataSTR = "SELECT * FROM Units WHERE id ='" + userid
                + "' AND coursenumber =" + coursenumber

        var pull = tx.executeSql(dataSTR)
        var num = 0
        while (pull.rows.length > num) {

            unitList.append({
                                name: pull.rows.item(num).name.replace(/_/g,
                                                                       " "),
                                cdate: pull.rows.item(num).creationdate,
                                edate: pull.rows.item(num).editdate,
                                about: pull.rows.item(num).objective
                            })

            num = num + 1
        }
    })
}

function loadLessons(userid, unitnumber) {

    db.readTransaction(function (tx) {
        lessonList.clear()


        var dataSTR = "SELECT * FROM Lessons WHERE id ='" + userid
                + "' AND unitnumber =" + unitnumber

        var pull = tx.executeSql(dataSTR)
        var num = 0
        while (pull.rows.length > num) {

            lessonList.append({
                                  name: pull.rows.item(num).name.replace(/_/g,
                                                                         " "),
                                  cdate: pull.rows.item(num).creationdate,
                                  edate: pull.rows.item(num).editdate,
                                  about: pull.rows.item(num).objective
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

            lessonGQ = pull.rows.item(0).guidingQuestions
            //lessonRQ = pull.rows.item(0).reviewQuestions
            guidedQuestions = pull.rows.item(0).guidingQuestions
            reviewQuestions = pull.rows.item(0).reviewQuestions.split(",")

            lessonDuration = pull.rows.item(0).duration
            lessonOrder = pull.rows.item(0).lessonNum
            lessonDate = d.toLocaleDateString()

            lessonSequence = pull.rows.item(0).lessonSequence
            lessonSP = pull.rows.item(0).studentProduct
        }
    })

    loadQuestions(1)
    //loadQuestions(0)
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
    case "Product":
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
    }

    db.readTransaction(function (tx) {

        var dataSTR = "SELECT * FROM " + table + " WHERE id ='" + userID
                + "' AND creationdate =" + id
        var pull = tx.executeSql(dataSTR)

        if (pull.rows.length === 1) {
            switch (type) {
            case "Title":
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
        }
    })

    return returned
}
