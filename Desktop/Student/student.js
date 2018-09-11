function loadDay(month, day, weekday, studentCode) {
    todaysClasses.clear()
    db.readTransaction(function (tx) {

        var num = 0
        var dataSTR = "SELECT day FROM Schedule WHERE schoolcode ='"
                + schoolCode + "' AND month =" + month
        var pull = tx.executeSql(dataSTR)

        while (pull.rows.length > num) {

            if (pull.rows.item(num).day.split(":")[0] === day) {
                todaysClasses.append({
                                         name: pull.rows.item(
                                                   num).day.split(":")[1]
                                     })
                break
            } else {
                var classes = pull.rows.item(num).day.split(";")
                var week = (weekday % 7) + 1

                for (var classnum = 0; classnum < (classes.length - 1); classnum = classnum + 1) {
                    if (selected_month === month || educator === "login") {

                        if (classes[classnum].split(":")[1].split(
                                    ",")[week] === "true") {

                            var subject = Courses.pullField(
                                        "Subject","course",
                                        classes[classnum].split(
                                            ":")[1].split(",")[0])

                            var color = "gray"

                            if (subject !== "") {

                                var getSubjectInfo = "SELECT * FROM Subjects WHERE schoolCode=? AND subjectNumber= ?"
                                var str = [schoolCode,subject]
                                var info = tx.executeSql(getSubjectInfo,str)

                                if(info.rows.length === 1) {
                                    if(info.rows.item(0).subjectColor !== null ) {
                                    color = info.rows.item(0).subjectColor
                                    }
                                }

                            }

                            todaysClasses.append({
                                                     classtitle: Courses.pullField(
                                                                     "Title",
                                                                     "course",
                                                                     classes[classnum].split(
                                                                         ":")[1].split(
                                                                         ",")[0]),
                                                     classColor: color,
                                                     unitName: Courses.pullField(
                                                                   "Title",
                                                                   "unit",
                                                                   classes[classnum].split(
                                                                       ":")[1].split(
                                                                       ",")[0]),
                                                     lessonName: "",
                                                     discription: Courses.pullField(
                                                                      "Title",
                                                                      "course",
                                                                      classes[classnum].split(
                                                                          ":")[1].split(
                                                                          ",")[0])
                                                 })
                        }
                    }
                }
            }

            num = num + 1
        }
    })
}

function loadTask(studentCode, taskId) {

    db.readTransaction(function (tx) {

        var dataSTR = "SELECT * FROM Lessons WHERE creationdate =?"
        var pull = tx.executeSql(dataSTR,taskId)

        if (pull.rows.length === 1) {

            var d = new Date(pull.rows.item(0).creationdate)
            lessonAuthor = pull.rows.item(0).educatorID
            lessonPublished = pull.rows.item(0).published
            lessonName = pull.rows.item(0).name.replace(/_/g, " ")
            lessonAbout = pull.rows.item(0).about
            lessonObjective = pull.rows.item(0).objective

            lessonResources = pull.rows.item(0).resources
            lessonDuration = pull.rows.item(0).duration

            lessonDate = d.toLocaleDateString()

            lessonSP = Scrubber.recoverSpecial(pull.rows.item(0).studentProduct)
        }

        var studentSTR = "SELECT * FROM Student_Assignments WHERE lessonID=? AND studentCode= ?"
        var strStudent = [taskId,studentCode]

        var studentpull = tx.executeSql(studentSTR,strStudent)

        if(studentpull.rows.length === 1) {

            studentAnswers = studentpull.rows.item(0).qaList
        }

    })

}

function updateTask(studentCode, taskId, state, qa) {

    var d = new Date()

   /*
    These are the valid modes for the status

    0: Not started.
    1: Started.
    2: Working on.
    3: Turned in.
    4: Revise.
    5: Accepted.
    6: Published.

    */

    db.transaction(function (tx) {

        var dataSTR = "SELECT * FROM Student_Assignments WHERE lessonID = ? AND studentCode= ? "
        var str = [taskId,studentCode]
        var pull = tx.executeSql(dataSTR,str)
        var table = ""
        var data = []

        if(pull.rows.length === 0) {
            table = "INSERT INTO Student_Assignments VALUES(?,?,?,?,?,?,?)"
            data = [schoolCode,studentCode,taskId,state,qa,d.getTime(),d.getTime()]
            tx.executeSql(table,data)

        } else {
            if(qa === "") {
                table = "UPDATE Student_Assignments SET status=?, editdate=? WHERE studentCode=? AND lessonID=? "
                data = [state,d.getTime(),studentCode,taskId]
            } else {
               table = "UPDATE Student_Assignments SET status=?, qalist=?, editdate=? WHERE studentCode=? AND lessonID=? "
                data = [state,qa,d.getTime(),studentCode,taskId]
            }

           tx.executeSql(table,data)

        }


    })

}


/* this will be used for Steem / updates */
function publishTask(studentCode, taskId) {}

function loadStudentProfile(studentCode) {

    var dataSTR = "SELECT * FROM Students WHERE code = ?"

     db.readTransaction(function(tx) {
            var studentinfo = tx.executeSql(dataSTR,studentCode)
         if(studentinfo.rows.length === 1) {
            console.log(studentinfo.rows.item(0).firstname)
            studentFirstName = studentinfo.rows.item(0).firstname
            studentLastName = studentinfo.rows.item(0).lastname

         }

     })

}

function updateStudentProfile(studentCode) {}

function addNote(schoolCode,studentID,lessonID,userCode,response,note) {

    var d = new Date()

    db.transaction(function (tx) {

        var dataSTR = "SELECT * FROM Assignment_Notes WHERE lessonID = ? AND studentCode=? AND schoolCode=?"
        var str = [lessonID,studentID,schoolCode]
        var pull = tx.executeSql(dataSTR)
        var table = ""
        var data = []

            table = "INSERT INTO Assignment_Notes VALUES(?,?,?,?,?,?,?,?)"
            data = [schoolCode,studentID,lessonID,userCode,response,note,d.getTime(),d.getTime()]
            tx.executeSql(table,data)

    })
}

function listNotes(schoolCode,studentID,lessonID) {
    noteList.clear()

    db.readTransaction(function (tx) {

        var dataSTR = "SELECT * FROM Assignment_Notes WHERE lessonID =? AND studentCode=? AND schoolCode=?"
        var str = [lessonID,studentID,schoolCode]
        var pull = tx.executeSql(dataSTR,str)


        var num = 0

        while(pull.rows.length >= num) {
            var name = Courses.pullField("FullName","educator",pull.rows.item(num).teacherCode)
            var d = new Date(pull.rows.item(num).creationdate)
            noteList.append({
                              from:name,
                              date:d.toLocaleDateString(),
                              note:pull.rows.item(num).note,
                              status:1
                            })

            num = num + 1
        }

    })

}

function loadTasks(status) {

     db.readTransaction(function (tx) {
    var num = 0
    var dataSTR = "SELECT * FROM Student_Assignments WHERE studentCode= ? AND status= ?"
    var str = [studentCode,status]
    var pull = tx.executeSql(dataSTR,str)
    var table = ""
    var data = []

    completedAssignments.clear()



    while(pull.rows.length > num) {

        console.log("from loadTasks "+pull.rows.item(num).lessonID)
        completedAssignments.append({

                                    num:num
                                    })

        num = num + 1
    }

    })

}
