 /* general OpenSeed authentication */

function oseed_auth(name,email,passphrase) {

    /*send the data to get authentication from the server. This is a simpler version of checkcreds and may be removed */

    var http = new XMLHttpRequest();
    //var url = "https://openseed.vagueentertainment.com:8675/corescripts/auth.php?devid=" + devId + "&appid=" + appId + "&username="+ name + "&email=" + email ;
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/authPOST.php";
   // console.log(url)
    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            //console.log(http.responseText);
            //userid = http.responseText;
            if(http.responseText === 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText === 101) {
                console.log("Incorrect AppID");
            } else {
              //  console.log(http.responseText);
                userid = http.responseText;
                //createdb();
                message = userid;
            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&username="+ name + "&email=" + email + "&passphrase=" + passphrase);
}




function heartbeat() {

    /* This is a simple heart beat function to verify that data can be sent to the server. This is needed for the asyncronious nature of the program */

    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/heartbeat.php";
   // console.log(url)

    http.onreadystatechange = function() {

       if(http.status === 200) {
        if (http.readyState === 4) {
            //console.log(http.responseText);
            //userid = http.responseText;
            if(http.responseText === "100") {
                console.log("Incorrect DevID");
            } else if(http.responseText === "101") {
                console.log("Incorrect AppID");
            } else {

                heart = http.responseText;
                //updateinterval = 5500;

              // console.log(heart);

            }

        }
            } else {
                    heart = "Offline";
                    //updateinterval = 500 + updateinterval;
           // console.log(heart);


        }
      // heartbeat.interval = updateinterval;
    }
    http.open('POST', url.trim(), true);
   // console.log(http.statusText);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&userid="+ userid);

    //

}


function checkcreds(field,info) {

    /* User for quick checks to the server to verify new accounts and validate old ones. */

    var http = new XMLHttpRequest();
    //var url = "https://openseed.vagueentertainment.com:8675/corescripts/auth.php?devid=" + devId + "&appid=" + appId + "&username="+ name + "&email=" + email ;
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/authCHECK.php";
   // console.log("sending "+name+" , "+passphrase);
    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            //console.log(http.responseText);
            //userid = http.responseText;
            if(http.responseText === "100") {
                uniqueemail = 100;
                console.log("Incorrect DevID");
            } else if(http.responseText === "101") {

                uniqueemail = 101;
                console.log("Incorrect AppID");
            } else {
                //message = http.responseText;
                //id = http.responseText;
                if(field === "email") {
                   console.log (http.responseText);
                    uniqueemail = http.responseText;
                }
                if(field === "username") {
                    uniquename = http.responseText;
                    console.log (http.responseText);
                   //message = http.responseText;
                }

                if(field === "account") {
                    uniqueaccount = http.responseText;
                }

                if(field === "passphrase") {
                    uniqueid = http.responseText;


                    if(uniqueid != '0') {
                        message = "Login granted";
                        userid = uniqueid;
                    } else {
                        message = "Incorrect password";
                    }

                }
            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&type="+ field + "&info=" + info);


}


function account_type(userid) {

    /* Checks to see if the user id is an admin or a normal user good for programs that have multiple layers of account */

    var http = new XMLHttpRequest();
    //var url = "https://openseed.vagueentertainment.com:8675/corescripts/auth.php?devid=" + devId + "&appid=" + appId + "&username="+ name + "&email=" + email ;
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/authCHECK.php";
   // console.log("sending "+name+" , "+passphrase);
   // console.log(userid);
    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            //console.log(http.responseText);
            //userid = http.responseText;
            if(http.responseText === 100) {
               // uniqueemail = 100;
                console.log("Incorrect DevID");
            } else if(http.responseText === 101) {

                //uniqueemail = 101;
                console.log("Incorrect AppID");
            } else {
               console.log(http.responseText);
                if(http.responseText === "1") {
                    connection_type = "Admin";
                } else {
                    connection_type = "User";
                }
            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&type=admin&info=" + userid);

}


/* End General functions */


function save_local(userid,type,firstname,lastname,email,phone,country,state,about) {

   db.transaction(function (tx){
        var data = [userid,type,firstname,lastname,email,phone,country,state,about];
        var dtable = "INSERT INTO Users VALUES(?,?,?,?,?,?,?,?,?)"
        var update = "UPDATE Users SET type="+type+", firstname='"+firstname+"', lastname='"+lastname+"', email='"+email+"', phone='"+phone+"', country='"+country+"', state='"+state+"', about='"+about+"' WHERE id='"+userid+"'"

       tx.executeSql('CREATE TABLE IF NOT EXISTS Users (id TEXT, type INT,firstname TEXT,lastname TEXT,email TEXT,phone TEXT,country TEXT,state TEXT,about MEDIUMTEXT)')

            var dataSTR = "SELECT * FROM Users WHERE id ='"+userid+"'";

            var pull = tx.executeSql(dataSTR);
            if(pull.rows.length !== 1) {
                tx.executeSql(dtable,data);
            } else {
                 tx.executeSql(update);
            }

   });

}
