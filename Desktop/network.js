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
                beat.interval = 20000;

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

function checkOpenSeed(userid,code,type) {

    console.log("Checking for "+code)

    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/devs/Vag-01001011/vagEdu-053018/scripts/check.php";


    http.onreadystatechange = function() {

       if(http.status === 200) {
        if (http.readyState === 4) {
           // console.log(http.responseText);
            //userid = http.responseText;
            if(http.responseText == "100") {
                console.log("Incorrect DevID");
            } else if(http.responseText == "101") {
                console.log("Incorrect AppID");
            } else {

                console.log(http.responseText)

            }

        }

       }

    }
    http.open('POST', url.trim(), true);

    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&userid="+ userid + "&code="+ code +"&type="+ type);



}


