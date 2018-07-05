function heartbeat() {

    var http = new XMLHttpRequest()
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/heartbeat.php"

    // console.log(url)
    http.onreadystatechange = function () {

        if (http.status === 200) {
            if (http.readyState === 4) {
                //console.log(http.responseText);
                //userid = http.responseText;
                if (http.responseText === "100") {
                    console.log("Incorrect DevID")
                } else if (http.responseText === "101") {
                    console.log("Incorrect AppID")
                } else {

                    heart = http.responseText
                    beat.interval = 20000

                    // console.log(heart);
                }
            }
        } else {
            heart = "Offline"
        }
    }
    http.open('POST', url.trim(), true)

    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
    http.send("devid=" + devId + "&appid=" + appId + "&userid=" + userid)
}

function checkOpenSeed(userid, code, editdate, type) {

    // console.log(userid, code, type);

    /* Checks for the existance of the data type */
    var http = new XMLHttpRequest()
    var url = "https://openseed.vagueentertainment.com:8675/devs/Vag-01001011/vagEdu-053018/scripts/check.php"

    http.onreadystatechange = function () {

        if (http.status === 200) {
            if (http.readyState === 4) {
                // console.log(http.responseText);
                //userid = http.responseText;
                if (http.responseText == "100") {
                    console.log("Incorrect DevID")
                } else if (http.responseText == "101") {
                    console.log("Incorrect AppID")
                } else {

                    //  console.log(http.responseText.trim());
                    if (parseInt(http.responseText.trim()) === 0) {
                        // console.log("Sending "+type+" to Openseed: "+editdate)
                        sendToOpenSeed(userid, code, type)
                    } else if (type === "Educator"
                               && schoolSetup.state == "Active") {
                        console.log("Moving to Retrieve")
                        retrieveFromOpenSeed(userid, code, type)
                    }
                }
            }
        }
    }
    http.open('POST', url.trim(), true)

    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
    http.send("devid=" + devId + "&appid=" + appId + "&userid=" + userid
              + "&code=" + code + "&editdate=" + editdate + "&type=" + type)
}

function sendToOpenSeed(userid, code, type) {

    /* Sends data to Server */
    var http = new XMLHttpRequest()
    var url = "https://openseed.vagueentertainment.com:8675/devs/Vag-01001011/vagEdu-053018/scripts/update.php"
    var pull = ""

    db.transaction(function (tx) {

        switch (type) {
        case "School":
            pull = tx.executeSql(
                        "SELECT * FROM Schools WHERE id='" + userid + "'")
            break
        case "Educator":
            pull = tx.executeSql(
                        "SELECT * FROM Users WHERE id='" + userid + "'")
            break
        case "Courses":
            pull = tx.executeSql(
                        "SELECT * FROM Courses WHERE id='" + userid + "' AND creationdate=" + code)
            break
        case "Units":
            pull = tx.executeSql(
                        "SELECT * FROM Units WHERE id='" + userid + "' AND creationdate=" + code)
            break
        case "Lessons":
            pull = tx.executeSql(
                        "SELECT * FROM Lessons WHERE id='" + userid + "' AND creationdate=" + code)
            break
        case "Students":
            pull = tx.executeSql(
                        "SELECT * FROM Students WHERE id='" + userid + "' AND code=" + code)
            break
        case "Schedule":
            pull = tx.executeSql(
                        "SELECT * FROM Schedule WHERE id='" + userid + "' AND creationdate=" + code)
            break
        }
        if (pull.rows.length === 1) {

            console.log("Sending " + type)

            http.onreadystatechange = function () {

                if (http.status === 200) {
                    if (http.readyState === 4) {
                        // console.log(http.responseText);
                        //userid = http.responseText;
                        if (http.responseText == "100") {
                            console.log("Incorrect DevID")
                        } else if (http.responseText == "101") {
                            console.log("Incorrect AppID")
                        } else {
                            console.log(http.responseText)
                        }
                    }
                }
            }
            http.open('POST', url.trim(), true)

            http.setRequestHeader("Content-type",
                                  "application/x-www-form-urlencoded")

            switch (type) {
            case "School":
                http.send("devid=" + devId + "&appid=" + appId
                          + "&userid=" + userid + "&name=" + pull.rows.item(
                              0).name + "&email=" + pull.rows.item(0).email
                          + "&phone=" + pull.rows.item(0).phone + "&country="
                          + pull.rows.item(0).country + "&state=" + pull.rows.item(
                              0).state + "&about=" + pull.rows.item(0).about
                          + "&code=" + pull.rows.item(0).code + "&editdate="
                          + pull.rows.item(0).editdate + "&type=" + type)
                break
            case "Educator":
                http.send("devid=" + devId + "&appid=" + appId
                          + "&userid=" + userid + "&firstname=" + pull.rows.item(
                              0).firstname + "&lastname=" + pull.rows.item(0).lastname
                          + "&email=" + pull.rows.item(0).email + "&phone="
                          + pull.rows.item(0).phone + "&country=" + pull.rows.item(
                              0).country + "&state=" + pull.rows.item(0).state
                          + "&about=" + pull.rows.item(0).about + "&code="
                          + pull.rows.item(0).code + "&editdate=" + pull.rows.item(
                              0).editdate + "&type=" + type)
                break
            case "Courses":
                http.send("devid=" + devId + "&appid=" + appId
                          + "&userid=" + userid + "&name=" + pull.rows.item(
                              0).name + "&subject=" + pull.rows.item(0).subject
                          + "&about=" + pull.rows.item(0).about + "&code="
                          + pull.rows.item(0).creationdate + "&language=" + pull.rows.item(
                              0).language + "&schoolCode=" + schoolCode + "&educatorCode="
                          + userCode + "&editdate=" + pull.rows.item(0).editdate + "&type=" + type)
                break
            case "Units":
                http.send("devid=" + devId + "&appid=" + appId
                          + "&userid=" + userid + "&name=" + pull.rows.item(
                              0).name + "&about=" + pull.rows.item(0).about
                          + "&objective=" + pull.rows.item(0).objective + "&code="
                          + pull.rows.item(0).creationdate + "&course=" + pull.rows.item(
                              0).coursenumber + "&schoolCode=" + schoolCode + "&educatorCode="
                          + userCode + "&editdate=" + pull.rows.item(0).editdate + "&type=" + type)
                break
            case "Students":
                http.send("devid=" + devId + "&appid=" + appId
                          + "&userid=" + userid + "&firstname=" + pull.rows.item(
                              0).firstname + "&lastname=" + pull.rows.item(0).lastname
                          + "&age=" + pull.rows.item(0).age + "&bday="
                          + pull.rows.item(0).bday + "&email=" + pull.rows.item(
                              0).email + "&phone=" + pull.rows.item(0).phone
                          + "&about=" + pull.rows.item(0).about + "&code="
                          + pull.rows.item(0).code + "&schoolCode=" + schoolCode
                          + "&editdate=" + pull.rows.item(0).editdate + "&type=" + type)
                break
            case "Schedule":
                http.send("devid=" + devId + "&appid=" + appId
                          + "&userid=" + userid + "&month=" + pull.rows.item(
                              0).month + "&day=" + pull.rows.item(0).day
                          + "&about=" + pull.rows.item(0).about + "&code="
                          + pull.rows.item(0).creationdate + "&schoolCode=" + schoolCode
                          + "&educatorCode=" + userCode + "&editdate=" + pull.rows.item(
                              0).editdate + "&type=" + type)
                break
            case "Lessons":
                http.send("devid=" + devId + "&appid=" + appId + "&userid=" + userid + "&course=" + pull.rows.item(
                              0).coursenumber + "&unit=" + pull.rows.item(0).unitnumber + "&name=" + pull.rows.item(0).name + "&lessonNum=" + pull.rows.item(0).lessonNum + "&duration=" + pull.rows.item(0).duration + "&about=" + pull.rows.item(0).about + "&objective=" + pull.rows.item(0).objective + "&supplies=" + pull.rows.item(0).supplies + "&resources=" + pull.rows.item(
                              0).resources + "&guidingQuestions=" + pull.rows.item(0).guidingQuestions + "&lessonSequence=" + pull.rows.item(0).lessonSequence + "&studentProduct=" + pull.rows.item(0).studentProduct + "&reviewQuestions=" + pull.rows.item(0).reviewQuestions + "&code=" + pull.rows.item(0).creationdate + "&schoolCode=" + schoolCode + "&educatorCode=" + userCode + "&editdate=" + pull.rows.item(0).editdate + "&type=" + type)
                break
            }
        }
    })
}

function retrieveFromOpenSeed(id, code, type) {

    /* retrieves data to Server */
    var http = new XMLHttpRequest()
    var url = "https://openseed.vagueentertainment.com:8675/devs/Vag-01001011/vagEdu-053018/scripts/retrieve.php"
    var pull = ""
    http.onreadystatechange = function () {

        if (http.status === 200) {
            if (http.readyState === 4) {

                if (http.responseText == "100") {
                    console.log("Incorrect DevID")
                } else if (http.responseText == "101") {
                    console.log("Incorrect AppID")
                } else {

                    // console.log("From Retrive "+http.responseText.trim())
                    if (http.responseText.length > 3) {

                        var info = http.responseText.split(";&;")

                        db.transaction(function (tx) {

                            switch (type) {
                            case "School":
                                pull = tx.executeSql(
                                            "SELECT * FROM Schools WHERE code='" + id + "'")
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

                            if (pull.rows.length === 0) {

                                switch (type) {
                                case "School":
                                    schoolName = info[1]
                                    tx.executeSql(
                                                "INSERT INTO Schools VALUES (?,?,?,?,?,?,?,?,?,?)",
                                                [userid, 1, info[1], info[2], info[3], info[4], info[5], info[6], info[0], info[7]])
                                    break
                                case "Educator":
                                    userName = info[2] + " " + info[3]
                                    tx.executeSql(
                                                "INSERT INTO Users VALUES (?,?,?,?,?,?,?,?,?,?,?)",
                                                [userid, 1, info[2], info[3], info[4], info[5], info[6], info[7], info[8], info[0], info[9]])

                                    if (schoolSetup.state == "Active") {
                                        isEducator.checked = 1
                                        view.currentIndex = 1
                                    }
                                    break
                                case "Courses":
                                    tx.executeSql(
                                                "INSERT INTO Courses VALUES(?,?,?,?,?,?,?)",
                                                [userid, info[1], info[3], info[4], info[2], info[0], info[7]])
                                    break
                                case "Units":
                                    tx.executeSql(
                                                "INSERT INTO Units VALUES(?,?,?,?,?,?,?)",
                                                [userid, info[4], info[1], info[2], info[3], info[0], info[7]])
                                    break
                                case "Lessons":

                                    tx.executeSql(
                                                "INSERT INTO Lessons VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                                                [userid, info[15], info[17], info[4], info[5], info[1], info[6], info[7], info[2], info[3], info[9], info[8], info[10], info[11], info[12], info[13], info[0], info[16]])
                                    break
                                }
                            }
                        })
                    } else {

                        //schoolName = qsTr("No school found")
                    }
                }
            }
        }
    }
    http.open('POST', url.trim(), true)

    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
    http.send("devid=" + devId + "&appid=" + appId + "&userid=" + userid
              + "&code=" + id + "&type=" + type)
}

function sync(type, code) {


    /* Syncronizes data with the server */
    var http = new XMLHttpRequest()
    var url = "https://openseed.vagueentertainment.com:8675/devs/Vag-01001011/vagEdu-053018/scripts/sync.php"

    http.onreadystatechange = function () {

        if (http.status === 200) {
            if (http.readyState === 4) {
                //userid = http.responseText;
                if (http.responseText == "100") {
                    console.log("Incorrect DevID")
                } else if (http.responseText == "101") {
                    console.log("Incorrect AppID")
                } else {
                    var pull = ""
                    var num = 0

                    //          console.log(code+" "+ type+" on server: "+http.responseText);
                    db.transaction(function (tx) {

                        var ids = http.responseText.split("\n")
                        while (ids.length > num) {

                            pull = tx.executeSql(
                                        "SELECT * FROM " + type
                                        + " WHERE creationdate=" + ids[num] + "")

                            if (pull.rows.length === 0) {
                                console.log("Grabbing from Server" + ids[num])
                                retrieveFromOpenSeed(ids[num], code, type)
                            }

                            num = num + 1
                        }
                    })
                }
            }
        }
    }
    http.open('POST', url.trim(), true)

    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
    http.send("devid=" + devId + "&appid=" + appId + "&userid=" + userid
              + "&code=" + code + "&type=" + type)
}
