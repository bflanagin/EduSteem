function loadschool(userid) {


    var pull = "";
    var exists = false;
db.transaction(function (tx) {


    tx.executeSql('CREATE TABLE IF NOT EXISTS Schools (id TEXT, type INT,name TEXT,email TEXT,phone TEXT,country TEXT,state TEXT,about MEDIUMTEXT, code TEXT)')

     pull = tx.executeSql("SELECT * FROM Schools WHERE id='"+userid+"'");
    if(pull.rows.length === 1) {


        if(pull.rows.item(0).code === null) {
            tx.executeSql("UPDATE Schools SET code='"+oneTime(userid,1)+"' WHERE id='"+userid+"'")
        }

        schoolName = pull.rows.item(0).name
        schoolCode = pull.rows.item(0).code

        }


});


}

function loaduser(userid) {


    var pull = "";
    var exists = false;
db.transaction(function (tx) {

    tx.executeSql('CREATE TABLE IF NOT EXISTS Users (id TEXT, type INT,firstname TEXT,lastname TEXT,email TEXT,phone TEXT,country TEXT,state TEXT,about MEDIUMTEXT, code TEXT)')


    pull = tx.executeSql("SELECT * FROM Users WHERE id='"+userid+"'");
    if(pull.rows.length === 1) {



        if(pull.rows.item(0).code === null) {
            tx.executeSql("UPDATE Users SET code='"+oneTime(userid,1)+"' WHERE id='"+userid+"'")
        }

        userName = pull.rows.item(0).firstname+" "+pull.rows.item(0).lastname

    }

});


}

function oneTime(id,action) {

        var code = "";
        var http = new XMLHttpRequest();
         var carddata = "";
        var url = "";

         url = "https://openseed.vagueentertainment.com:8675/corescripts/onetime.php?devid=" + devId + "&appid=" + appId + "&cardid="+id+"&create="+action;


        http.onreadystatechange = function() {
            if (http.readyState == 4) {
                    carddata = http.responseText;


                if(http.responseText == "100") {

                    console.log("Incorrect DevID");

                } else if(http.responseText == "101") {
                    console.log("Incorrect AppID");
                } else {
                    carddata = http.responseText;
                    code = carddata;

                }

            }
        }
        http.open('GET', url.trim(), true);
        http.send(null);


    return code
}
