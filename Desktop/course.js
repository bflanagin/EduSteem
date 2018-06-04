function saveCourse(userid,name,subject,language,about,creationdate) {

    var d = new Date();

    db.transaction(function (tx){
         var data = [userid,name,subject.split(" - ")[0],language,about,d.getTime()];
         var dtable = "INSERT INTO Courses VALUES(?,?,?,?,?,?)"
         var update = "UPDATE Courses SET name='"+name+"', subject='"+subject.split(" - ")[0]+"', language='"+language+"', about='"+about+"' WHERE id='"+userid+"' AND creationdate ="+creationdate

        tx.executeSql('CREATE TABLE IF NOT EXISTS Courses (id TEXT, name TEXT, subject TEXT,language TEXT, about MEDIUMTEXT, creationdate INT)')

             var dataSTR = "SELECT * FROM Courses WHERE id ='"+userid+"' AND creationdate ="+creationdate;

             var pull = tx.executeSql(dataSTR);
             if(pull.rows.length !== 1) {
                 tx.executeSql(dtable,data);
             } else {
                  tx.executeSql(update);
             }

    });
}


function loadCourses(userid) {
     db.transaction(function (tx){
            courseList.clear();
         tx.executeSql('CREATE TABLE IF NOT EXISTS Courses (id TEXT, name TEXT, subject TEXT,language TEXT, about MEDIUMTEXT, creationdate INT)')

              var dataSTR = "SELECT * FROM Courses WHERE id ='"+userid+"'";

            var pull = tx.executeSql(dataSTR);
            var num = 0;
            while(pull.rows.length > num) {

                courseList.append ({
                                   name:pull.rows.item(num).name,
                                   cdate: pull.rows.item(num).creationdate

                                   })


                num = num + 1

            }


     });
}

function loadCourse(userid,coursenumber) {
    console.log(coursenumber);

     db.transaction(function (tx){

         tx.executeSql('CREATE TABLE IF NOT EXISTS Courses (id TEXT, name TEXT, subject TEXT,language TEXT, about MEDIUMTEXT, creationdate INT)')

              var dataSTR = "SELECT * FROM Courses WHERE id ='"+userid+"' AND creationdate ="+coursenumber;

            var pull = tx.executeSql(dataSTR);

            if(pull.rows.length === 1) {

               courseName = pull.rows.item(0).name


            }


     });
}
