/* general OpenSeed authentication */
function oseed_auth(name, email, passphrase) {

    /*send the data to get authentication from the server. This is a simpler version of checkcreds and may be removed */
    var http = new XMLHttpRequest()

    var url = "https://openseed.vagueentertainment.com:8675/corescripts/authPOST.php"

    http.onreadystatechange = function () {
        if (http.readyState == 4) {

            if (http.responseText === 100) {
                console.log("Incorrect DevID")
            } else if (http.responseText === 101) {
                console.log("Incorrect AppID")
            } else {

                userid = http.responseText

                message = userid
            }
        }
    }
    http.open('POST', url.trim(), true)

    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
    http.send("devid=" + devId + "&appid=" + appId + "&username=" + name
              + "&email=" + email + "&passphrase=" + passphrase)
}

function heartbeat() {

    /* This is a simple heart beat function to verify that data can be sent to the server. This is needed for the asyncronious nature of the program */
    var http = new XMLHttpRequest()
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/heartbeat.php"

    http.onreadystatechange = function () {

        if (http.status === 200) {
            if (http.readyState === 4) {

                if (http.responseText === "100") {
                    console.log("Incorrect DevID")
                } else if (http.responseText === "101") {
                    console.log("Incorrect AppID")
                } else {

                    heart = http.responseText
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

function checkcreds(field, info) {

    /* User for quick checks to the server to verify new accounts and validate old ones. */
    var http = new XMLHttpRequest()

    var url = "https://openseed.vagueentertainment.com:8675/corescripts/authCHECK.php"

    http.onreadystatechange = function () {
        if (http.readyState == 4) {

            if (http.responseText === "100") {
                uniqueemail = 100
                console.log("Incorrect DevID")
            } else if (http.responseText === "101") {

                uniqueemail = 101
                console.log("Incorrect AppID")
            } else {

                if (field === "email") {
                    // console.log (http.responseText);
                    uniqueemail = http.responseText
                }
                if (field === "username") {
                    uniquename = http.responseText
                    //  console.log (http.responseText);
                }

                if (field === "account") {
                    uniqueaccount = http.responseText
                }

                if (field === "passphrase") {
                    uniqueid = http.responseText

                    if (uniqueid != '0') {
                        message = "Login granted"
                        userID = uniqueid
                    } else {
                        message = "Incorrect password"
                    }
                }
            }
        }
    }
    http.open('POST', url.trim(), true)
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
    http.send("devid=" + devId + "&appid=" + appId + "&type=" + field + "&info=" + info)
}

function account_type(userid) {

    /* Checks to see if the user id is an admin or a normal user good for programs that have multiple layers of account */
    var http = new XMLHttpRequest()
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/authCHECK.php"

    http.onreadystatechange = function () {
        if (http.readyState === XMLHttpRequest.DONE) {

            if (http.responseText === 100) {

                console.log("Incorrect DevID")
            } else if (http.responseText === 101) {

                console.log("Incorrect AppID")
            } else {

                if (http.responseText === "1") {
                    connection_type = "Admin"
                } else {
                    connection_type = "User"
                }
            }
        }
    }
    http.open('POST', url.trim(), true)

    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
    http.send("devid=" + devId + "&appid=" + appId + "&type=admin&info=" + userid)
}

/* End General functions */
function save_local(userid, type, firstname, lastname, email, phone, country, state, about, teachercode) {

    var d = new Date()

    db.transaction(function (tx) {
        var data = [userid, type, firstname, lastname, email, phone, country, state, about, teachercode, d.getTime(
                        )]
        var dtable = "INSERT INTO Users VALUES(?,?,?,?,?,?,?,?,?,?,?)"
        var update = "UPDATE Users SET type=" + type + ", firstname='"
                + firstname + "', lastname='" + lastname + "', email='" + email + "', phone='"
                + phone + "', country='" + country + "', state='" + state + "', about='"
                + about + "', editdate=" + d.getTime() + " WHERE id='" + userid + "'"

        var dataSTR = "SELECT * FROM Users WHERE id ='" + userid + "'"

        var pull = tx.executeSql(dataSTR)
        if (pull.rows.length !== 1) {
            tx.executeSql(dtable, data)
        } else {
            tx.executeSql(update)
        }
    })
}
