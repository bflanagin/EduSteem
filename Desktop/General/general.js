function createddbs() {

     db.transaction(function (tx) {
    tx.executeSql(
                'CREATE TABLE IF NOT EXISTS Steem (id TEXT, type INT,data1 TEXT,data2 TEXT,data3 TEXT)')
    tx.executeSql(
                'CREATE TABLE IF NOT EXISTS Schools (id TEXT, type INT,name TEXT,email TEXT,phone TEXT,country TEXT,state TEXT,about MEDIUMTEXT, code TEXT,editdate MEDIUMINT)')
    tx.executeSql(
                'CREATE TABLE IF NOT EXISTS Users (id TEXT, type INT,firstname TEXT,lastname TEXT,email TEXT,phone TEXT,country TEXT,state TEXT,about MEDIUMTEXT, code TEXT,editdate MEDIUMINT)')

         tx.executeSql(
                     'CREATE TABLE IF NOT EXISTS Lessons (id TEXT, educatorID TEXT,published INT, coursenumber MEDIUMINT,unitnumber MEDIUMINT, name TEXT, lessonNum INT, duration INT, about MEDIUMTEXT, objective MEDIUMTEXT, supplies MEDIUMTEXT, resources MEDIUMTEXT, \
 guidingQuestions MEDIUMTEXT, lessonSequence MEDIUMTEXT, studentProduct MEDIUMTEXT, reviewQuestions MEDIUMTEXT,creationdate MEDIUMINT,editdate MEDIUMINT)')

         tx.executeSql(
                     'CREATE TABLE IF NOT EXISTS Units (id TEXT, coursenumber MEDIUMINT, name TEXT, objective MEDIUMTEXT, about MEDIUMTEXT, creationdate MEDIUMINT,editdate MEDIUMINT)')

         tx.executeSql(
                     'CREATE TABLE IF NOT EXISTS Courses (id TEXT, name TEXT, subject TEXT,language TEXT, about MEDIUMTEXT, creationdate MEDIUMINT,editdate MEDIUMINT)')
         tx.executeSql(
                     'CREATE TABLE IF NOT EXISTS Schedule (id TEXT, month INT, day MEDIUMTEXT, schoolcode TEXT, educatorcode TEXT,creationdate MEDIUMINT,editdate MEDIUMINT)')

         tx.executeSql(
                     'CREATE TABLE IF NOT EXISTS Students (id TEXT, firstname TEXT,lastname TEXT, age INT, bday MEDIUMINT, about MEDIUMTEXT, schoolcode TEXT,phone TEXT,email TEXT,steempost TEXT,code MEDIUMINT,editdate MEDIUMINT)')

    })

}



function saveSteem(userid, type, steemAccount, steemKey) {

    var pull = ""

    var data = [userid, type, steemAccount, steemKey, ""]
    var dtable = "INSERT INTO Steem VALUES(?,?,?,?,?)"

    db.transaction(function (tx) {

        pull = tx.executeSql("SELECT * FROM Steem WHERE id='" + userid + "'")

        if (pull.rows.length !== 1) {

            tx.executeSql(dtable, data)
        } else {
            tx.executeSql(
                        "UPDATE Steem SET data1='" + steemAccount + "', data2='"
                        + steemKey + "' WHERE id='" + userid + "'")
        }
    })
}

function loadschool(userid) {

    var pull = ""
    var exists = false
    db.transaction(function (tx) {

        /*pulling general school information*/

        if (userid !== "") {
            pull = tx.executeSql(
                        "SELECT * FROM Schools WHERE id='" + userid + "'")
        } else {
            pull = tx.executeSql("SELECT * FROM Schools WHERE 1")
        }

        if (pull.rows.length === 1) {

            if (pull.rows.item(0).code === null || pull.rows.item(
                        0).code.length < 2) {
                tx.executeSql("UPDATE Schools SET code='" + schoolCode
                              + "' WHERE id='" + userid + "'")
                oneTime(userid, 1, "school")
            }

            schoolName = pull.rows.item(0).name
            schoolCode = pull.rows.item(0).code
            schoolEditDate = pull.rows.item(0).editdate

         /* done with general info */

            /* Student Check */

            var studentCheck = tx.executeSql("SELECT id FROM Students WHERE 1")

                if(studentCheck.rows.length > 0) {
                    numberOfStudents = studentCheck.rows.length
                }



        } else {

        }
    })
}

function loaduser(userid) {

    var pull = ""
    var pull1 = ""
    var exists = false
    db.transaction(function (tx) {


        pull = tx.executeSql("SELECT * FROM Users WHERE id='" + userid + "'")

        if (pull.rows.length === 1) {

            if (pull.rows.item(0).code === null || pull.rows.item(
                        0).code.length < 2) {
                tx.executeSql("UPDATE Users SET code='" + oneTime(
                                  userid, 1) + "' WHERE id='" + userid + "'")
                oneTime(userid, 1, "user")
            }

            userName = pull.rows.item(0).firstname + " " + pull.rows.item(
                        0).lastname
            userCode = pull.rows.item(0).code
            userEditDate = pull.rows.item(0).editdate
        }

        pull1 = tx.executeSql("SELECT * FROM Steem WHERE id='" + userCode + "'")

        if (pull1.rows.length === 1) {

            steemAccount = pull1.rows.item(0).data1
            steemShareKey = pull1.rows.item(0).data2
        }
    })
}

function loadprofile(userid) {

    var pull = ""
    var pull1 = ""
    var exists = false
    db.transaction(function (tx) {



        pull = tx.executeSql("SELECT * FROM Users WHERE code='" + userid + "'")
        pull1 = tx.executeSql("SELECT * FROM Steem WHERE id='" + userid + "'")
        if (pull.rows.length === 1) {

            userFirstName = pull.rows.item(0).firstname
            userLastName = pull.rows.item(0).lastname
            userAbout = pull.rows.item(0).about
            userEmail = pull.rows.item(0).email
            userPhone = pull.rows.item(0).phone
            userCountry = pull.rows.item(0).country
            userState = pull.rows.item(0).state
            userEditDate = pull.rows.item(0).editdate
        }

        if (pull1.rows.length === 1) {

            steemAccount = pull1.rows.item(0).data1
            steemShareKey = pull1.rows.item(0).data2
        }
    })
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
        if (http.readyState == 4) {
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
                                    "SELECT * FROM Schools WHERE id='" + userid + "'")
                        if (pull.rows.length === 1) {

                            if (pull.rows.item(0).code === null
                                    || pull.rows.item(0).code.length < 2) {
                                tx.executeSql(
                                            "UPDATE Schools SET code='" + code
                                            + "', editdate=" + d.getTime(
                                                ) + " WHERE id='" + userid + "'")
                            }
                        }

                        schoolCode = code
                        schoolEditDate = d.getTime()
                    })
                } else {

                    db.transaction(function (tx) {

                        pull = tx.executeSql(
                                    "SELECT * FROM Users WHERE id='" + userid + "'")
                        if (pull.rows.length === 1) {

                            if (pull.rows.item(0).code === null
                                    || pull.rows.item(0).code.length < 2) {
                                tx.executeSql(
                                            "UPDATE Users SET code='" + code
                                            + "', editdate=" + d.getTime(
                                                ) + " WHERE id='" + userid + "'")
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


function studentCred(info1, info2, type) {
        var returned = 0
        var pull = ""


    db.transaction(function (tx) {
        if(type === "name") {
         pull = tx.executeSql("SELECT * FROM Students WHERE lastname='"+info2+"' AND firstname='"+info1+"'")
        } else {
          pull = tx.executeSql("SELECT * FROM Students WHERE code LIKE '%"+info1+"'")
        }

        if(pull.rows.length === 1) {
                returned = 1
        }
    });

return returned
}
