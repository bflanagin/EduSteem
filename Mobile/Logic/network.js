function checkESAccount(id) {
    var d = new Date()
    var code = ""
    var http = new XMLHttpRequest()
    var pull = ""

   var url  = "https://openseed.vagueentertainment.com:8675/devs/Vag-01001011/vagEdu-053018/scripts/check.php"

    http.onreadystatechange = function () {
        if (http.readyState === XMLHttpRequest.DONE) {

            if (http.responseText == "100") {

                console.log("Incorrect DevID")
            } else if (http.responseText == "101") {
                console.log("Incorrect AppID")
            } else {
                code = http.responseText

                if(code.length > 3) {
                    userCode = code
                    retrieveFromOpenSeed(userID,userCode,"Educator",false)
                }



            }
        }
    }
    http.open('POST', url.trim(), true)

    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
    http.send("devid=" + devId + "&appid=" + appId + "&userid=" + id
              + "&type=Educator&return=code" )


}

function oneTime(id, action, forwhat) {

    var code = ""
    var http = new XMLHttpRequest()
    var carddata = ""
    var url = ""

    var pull = ""

    url = "https://openseed.vagueentertainment.com:8675/corescripts/onetime.php?devid="
            + devId + "&appid=" + appId + "&cardid=" + id + "&create=" + action

    var d = new Date()
    http.onreadystatechange = function () {
        if (http.readyState === XMLHttpRequest.DONE) {
            carddata = http.responseText

            if (http.responseText == "100") {

                console.log("Incorrect DevID")
            } else if (http.responseText == "101") {
                console.log("Incorrect AppID")
            } else {
                carddata = http.responseText
                code = carddata
                if (forwhat === "school") {

                    db.transaction(function (tx) {

                        pull = tx.executeSql(
                                    "SELECT * FROM Schools WHERE id='" + userID + "'")
                        if (pull.rows.length === 1) {

                            if (pull.rows.item(0).code === null
                                    || pull.rows.item(0).code.length < 2) {
                                tx.executeSql(
                                            "UPDATE Schools SET code='" + code
                                            + "', editdate=" + d.getTime(
                                                ) + " WHERE id='" + userID + "'")
                            }
                        }

                        schoolCode = code
                        schoolEditDate = d.getTime()
                    })
                } else {

                    db.transaction(function (tx) {

                        pull = tx.executeSql(
                                    "SELECT * FROM Users WHERE id='" + userID + "'")
                        if (pull.rows.length === 1) {

                            if (pull.rows.item(0).code === null
                                    || pull.rows.item(0).code.length < 2) {
                                tx.executeSql(
                                            "UPDATE Users SET code='" + code
                                            + "', editdate=" + d.getTime(
                                                ) + " WHERE id='" + userID + "'")
                            }
                        }

                        userCode = code
                        userEditDate = d.getTime()
                    })
                }
            }
        }
    }
    http.open('GET', url.trim(), true)
    http.send(null)
}

function retrieveFromOpenSeed(id, code, type, update) {

    /* retrieves data to Server */
    var http = new XMLHttpRequest()
    var url = "https://openseed.vagueentertainment.com:8675/devs/Vag-01001011/vagEdu-053018/scripts/retrieve.php"
    var pull = ""
    http.onreadystatechange = function () {

            if (http.readyState === XMLHttpRequest.DONE) {

                if (http.responseText == "100") {
                    console.log("Incorrect DevID")
                } else if (http.responseText == "101") {
                    console.log("Incorrect AppID")
                } else {

                    if (http.responseText.length > 3) {

                        var info = http.responseText.split(";&;")

                        db.transaction(function (tx) {

                            switch (type) {
                            case "School":
                                pull = tx.executeSql(
                                            "SELECT * FROM Schools WHERE code='" + id + "'")
                                break
                            case "Students":
                                pull = tx.executeSql(
                                            "SELECT * FROM Students WHERE code='" + id + "'")
                                break
                            case "Educator":
                                pull = tx.executeSql(
                                            "SELECT * FROM Users WHERE id='" + id + "'")
                                break
                            default:
                                pull = tx.executeSql(
                                            "SELECT * FROM " + type
                                            + " WHERE creationdate='" + id + "'")
                                break
                            }
                                console.log("Updating = "+update)

                            if (update === false) {
                                        console.log("Adding "+type)
                                if (pull.rows.length === 0) {
                                     console.log("Getting info about "+info[1])
                                    switch (type) {
                                    case "School": console.log("adding "+info[1])
                                        schoolName = info[1]
                                        tx.executeSql(
                                                    "INSERT INTO Schools VALUES (?,?,?,?,?,?,?,?,?,?)",
                                                    [userID, 1, info[1], info[2], info[3], info[4], info[5], info[6], info[0], info[7]])
                                        break
                                    case "Educator":
                                        userName = info[2] + " " + info[3]
                                        tx.executeSql(
                                                    "INSERT INTO Users VALUES (?,?,?,?,?,?,?,?,?,?,?)",
                                                    [userID, 1, info[2], info[3], info[4], info[5], info[6], info[7], info[8], info[0], info[9]])
                                        Scripts.loadUser(userID)
                                        break
                                    case "Courses":
                                        tx.executeSql(
                                                    "INSERT INTO Courses VALUES(?,?,?,?,?,?,?)",
                                                    [userID, info[1], info[3], info[4], info[2], info[0], info[7]])
                                        break
                                    case "Units":
                                        tx.executeSql(
                                                    "INSERT INTO Units VALUES(?,?,?,?,?,?,?,?)",
                                                    [userID, info[5], info[1], info[2], info[3], info[4], info[0], info[8]])
                                        break
                                    case "Students":
                                        tx.executeSql(
                                                    "INSERT INTO Students VALUES(?,?,?,?,?,?,?,?,?,?,?,?)",
                                                    [userID, info[2], info[3], info[4], info[6], info[5], info[9], info[8], info[7], "", info[0], info[10]])
                                        break
                                    case "Schedule":
                                        tx.executeSql(
                                                    "INSERT INTO Schedule VALUES(?,?,?,?,?,?,?)",
                                                    [userID, info[1], info[2], info[3], info[4], info[0], info[5]])
                                        break
                                    case "Lessons":

                                        tx.executeSql(
                                                    "INSERT INTO Lessons VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                                                    [userID, info[15], info[17], info[4], info[5], info[1], info[6], info[7], info[2], info[3], info[9], info[8], info[10], info[11], info[12], info[13], info[0], info[16]])
                                        break

                                    case "Lesson_Control":

                                        tx.executeSql(
                                            "INSERT INTO Lesson_Control VALUES(?,?,?,?,?,?,?,?)",
                                             [userID, info[1], info[2], info[3], info[4],info[5],info[0],info[6]]
                                        )
                                        break

                                     case "Student_Assignments":

                                         tx.executeSql(
                                                  "INSERT INTO Student_Assignments VALUES(?,?,?,?,?,?,?)",
                                                      [info[1], info[2], info[3], info[4],info[5],info[0],info[6]]
                                                     )
                                         break

                                    case "Subjects":

                                        tx.executeSql(
                                            "INSERT INTO Subjects VALUES(?,?,?,?,?,?)",
                                             [info[1], info[2], info[3], info[4],info[5],info[0]]
                                        )
                                        break

                                    case "Media":

                                        tx.executeSql(
                                            "INSERT INTO Media VALUES(?,?,?,?,?,?)",
                                             [info[1], info[2], info[3], info[4],info[5],info[0]]
                                        )
                                        break

                                    }
                                }
                            } else {
                                console.log("Updating "+info[1])
                                switch (type) {
                                case "School":
                                    schoolName = info[1]
                                    tx.executeSql(
                                                "UPDATE Schools SET name=?,email=?,phone=?,country=?,state=?,about=?,editdate=? WHERE code =?",
                                                [info[1], info[2], info[3], info[4], info[5], info[6], info[7], info[0]])
                                    break
                                case "Educator":
                                    userName = info[2] + " " + info[3]
                                    tx.executeSql(
                                                "UPDATE Users SET firstname=? , lastname=?, email=?, phone=?, country=?, state=?, about=?, editdate=? WHERE code =?",
                                                [info[2], info[3], info[4], info[5], info[6], info[7], info[8], info[9], info[0]])

                                    break
                                case "Courses":
                                    tx.executeSql(
                                                "UPDATE Courses SET name=?, subject=?,language=?,about=?,editdate=? WHERE creationdate=?",
                                                [info[1], info[3], info[4], info[2], info[7], info[0]])
                                    break
                                case "Units":
                                    tx.executeSql(
                                                "UPDATE Units SET coursenumber=?,unitNum=?,name=?,objective=?,about=?,editdate=? WHERE creationdate=?",
                                                [info[5], info[1], info[2], info[3], info[4], info[7], info[0]])
                                    break
                                case "Students":
                                    tx.executeSql(
                                                "UPDATE Students SET firstname=?,lastname=?,age=?,bday=?,about=?,schoolcode=?,phone=?,email=?,steempost=?,editdate=?",
                                                [info[2], info[3], info[4], info[6], info[5], info[9], info[8], info[7], "", info[10], info[0]])
                                    break
                                case "Schedule":
                                    tx.executeSql(
                                                "UPDATE Schedule SET month=?,day=?,schoolcode=?,educatorcode=?,editdate=? WHERE creationdate =?",
                                                [info[1], info[2], info[3], info[4], info[5], info[0]])
                                    break
                                case "Lessons":

                                    tx.executeSql(
                                                "UPDATE Lessons SET educatorID=?,published=?,coursenumber=?,unitnumber=?,name=?,lessonNum=?,duration=?,about=?,objective=?,supplies=?,resources=?,guidingQuestions=?,lessonSequence=?,studentProduct=?,reviewQuestions=?,editdate=? WHERE creationdate=?",
                                                [info[15], info[17], info[4], info[5], info[1], info[6], info[7], info[2], info[3], info[9], info[8], info[10], info[11], info[12], info[13], info[16], info[0]])
                                    break


                                case "Lesson_Control":

                                    tx.executeSql(
                                        "UPDATE Lesson_Control SET status =?, educatorcode = ?, editdate= ? WHERE creationdate = ?",
                                         [info[2], info[3], info[5],info[0]]
                                    )
                                    break

                                 case "Student_Assignments":
                                     tx.executeSql(
                                              "UPDATE Student_Assignments SET status = ?, qaList =?, editdate = ? WHERE creationdate = ?",
                                                  [info[4],info[5],info[6],info[0]]
                                                 )
                                     break
                                }
                            }
                        })
                    }
                }
            }
    }
    http.open('POST', url.trim(), true)

    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
    http.send("devid=" + devId + "&appid=" + appId + "&userid=" + userID
              + "&code=" + id + "&type=" + type)

    gc()
}

function sync(type, code) {

    /* Syncronizes data with the server */
    var http = new XMLHttpRequest()
    var url = "https://openseed.vagueentertainment.com:8675/devs/Vag-01001011/vagEdu-053018/scripts/sync.php"

    http.onreadystatechange = function () {

        if (http.status === 200) {
            if (http.readyState === 4) {
                if (http.responseText == "100") {
                    console.log("Incorrect DevID")
                } else if (http.responseText == "101") {
                    console.log("Incorrect AppID")
                } else {
                    var pull = ""
                    var num = 0

                    db.readTransaction(function (tx) {

                        var ids = http.responseText.split("\n")


                        if (ids[0] !== "0") {
                            while (ids.length > num) {
                                if (type === "Students") {
                                    pull = tx.executeSql(
                                                "SELECT * FROM " + type
                                                + " WHERE code=" + ids[num].split(
                                                    "::")[0] + "")
                                } else {
                                    pull = tx.executeSql(
                                                "SELECT * FROM " + type
                                                + " WHERE creationdate=" + ids[num].split(
                                                    "::")[0] + "")
                                }
                                if (pull.rows.length === 0) {
                                    console.log("Grabbing " + type + " from Server "
                                                + ids[num].split("::")[0])
                                    retrieveFromOpenSeed(ids[num],
                                                         code, type, false)
                                } else {

                                    var update = ""
                                    if (type === "Students") {
                                        update = tx.executeSql(
                                                    "SELECT * FROM " + type
                                                    + " WHERE code=" + ids[num].split(
                                                        "::")[0] + " AND editdate <"
                                                    + ids[num].split("::")[1])
                                    } else {
                                        update = tx.executeSql(
                                                    "SELECT * FROM " + type
                                                    + " WHERE creationdate=" + ids[num].split(
                                                        "::")[0] + " AND editdate <"
                                                    + ids[num].split("::")[1])
                                    }

                                    if (update.rows.length === 1) {
                                       console.log (ids[num]+" Needs update")
                                        retrieveFromOpenSeed(ids[num].split("::")[0],code, type, true)
                                    }
                                }

                                num = num + 1
                            }
                        } else {
                            console.log("Checking for local data")
                            var sendnum = 0
                            pull = tx.executeSql(
                                        "SELECT * FROM " + type + " WHERE 1")
                            console.log("We have " + pull.rows.length + " " + type + " locally")

                            while (pull.rows.length > sendnum) {

                                if (type === "Students") {
                                    sendToOpenSeed(userID, pull.rows.item(
                                                       sendnum).code, type)
                                } else {

                                    sendToOpenSeed(userID, pull.rows.item(
                                                       sendnum).creationdate,
                                                   type)
                                }

                                sendnum = sendnum + 1
                            }
                        }
                    })
                }
            }
        }
    }
    http.open('POST', url.trim(), true)

    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
    http.send("devid=" + devId + "&appid=" + appId + "&userid=" + userID
              + "&code=" + code + "&type=" + type)
    gc()
}
