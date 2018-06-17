function loadStudents(schoolcode) {
    var num = 0;
    studentList.clear();
     db.transaction(function (tx){

         tx.executeSql('CREATE TABLE IF NOT EXISTS Students (id TEXT, firstname TEXT,lastname TEXT, age INT, schoolcode TEXT,phone TEXT,email TEXT,steempost TEXT,code MEDIUMINT,editdate MEDIUMINT)')

         var dataSTR = "SELECT * FROM Students WHERE schoolcode ='"+schoolcode+"'";

         var pull = tx.executeSql(dataSTR);

         while (pull.rows.length > num) {

             studentList.append ({
                                name:pull.rows.item(num).firstname+" "+pull.rows.item(num).lastname,
                                cdate: pull.rows.item(num).code,
                                edate: pull.rows.item(num).editdate
                                })

            num = num + 1
         }

     });

}


function loadStudent(code) {
    var num = 0;

     db.transaction(function (tx){

         tx.executeSql('CREATE TABLE IF NOT EXISTS Students (id TEXT, firstname TEXT,lastname TEXT, age INT, schoolcode TEXT,phone TEXT,email TEXT,steempost TEXT,code MEDIUMINT,editdate MEDIUMINT)')

         var dataSTR = "SELECT * FROM Students WHERE code ='"+code+"'";

         var pull = tx.executeSql(dataSTR);

         if(pull.rows.length ===1) {

            studentname = pull.rows.item(0).firstname+" "+pull.rows.item(0).lastname
         }

     });

}


function saveStudent(userid,firstName,lastName,age,schoolID,contactNumber,emailAddress,steemPostToken) {

     /*saves Student */

    var d = new Date()


    db.transaction(function (tx){
         var data = [userid,firstName,lastName,age,schoolID,contactNumber,emailAddress,steemPostToken,d.getTime(),d.getTime()];
         var dtable = "INSERT INTO Students VALUES(?,?,?,?,?,?,?,?,?,?)"
        // var update = "UPDATE Schools SET firstName="+type+", LastName='"+name.replace(/ /,"_")+"',  email='"+email+"', phone='"+phone+"', school='"+country+"' WHERE creationdate='"+userid+"'"

        tx.executeSql('CREATE TABLE IF NOT EXISTS Students (id TEXT, firstname TEXT,lastname TEXT, age INT, schoolcode TEXT,phone TEXT,email TEXT,steempost TEXT,code MEDIUMINT,editdate MEDIUMINT)')

             var dataSTR = "SELECT * FROM Students WHERE firstname ='"+firstName+"' AND lastname ='"+lastName+"'";

             var pull = tx.executeSql(dataSTR);
             if(pull.rows.length < 1) {
                 tx.executeSql(dtable,data);
            // } else {
            //      tx.executeSql(update);
             }

    });

}
