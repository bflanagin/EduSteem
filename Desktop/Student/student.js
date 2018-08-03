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

                            var subject = Schedule.pullField(
                                        "course", "Subject",
                                        classes[classnum].split(
                                            ":")[1].split(",")[0])

                            var color = "gray"

                            if (subject !== "") {

                                var getSubjectInfo = "SELECT * FROM Subjects WHERE schoolCode='"+schoolCode+"' AND subjectNumber="+subject

                                var info = tx.executeSql(getSubjectInfo)

                                if(info.rows.length === 1) {
                                    if(info.rows.item(0).subjectColor !== null ) {
                                    color = info.rows.item(0).subjectColor
                                    }
                                }

                            }

                            todaysClasses.append({
                                                     classtitle: Schedule.pullField(
                                                                     "course",
                                                                     "Name",
                                                                     classes[classnum].split(
                                                                         ":")[1].split(
                                                                         ",")[0]),
                                                     classColor: color,
                                                     unitName: Schedule.pullField(
                                                                   "unit",
                                                                   "Name",
                                                                   classes[classnum].split(
                                                                       ":")[1].split(
                                                                       ",")[0]),
                                                     lessonName: "",
                                                     discription: Schedule.pullField(
                                                                      "course",
                                                                      "About",
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

        var dataSTR = "SELECT * FROM Lessons WHERE creationdate =" + taskId

        var pull = tx.executeSql(dataSTR)

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

    })

}

function updateTask(studentCode, taskId, state, qa) {

    console.log(studentCode)

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

        var dataSTR = "SELECT * FROM Student_Assignments WHERE lessonID ="+taskId+" AND studentCode="+studentCode
        var pull = tx.executeSql(dataSTR)    
        var table = ""
        var data = []

        if(pull.rows.length === 0) {
            table = "INSERT INTO Student_Assignments VALUES(?,?,?,?,?,?,?)"
            data = [schoolCode,studentCode,taskId,state,qa,d.getTime(),d.getTime()]
            tx.executeSql(table,data)

        } else {
           table = "UPDATE Student_Assignments SET status=?, qalist=?, editdate=? WHERE studentCode=? AND lessonID=? "
           data = [state,qa,d.getTime(),studentCode,taskId]
           tx.executeSql(table,data)

        }


    })

}


/* this will be used for Steem / updates */
function publishTask(studentCode, taskId) {}

function loadStudentProfile(studentCode) {

    var dataSTR = "SELECT * FROM Students WHERE code =" + studentCode

     db.readTransaction(function(tx) {
            var studentinfo = tx.executeSql(dataSTR)
         if(studentinfo.rows.length === 1) {

            studentFirstName = studentinfo.rows.item(0).firstname
            studentLastName = studentinfo.rows.item(0).lastname

         }

     })

}

function updateStudentProfile(studentCode) {}
