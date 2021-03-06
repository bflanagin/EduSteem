function createddbs() {

    db.transaction(function (tx) {

        /* convenience databases */
        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Subjects (schoolCode TEXT,subjectNumber INT ,subjectName TEXT,subjectColor TEXT,subjectBg TEXT,creationdate MEDIUMINT)')

        /* user databases */
        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Users (id TEXT, type INT,firstname TEXT,lastname TEXT,email TEXT,phone TEXT,country TEXT,state TEXT,about MEDIUMTEXT, code TEXT,editdate MEDIUMINT)')

        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Steem (id TEXT, type INT,data1 TEXT,data2 TEXT,data3 TEXT)')

        /* school databases */
        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Schools (id TEXT, type INT,name TEXT,email TEXT,phone TEXT,country TEXT,state TEXT,about MEDIUMTEXT, code TEXT,editdate MEDIUMINT)')

        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Lessons (id TEXT, educatorID TEXT,published INT, coursenumber MEDIUMINT,unitnumber MEDIUMINT, name TEXT, lessonNum INT, duration INT, about MEDIUMTEXT, objective MEDIUMTEXT, supplies MEDIUMTEXT, resources MEDIUMTEXT, \
guidingQuestions MEDIUMTEXT, lessonSequence MEDIUMTEXT, studentProduct MEDIUMTEXT, reviewQuestions MEDIUMTEXT,creationdate MEDIUMINT,editdate MEDIUMINT)')

        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Units (id TEXT, coursenumber MEDIUMINT,unitNum INT, name TEXT, objective MEDIUMTEXT, about MEDIUMTEXT, creationdate MEDIUMINT,editdate MEDIUMINT)')

        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Courses (id TEXT, name TEXT, subject TEXT,language TEXT, about MEDIUMTEXT, creationdate MEDIUMINT,editdate MEDIUMINT)')
        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Schedule (id TEXT, month INT, day MEDIUMTEXT, schoolcode TEXT, educatorcode TEXT,creationdate MEDIUMINT,editdate MEDIUMINT)')

        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Lesson_Control(id TEXT, coursenumber MEDIUMINT, unitnumber MEDIUMINT, lessonID MEDIUMINT,status INT,educatorcode TEXT,creationdate MEDIUMINT,editdate MEDIUMINT)')

        /* Student centric databases */
        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Students (id TEXT, firstname TEXT,lastname TEXT, age INT, bday MEDIUMINT, about MEDIUMTEXT, schoolcode TEXT,phone TEXT,email TEXT,steempost TEXT,code MEDIUMINT,editdate MEDIUMINT)')
        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Student_Assignments (schoolCode TEXT, studentCode MEDIUMINT, lessonID MEDIUMINT, status INT, qaList MEDIUMTEXT, creationdate MEDIUMINT, editdate MEDIUMINT)')
        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Assignment_Notes (schoolCode TEXT, studentCode MEDIUMINT, lessonID MEDIUMINT,teacherCode TEXT,response MEDIUMINT, note MEDIUMTEXT, creationdate MEDIUMINT, editdate MEDIUMINT)')
        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Student_Daily_Review (schoolCode TEXT,studentCode MEDIUMINT,qaList MEDIUMTEXT, date MEDIUMINT )')

        /* Media databases */
        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Media (schoolCode TEXT,owner TEXT,type TEXT,filename TEXT,hash TEXT,creationdate MEDIUMINT)')
    })
}

function saveSteem(userid, type, steemAccount, steemKey) {

    var pull = ""

    var data = [userid, type, steemAccount, steemKey, ""]
    var dtable = "INSERT INTO Steem VALUES(?,?,?,?,?)"

    db.transaction(function (tx) {

        pull = tx.executeSql("SELECT * FROM Steem WHERE id=?",[userid])

        if (pull.rows.length !== 1) {

            tx.executeSql(dtable, data)
        } else {
            tx.executeSql(
                        "UPDATE Steem SET data1=?, data2=? WHERE id=?",[steemAccount,steemKey,userid])
        }
    })
}

function loadschool(userid) {

    var pull = ""
    var exists = false
    db.readTransaction(function (tx) {

        /*pulling general school information*/
        if (userid !== "") {
            pull = tx.executeSql(
                        "SELECT * FROM Schools WHERE id= ?",[userid])
        } else {
            pull = tx.executeSql("SELECT * FROM Schools WHERE 1")
        }

        if (pull.rows.length === 1) {

            if (pull.rows.item(0).code === null || pull.rows.item(
                        0).code.length < 2) {
                tx.executeSql("UPDATE Schools SET code= ? WHERE id= ?",[schoolCode,userid])
                oneTime(userid, 1, "school")
            }

            schoolName = pull.rows.item(0).name
            schoolCode = pull.rows.item(0).code
            schoolEditDate = pull.rows.item(0).editdate
            userID = pull.rows.item(0).id

            /* done with general info */

            /* Student Check */
            var studentCheck = tx.executeSql("SELECT id FROM Students WHERE 1")

            if (studentCheck.rows.length > 0) {
                numberOfStudents = studentCheck.rows.length
            } else {
                numberOfStudents = 0
            }
        } else {
            login.state = "Active"
        }
    })

    if (schoolCode !== "") {
        db.transaction(function (tx) {

            var generic = ["8 - P.E.:DarkGreen",
                           "101 - Math:Orange",
                           "201 - Science:Green",
                           "301 - Humanities:LightBlue",
                           "302 - Literature:Brown",
                           "303 - Writing:Black",
                           "304 - Grammar:Red",
                           "305 - Spelling:Brown",
                           "401 - Art",
                           "501 - Music",
                           "601 - Vocational:Pink",
                           "701 - Social Sciences",
                           "801 - Languages Studies",
                           "901 - Projects"]
            var num = 0
            while (num < generic.length) {

                var checkSTR = "SELECT * FROM Subjects WHERE schoolCode= ? AND subjectNumber=?"
                var tocheck = [schoolCode,generic[num].split(" - ")[0]]

                var check = tx.executeSql(checkSTR,tocheck)

                if (check.rows.length === 0) {
                    var dataSTR = "INSERT INTO Subjects VALUES(?,?,?,?,?,?)"
                    var number = generic[num].split(" - ")[0]
                    var name = generic[num].split(" - ")[1].split(":")[0]
                    var color = generic[num].split(" - ")[1].split(":")[1]
                    var data = [schoolCode, number, name, color, " ", d.getTime(
                                    )]

                    tx.executeSql(dataSTR, data)
                }

                num = num + 1
            }
        })
    }
}

function loaduser(userid) {

    var pull = ""
    var pull1 = ""
    var exists = false
    db.readTransaction(function (tx) {

        pull = tx.executeSql("SELECT * FROM Users WHERE id= ?",[userid])

        if (pull.rows.length === 1) {

            if (pull.rows.item(0).code === null || pull.rows.item(
                        0).code.length < 2) {
                tx.executeSql("UPDATE Users SET code= ? WHERE id= ?",[oneTime(userid, 1),userid])
                oneTime(userid, 1, "user")
            }

            userName = pull.rows.item(0).firstname + " " + pull.rows.item(
                        0).lastname
            userCode = pull.rows.item(0).code
            userEditDate = pull.rows.item(0).editdate
        }

        pull1 = tx.executeSql("SELECT * FROM Steem WHERE id= ?",[userCode])

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
    db.readTransaction(function (tx) {

        pull = tx.executeSql("SELECT * FROM Users WHERE code= ?",[userid])
        pull1 = tx.executeSql("SELECT * FROM Steem WHERE id= ?",[userid])
        if (pull.rows.length === 1) {

            userFirstName = pull.rows.item(0).firstname
            userLastName = pull.rows.item(0).lastname
            userAbout = pull.rows.item(0).about
            userEmail = pull.rows.item(0).email
            userPhone = pull.rows.item(0).phone
            userCountry = pull.rows.item(0).country
            userState = pull.rows.item(0).state
            userEditDate = pull.rows.item(0).editdate
            userCode = pull.rows.item(0).code
        }

        if (pull1.rows.length === 1) {

            steemAccount = pull1.rows.item(0).data1
            steemShareKey = pull1.rows.item(0).data2
        }
    })
}



function studentCred(info1, info2, type) {

    /* Function returns student information based on type */
    var returned = 0
    var pull = ""

    db.readTransaction(function (tx) {
        if (type === "name") {
            pull = tx.executeSql("SELECT * FROM Students WHERE lastname=? AND firstname=?",[info2,info1])
        } else {
            pull = tx.executeSql("SELECT * FROM Students WHERE code LIKE ?",['%'+info1])
        }

        if (pull.rows.length === 1) {
            if (type === "name") {
                studentCode = pull.rows.item(0).code
                returned = 1
            } else {
                switch (type) {
                case "firstname":
                    returned = pull.rows.item(0).firstname
                    break
                case "lastname":
                    returned = pull.rows.item(0).lastname
                    break
                case "age":
                    returned = pull.rows.item(0).age
                    break
                case "bday":
                    returned = pull.rows.item(0).bday
                    break
                case "about":
                    returned = pull.rows.item(0).about
                    break
                case "fullname":
                    returned = pull.rows.item(
                                0).firstname + " " + pull.rows.item(0).lastname
                    break
                case "code":
                    returned = 1
                    break
                }
            }
        }
    })

    return returned
}

function load_Subjects() {

    subjects.clear()
    db.readTransaction(function (tx) {

        var pull = tx.executeSql("SELECT * FROM Subjects WHERE schoolCode=? ORDER BY subjectNumber ASC",[schoolCode])
        var num = 0
        while(pull.rows.length > num) {

            subjects.append({
                            classColor:  pull.rows.item(num).subjectColor,
                            name: pull.rows.item(num).subjectName,
                            classNum:pull.rows.item(num).subjectNumber,
                            value:pull.rows.item(num).subjectNumber
                            })

            num = num + 1
        }

    })


}

function add_Subject(name,number,color) {
    var d = new Date()
    db.transaction(function (tx) {

        var pull = tx.executeSql("SELECT * FROM Subjects WHERE schoolCode= ? AND subjectNumber = ?",[schoolCode,number])
        var num = 0
        if(pull.rows.length === 0) {
             var dataSTR = "INSERT INTO Subjects VALUES(?,?,?,?,?,?)"
            var data = [schoolCode, number, name, color, " ", d.getTime()]

            tx.executeSql(dataSTR, data)
        }

    })

}

function load_Educators() {

    educators.clear()

    db.readTransaction(function (tx) {

        var pull = tx.executeSql("SELECT * FROM Users WHERE 1 ORDER BY id ASC")
        var num = 0
        while(pull.rows.length > num) {

            educators.append({
                            firstname:  pull.rows.item(num).firstname,
                            lastname: pull.rows.item(num).lastname,
                            code:pull.rows.item(num).code
                            })

            num = num + 1
        }

    })
}
