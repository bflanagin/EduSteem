
function loadUser(userid) {

    var pull = ""
    db.readTransaction(function (tx) {

        if (userid !== "") {
        pull = tx.executeSql("SELECT * FROM Users WHERE id='" + userid + "'")
        } else {
             pull = tx.executeSql("SELECT * FROM Users WHERE 1")
        }

        if (pull.rows.length === 1) {

            if (pull.rows.item(0).code === null || pull.rows.item(
                        0).code.length < 2) {

                Network.checkESAccount(id)
            }
            userID = pull.rows.item(0).id
            userName = pull.rows.item(0).firstname + " " + pull.rows.item(
                        0).lastname
            userCode = pull.rows.item(0).code
            userEditDate = parseInt(pull.rows.item(0).editdate)
            login.state = "inActive"
        } else {
            login.state = "Active"
        }

    })
}

function loadStudents(schoolCode,sort) {
    //console.log("Loading Students")
    var pull = ""
    students.clear()
    db.readTransaction(function (tx) {

        switch(sort) {
        case 0: pull = tx.executeSql("SELECT * FROM Students WHERE schoolCode='" + schoolCode + "' ORDER BY firstname ASC")
            break
        case 1:pull = tx.executeSql("SELECT * FROM Students WHERE schoolCode='" + schoolCode + "' ORDER BY lastname ASC")
            break
        case 3:pull = tx.executeSql("SELECT * FROM Students WHERE schoolCode='" + schoolCode + "' ORDER BY age ASC")
            break
        default:pull = tx.executeSql("SELECT * FROM Students WHERE schoolCode='" + schoolCode + "' ORDER BY firstname ASC")
            break
        }
        var num = 0
        sorting = sort
        while(pull.rows.length > num) {
            var first = pull.rows.item(num).firstname
            var last = pull.rows.item(num).lastname
            students.append({
                            name: first+" "+last,
                            id: pull.rows.item(num).code
                            })
            num = num + 1
        }

    })

}


function loadStudent(id) {

    var pull = ""
    db.readTransaction(function (tx) {

        pull = tx.executeSql("SELECT * FROM Students WHERE code=" + id)


        if (pull.rows.length === 1) {

            name = pull.rows.item(0).firstname+" "+pull.rows.item(0).lastname
            age = pull.rows.item(0).age
            bday = pull.rows.item(0).bday
            about = pull.rows.item(0).about
            phone = pull.rows.item(0).phone
            email = pull.rows.item(0).email
       }

    })
}



function loadschool(userid) {

    console.log("Loading School")
    var pull = ""
    var exists = false
    db.readTransaction(function (tx) {

        /*pulling general school information*/
        if (userid !== "") {
            pull = tx.executeSql(
                        "SELECT * FROM Schools WHERE id='" + userid + "'")
                console.log("With User Account "+pull.rows.length)
        } else {
            pull = tx.executeSql("SELECT * FROM Schools WHERE 1")
            console.log("Without User "+pull.rows.length)
        }

        if (pull.rows.length > 0) {

            if (pull.rows.item(0).code === null || pull.rows.item(
                        0).code.length < 2) {
                tx.executeSql("UPDATE Schools SET code='" + schoolCode
                              + "' WHERE id='" + userid + "'")
                Network.oneTime(userid, 1, "school")
            }

            schoolName = pull.rows.item(0).name
            schoolCode = pull.rows.item(0).code
            schoolEditDate = pull.rows.item(0).editdate

            /* done with general info */

            /* Student Check */
            var studentCheck = tx.executeSql("SELECT id FROM Students WHERE 1")

            if (studentCheck.rows.length > 0) {
                numberOfStudents = studentCheck.rows.length
            } else {
                numberOfStudents = 0
            }
        } else {
            console.log("No Schools found")
        }
    })

}


function checklocal(type) {


    /* checking various local databases and returning whether we should run wizards or grab info from the network */
    var pull = ""
    var exists = false
    db.transaction(function (tx) {

        switch (type) {
        case "user":
            pull = tx.executeSql(
                        "SELECT id,type FROM Users WHERE id='" + userID + "'")
            if (pull.rows.length === 1) {
                atype = pull.rows.item(0).type
                exists = true
            }
            break
        case "school":
            pull = tx.executeSql(
                        "SELECT id,type FROM Schools WHERE id='" + userID + "'")
            if (pull.rows.length === 1) {
                etype = pull.rows.item(0).type
                exists = true
            }
            break
        case "children":
            break
        }
    })

    return exists
}

function deselectAll() {
    //overView.state = "inActive"
    studentList.visible = false
    scheduleView.visible = false
    lessonView.visible = false
    supplyView.visible = false
    dashBoard.visible = false

}



