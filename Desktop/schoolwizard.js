function saveSchool(userid,type,name,email,phone,country,state,about) {
    /*saves school */



    db.transaction(function (tx){
         var data = [userid,type,name.replace(/ /g,"_"),email,phone,country,state,about];
         var dtable = "INSERT INTO Schools VALUES(?,?,?,?,?,?,?,?)"
         var update = "UPDATE Schools SET type="+type+", name='"+name.replace(/ /,"_")+"',  email='"+email+"', phone='"+phone+"', country='"+country+"', state='"+state+"', about='"+about+"' WHERE id='"+userid+"'"

        tx.executeSql('CREATE TABLE IF NOT EXISTS Schools (id TEXT, type INT,name TEXT,email TEXT,phone TEXT,country TEXT,state TEXT,about MEDIUMTEXT)')

             var dataSTR = "SELECT * FROM Schools WHERE id ='"+userid+"'";

             var pull = tx.executeSql(dataSTR);
             if(pull.rows.length !== 1) {
                 tx.executeSql(dtable,data);
             } else {
                  tx.executeSql(update);
             }

    });



}

function findSchools() {
    /* Checks online list for schools in eduSteem for naming conflicts. */

}

function loadSchool() {

    /* loads existing school from server location */

}

function loadCourses() {

    /* loads courses associated with the school */

}

function saveCourse() {

    /* saves course for current school */

}


function checklocal(type) {

    /* checking various local databases and returning whether we should run wizards or grab info from the network */

        var pull = "";
        var exists = false;
    db.transaction(function (tx) {

        tx.executeSql('CREATE TABLE IF NOT EXISTS Users (id TEXT, type INT,firstname TEXT,lastname TEXT,email TEXT,phone TEXT,country TEXT,state TEXT,about MEDIUMTEXT)')
        tx.executeSql('CREATE TABLE IF NOT EXISTS Schools (id TEXT, type INT,name TEXT,email TEXT,phone TEXT,country TEXT,state TEXT,about MEDIUMTEXT)')


        switch(type) {
        case "user": pull = tx.executeSql("SELECT id,type FROM Users WHERE id='"+userid+"'"); if(pull.rows.length === 1) {atype = pull.rows.item(0).type; exists = true;}  break;
        case "school": pull = tx.executeSql("SELECT id,type FROM Schools WHERE id='"+userid+"'"); if(pull.rows.length === 1) {etype = pull.rows.item(0).type; exists = true;}  break;
        case "children":break;
        }

    });

    return exists;

}

