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

function checkOpenSeed(userid, code, type) {

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
                        console.log(type+' '+http.responseText.trim())
                    if (http.responseText.trim() !== "1" ) {
                                sendToOpenSeed(userid,code, type)
                    } else if(type === "Educator" && schoolSetup.state == "Active"){
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
              + "&code=" + code + "&type=" + type)
}

function sendToOpenSeed(userid,code,type) {

    /* Sends data to Server */

    var http = new XMLHttpRequest()
    var url = "https://openseed.vagueentertainment.com:8675/devs/Vag-01001011/vagEdu-053018/scripts/update.php"
    var pull = ""

    console.log("Sending "+type+" "+code)

        db.transaction(function (tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS Schools (id TEXT, type INT,name TEXT,email TEXT,phone TEXT,country TEXT,state TEXT,about MEDIUMTEXT, code TEXT)')

            switch(type) {
            case "School":pull = tx.executeSql("SELECT * FROM Schools WHERE id='" + userid + "'");break;
            case "Educator":pull = tx.executeSql("SELECT * FROM Users WHERE id='" + userid + "'");break;
            case "Courses":pull = tx.executeSql("SELECT * FROM Courses WHERE id='" + userid + "' AND creationdate="+code);break;
            case "Units":pull = tx.executeSql("SELECT * FROM Units WHERE id='" + userid + "' AND creationdate="+code);break;
            case "Lessons":pull = tx.executeSql("SELECT * FROM Lessons WHERE id='" + userid + "' AND creationdate="+code);break;
            }
            if (pull.rows.length === 1) {

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

                switch(type) {
                case "School":http.send("devid=" + devId + "&appid=" + appId
                                        + "&userid="+ userid
                                        + "&name=" + pull.rows.item(0).name
                                        + "&email=" + pull.rows.item(0).email
                                        + "&phone=" + pull.rows.item(0).phone
                                        + "&country=" + pull.rows.item(0).country
                                        + "&state=" + pull.rows.item(0).state
                                        + "&about=" + pull.rows.item(0).about
                                        + "&code=" + pull.rows.item(0).code
                                        + "&type=" + type);break;

                case "Educator": http.send("devid=" + devId + "&appid=" + appId
                                           + "&userid=" + userid
                                           + "&firstname=" + pull.rows.item(0).firstname
                                           + "&lastname=" + pull.rows.item(0).lastname
                                           + "&email=" + pull.rows.item(0).email
                                           + "&phone=" + pull.rows.item(0).phone
                                           + "&country="+ pull.rows.item(0).country
                                           + "&state=" + pull.rows.item(0).state
                                           + "&about=" + pull.rows.item(0).about
                                           + "&code=" + pull.rows.item(0).code
                                           + "&type=" + type);break;

                 case "Courses":http.send("devid=" + devId + "&appid=" + appId
                                          + "&userid=" + userid
                                          + "&name=" + pull.rows.item(0).name
                                          + "&subject=" + pull.rows.item(0).subject
                                          + "&about=" + pull.rows.item(0).about
                                          + "&code=" + pull.rows.item(0).creationdate
                                          + "&language=" + pull.rows.item(0).language
                                          + "&schoolCode="+schoolCode
                                          + "&educatorCode="+userCode
                                          + "&type=" + type);break;

                 case "Units":http.send("devid=" + devId + "&appid=" + appId
                                          + "&userid=" + userid
                                          + "&name=" + pull.rows.item(0).name
                                          + "&about=" + pull.rows.item(0).about
                                          + "&objective=" + pull.rows.item(0).objective
                                          + "&code=" + pull.rows.item(0).creationdate
                                          + "&course=" + pull.rows.item(0).coursenumber
                                          + "&schoolCode="+schoolCode
                                          + "&educatorCode="+userCode
                                          + "&type=" + type);break;

                 case "Lessons":http.send("devid=" + devId + "&appid=" + appId
                                          + "&userid=" + userid
                                          + "&course="+pull.rows.item(0).coursenumber
                                          + "&unit="+pull.rows.item(0).unitnumber
                                          + "&name=" + pull.rows.item(0).name
                                          + "&lessonNum="+pull.rows.item(0).lessonNum
                                          + "&duration="+pull.rows.item(0).duration
                                          + "&about=" + pull.rows.item(0).about
                                          + "&objective=" + pull.rows.item(0).objective
                                          + "&supplies=" + pull.rows.item(0).supplies
                                          + "&resources=" + pull.rows.item(0).resources
                                          + "&guidingQuestions=" + pull.rows.item(0).guidingQuestions
                                          + "&lessonSequence=" + pull.rows.item(0).lessonSequence
                                          + "&studentProduct=" + pull.rows.item(0).studentProduct
                                          + "&reviewQuestions=" + pull.rows.item(0).reviewQuestions
                                          + "&code=" + pull.rows.item(0).creationdate
                                          + "&schoolCode="+schoolCode
                                          + "&educatorCode="+userCode
                                          + "&type=" + type);break;


                }


            }
        })
}

function retrieveFromOpenSeed(id, code, type) {

    /* retrieves data to Server */

    var http = new XMLHttpRequest()
    var url = "https://openseed.vagueentertainment.com:8675/devs/Vag-01001011/vagEdu-053018/scripts/retrieve.php"
    var pull = ""

    console.log("Sending "+type+" request to server "+id)
        http.onreadystatechange = function () {

            if (http.status === 200) {
                if (http.readyState === 4) {

                    if (http.responseText == "100") {
                        console.log("Incorrect DevID")
                    } else if (http.responseText == "101") {
                        console.log("Incorrect AppID")
                    } else {

                        //console.log("From Retrive "+http.responseText.trim())

                        if (http.responseText.length > 3) {


                            var info = http.responseText.split(";&;")



                            db.transaction(function (tx) {

                                tx.executeSql(
                                            'CREATE TABLE IF NOT EXISTS Schools (id TEXT, type INT,name TEXT,email TEXT,phone TEXT,country TEXT,state TEXT,about MEDIUMTEXT, code TEXT)')

                                tx.executeSql('CREATE TABLE IF NOT EXISTS Users (id TEXT, type INT,firstname TEXT,lastname TEXT,email TEXT,phone TEXT,country TEXT,state TEXT,about MEDIUMTEXT, code TEXT)')

                                if(type === "School") {
                                pull = tx.executeSql("SELECT * FROM Schools WHERE code='" + id + "'")

                                } else {
                                    pull = tx.executeSql("SELECT * FROM Users WHERE id='" + id + "'")
                                }

                                if (pull.rows.length === 0) {
                                        if(type === "School") {
                                            schoolName = info[1]
                                    tx.executeSql(
                                                "INSERT INTO Schools VALUES (?,?,?,?,?,?,?,?,?)",
                                                [userid, 1,
                                                 info[1],
                                                info[2],
                                                 info[3],
                                                 info[4],
                                                 info[5],
                                                 info[6],
                                                 info[0]])
                                } else {
                                            userName = info[2]+" "+info[3]
                                    tx.executeSql(
                                                "INSERT INTO Users VALUES (?,?,?,?,?,?,?,?,?,?)",
                                                [userid, 1,
                                                 info[2],
                                                 info[3],
                                                 info[4],
                                                 info[5],
                                                 info[6],
                                                 info[7],
                                                 info[8],
                                                 info[0]])

                                    if(schoolSetup.state == "Active") {
                                        isEducator.checked = 1
                                        view.currentIndex = 1
                                    }
                                }
                              }
                            })

                        } else {
                            schoolName = qsTr("No school found")
                        }
                    }
                }
            }
        }
        http.open('POST', url.trim(), true)

        http.setRequestHeader("Content-type",
                              "application/x-www-form-urlencoded")
        http.send("devid=" + devId + "&appid=" + appId + "&userid="+userid+"&code=" + id + "&type=" + type)

}
