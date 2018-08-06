function loadStudents(schoolcode) {
    //console.log("Loading Students")
    var num = 0
    studentList.clear()
    db.readTransaction(function (tx) {

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

    db.readTransaction(function (tx) {

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

function assignment_list() {

    var num = 0

        turnedin.clear()
    db.readTransaction(function(tx) {

        var dataSTR = "SELECT * FROM Student_Assignments WHERE schoolCode ='" + schoolCode + "' AND status= 3"

        var pull = tx.executeSql(dataSTR)

        console.log("from Assignment List "+schoolCode, pull.rows.length)

        while (pull.rows.length > num) {

            var cdat = new Date(pull.rows.item(num).creationdate)
            var edat = new Date(pull.rows.item(num).editdate)


            turnedin.append({
                                   lessonid:pull.rows.item(num).lessonID,
                                   name: Courses.pullField("Title","lesson",pull.rows.item(num).lessonID),
                                   thecolor: selectedHighlightColor,
                                   studentName: Scripts.studentCred(pull.rows.item(num).studentCode,'',"fullname"),
                                   studentID: pull.rows.item(num).studentCode,
                                   cdate: cdat.toLocaleString(),
                                   edate: edat.toLocaleString()
                               })

            num = num + 1
        }


    })

}
