
function oseed_auth(name,email,passphrase) {

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
