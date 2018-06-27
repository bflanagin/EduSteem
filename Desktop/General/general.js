function saveSteem(userid, type, steemAccount, steemKey) {


    var pull = ""

    var data = [userid,type,steemAccount,steemKey,""]
    var dtable = "INSERT INTO Steem VALUES(?,?,?,?,?)"



    db.transaction(function (tx) {
        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Steem (id TEXT, type INT,data1 TEXT,data2 TEXT,data3 TEXT)')

        pull = tx.executeSql("SELECT * FROM Steem WHERE id='" + userid + "'")

        if (pull.rows.length !== 1) {

            tx.executeSql(dtable, data)
        } else {
            tx.executeSql("UPDATE Steem SET data1='"+steemAccount+"', data2='"+steemKey+"' WHERE id='"+userid+"'")
        }
    })
}

function loadschool(userid) {

    var pull = ""
    var exists = false
    db.transaction(function (tx) {

        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Schools (id TEXT, type INT,name TEXT,email TEXT,phone TEXT,country TEXT,state TEXT,about MEDIUMTEXT, code TEXT,editdate MEDIUMINT)')

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
        } else {


            //if(pull.rows.item(0).code === null || pull.rows.item(0).code.length < 2) {
            //   tx.executeSql("UPDATE Schools SET code='"+schoolCode+"' WHERE id='"+userid+"'")
            //    oneTime(userid,1,"school")
            // }

            // schoolName = pull.rows.item(0).name
            //  schoolCode = pull.rows.item(0).code
        }
    })
}

function loaduser(userid) {

    var pull = ""
    var pull1 = ""
    var exists = false
    db.transaction(function (tx) {

        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Users (id TEXT, type INT,firstname TEXT,lastname TEXT,email TEXT,phone TEXT,country TEXT,state TEXT,about MEDIUMTEXT, code TEXT,editdate MEDIUMINT)')

        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Steem (id TEXT, type INT,data1 TEXT,data2 TEXT,data3 TEXT)')

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


        if(pull1.rows.length === 1) {

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

        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Users (id TEXT, type INT,firstname TEXT,lastname TEXT,email TEXT,phone TEXT,country TEXT,state TEXT,about MEDIUMTEXT, code TEXT,editdate MEDIUMINT)')
        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Steem (id TEXT, type INT,data1 TEXT,data2 TEXT,data3 TEXT)')

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

        if(pull1.rows.length === 1) {

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

                        tx.executeSql(
                                    'CREATE TABLE IF NOT EXISTS Schools (id TEXT, type INT,name TEXT,email TEXT,phone TEXT,country TEXT,state TEXT,about MEDIUMTEXT, code TEXT,editdate MEDIUMINT)')

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

                        tx.executeSql(
                                    'CREATE TABLE IF NOT EXISTS Users (id TEXT, type INT,name TEXT,email TEXT,phone TEXT,country TEXT,state TEXT,about MEDIUMTEXT, code TEXT,editdate MEDIUMINT)')

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
