function loadStudents(schoolcode) {
    //console.log("Loading Students")
    var num = 0
    studentList.clear()
    db.transaction(function (tx) {

        var dataSTR = "SELECT * FROM Students WHERE schoolcode ='" + schoolcode + "'"

        var pull = tx.executeSql(dataSTR)

        while (pull.rows.length > num) {

            studentList.append({
                                   name: pull.rows.item(
                                             num).firstname + " " + pull.rows.item(
                                             num).lastname,
                                   cdate: pull.rows.item(num).code,
                                   edate: pull.rows.item(num).editdate
                               })

            num = num + 1
        }
    })
}

function loadStudent(code) {
    var num = 0

    db.transaction(function (tx) {

        var dataSTR = "SELECT * FROM Students WHERE code ='" + code + "'"

        var pull = tx.executeSql(dataSTR)

        if (pull.rows.length === 1) {
            //var d = new Date(pull.rows.item(0).bday)
            studentname = pull.rows.item(0).firstname + " " + pull.rows.item(
                        0).lastname
            studentBday = pull.rows.item(0).bday
            studentage = pull.rows.item(0).age
            studentAbout = pull.rows.item(0).about
        }
    })
}

function saveStudent(userid, firstName, lastName, age, bday, about, schoolID, contactNumber, emailAddress, steemPostToken) {


    /*saves Student */
    var d = new Date()

    db.transaction(function (tx) {
        var data = [userid, firstName, lastName, age, bday, about, schoolID, contactNumber, emailAddress, steemPostToken, d.getTime(
                        ), d.getTime()]
        var dtable = "INSERT INTO Students VALUES(?,?,?,?,?,?,?,?,?,?,?,?)"

        var dataSTR = "SELECT * FROM Students WHERE firstname ='" + firstName
                + "' AND lastname ='" + lastName + "'"

        var pull = tx.executeSql(dataSTR)
        if (pull.rows.length < 1) {
            tx.executeSql(dtable, data)
        }
    })
}
