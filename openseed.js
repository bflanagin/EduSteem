var updateinterval = 20;



function oseed_auth(name,email) {

    var http = new XMLHttpRequest();
    //var url = "http://openseed.vagueentertainment.com/corescripts/auth.php?devid=" + devId + "&appid=" + appId + "&username="+ name + "&email=" + email ;
    var url = "http://openseed.vagueentertainment.com/corescripts/authPOST.php";
   // console.log(url)
    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            //console.log(http.responseText);
            //userid = http.responseText;
            if(http.responseText == 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {
              //  console.log(http.responseText);
                id = http.responseText;
                createdb();
            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&username="+ name + "&email=" + email);

    //be sure to remove this when the internet is back and before we distribute//
    //id = "00010101";

    //createdb();
}

function createdb() {

    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);
    var userStr = "INSERT INTO ACCOUNTS VALUES(?,?,?)";

    var numofaccounts = 0;

    var updateUser = "UPDATE ACCOUNTS SET name='"+username+"', family='"+family+"' WHERE id='"+id+"'";
    var data = [username,id,family];

    var testStr = "SELECT  *  FROM ACCOUNTS WHERE id= '"+id+"'";

    var accountsStr = "SELECT  *  FROM ACCOUNTS WHERE 1 ";

        db.transaction(function(tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS ACCOUNTS (id TEXT, name TEXT, family TEXT)');

                            var test1 = tx.executeSql(accountsStr);

                                numofaccounts = test1.rows.length;

                        var test = tx.executeSql(testStr);


                            if(test.rows.length == 0) {
                                if (id.length > 4) {
                                tx.executeSql(userStr,data);
                                }
                            } else {

                            tx.executeSql(updateUser);

                                }



        });



    db.transaction(function(tx) {

        var childStr = "SELECT * FROM CHILDS WHERE 1";

            tx.executeSql('CREATE TABLE IF NOT EXISTS CHILDS (name TEXT,birthday TEXT,stickerset TEXT,os_account TEXT)');

                    var test = tx.executeSql(childStr);
                        var num = 0;

                        if(numofaccounts == 0) {

                                console.log("First Account!");

                            if(test.rows.length != 0) {

                                 console.log("Children Exist!");

                                 while (test.rows.length > num) {

                                         var updateChild = "UPDATE CHILDS SET os_account='"+id+"' WHERE name='"+test.rows.item(num).name+"'";

                                         tx.executeSql(updateChild);

                                            sendchild(test.rows.item(num).name,test.rows.item(num).birthday,id);

                                          num = num + 1;
                                     }

                            } else {
                                retrievedata();
                            }

                        }



    });


    db.transaction(function(tx) {

        var taskStr = "SELECT * FROM TASKS WHERE 1";

           tx.executeSql('CREATE TABLE IF NOT EXISTS TASKS (name TEXT,discription TEXT,os_account TEXT)');

                    var test = tx.executeSql(taskStr);
                        var num = 0;

                        if(numofaccounts == 0) {

                                console.log("First Account!");

                            if(test.rows.length != 0) {

                                 console.log("Tasks Exist!");

                                 while (test.rows.length > num) {

                                         var updateTask = "UPDATE TASKS SET os_account='"+id+"' WHERE name='"+test.rows.item(num).name+"'";

                                         tx.executeSql(updateTask);

                                        sendtask(test.rows.item(num).name,test.rows.item(num).discription,id);

                                          num = num + 1;
                                     }

                            }

                        }



    });


    db.transaction(function(tx) {

        var taskStr = "SELECT * FROM ASSIGNED WHERE 1";

        tx.executeSql('CREATE TABLE IF NOT EXISTS ASSIGNED (task TEXT,children TEXT,dwm INT,Mon TEXT,Tue TEXT,Wed TEXT,Thu TEXT,Fri TEXT,Sat TEXT,Sun TEXT,date INT,month INT,os_account TEXT)');

                    var test = tx.executeSql(taskStr);
                        var num = 0;

                        if(numofaccounts == 0) {

                                console.log("First Account!");

                            if(test.rows.length != 0) {

                                 console.log("Tasks Assigned Exist!");

                                 while (test.rows.length > num) {

                                         var updateAssigned = "UPDATE ASSIGNED SET os_account='"+id+"' WHERE task='"+test.rows.item(num).task+"'";

                                         tx.executeSql(updateAssigned);


                                        sendassignment(test.rows.item(num).task,test.rows.item(num).children,test.rows.item(num).dwm,id);

                                          num = num + 1;
                                     }

                            }

                        }



    });


    //firstrun.restart();


}


function accountlist() {

    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);

    accesslist.clear();

     var testStr = "SELECT  *  FROM ACCOUNTS WHERE 1";


    db.transaction(function(tx) {

        tx.executeSql('CREATE TABLE IF NOT EXISTS ACCOUNTS (name TEXT,id TEXT,family TEXT)');

         var pull =  tx.executeSql(testStr);
        var num = 0;
        var numofchildren = 0;

            while (pull.rows.length > num) {


                accesslist.append ({

                                       accountname:pull.rows.item(num).family,
                                       familyid:pull.rows.item(num).id,
                                       childnumber:numofchildren


                                   });

                num = num + 1;
            }

            accesslist.append ({

                                   accountname:"1",
                                   familyid:"1",
                                   childnumber:numofchildren


                               });

    });


}



function heartbeat() {

    var http = new XMLHttpRequest();
    var url = "http://openseed.vagueentertainment.com/corescripts/heartbeat.php";
   // console.log(url)

    http.onreadystatechange = function() {

       if(http.status == 200) {
        if (http.readyState == 4) {
            //console.log(http.responseText);
            //userid = http.responseText;
            if(http.responseText == 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {

                heart = http.responseText;
                updateinterval = 2000;

                if(roomid != " ") {
                 if (playing == 0) {retrieve_chat(roomid,currentid); }
                }
                check_requests();

            }

        }
            } else {
                    heart = "Offline";
                    updateinterval = 2000 + updateinterval;

        }
    }
    http.open('POST', url.trim(), true);
   // console.log(http.statusText);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&userid="+ id);

    heartbeats.interval = updateinterval;

}

function sendtask(taskname,discription,account) {

    var http = new XMLHttpRequest();
    var url = "http://openseed.vagueentertainment.com/devs/Vag-01001011/vagTKd-0625/scripts/sync.php";

   // console.log(taskname,account);
   // console.log(url)

    http.onreadystatechange = function() {

        if (http.readyState == 4) {

            if(http.responseText == 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {

               // console.log(http.responseText);

            }

        }

    }
    http.open('POST', url.trim(), true);
   // console.log(http.statusText);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&id="+ account + "&type=TASKS" + "&name="+ taskname+ "&info1="+ discription+"&action=sending" );

}

function sendchild(childname,bday,account) {

    var http = new XMLHttpRequest();
    var url = "http://openseed.vagueentertainment.com/devs/Vag-01001011/vagTKd-0625/scripts/sync.php";

    //console.log(childname,account);
   // console.log(url)

    http.onreadystatechange = function() {

        if (http.readyState == 4) {

            if(http.responseText == 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {

              //  console.log(http.responseText);

            }

        }

    }
    http.open('POST', url.trim(), true);
   // console.log(http.statusText);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&id="+ account + "&type=CHILDS" + "&name="+ childname+ "&info1="+ bday+"&action=sending" );

}



function stickerupdate(childname,taskname) {

    var http = new XMLHttpRequest();
    var url = "http://openseed.vagueentertainment.com/devs/Vag-01001011/vagTKd-0625/scripts/sync.php";

    //console.log(childname,account);
   // console.log(url)

    http.onreadystatechange = function() {

        if (http.readyState == 4) {

            if(http.responseText == 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {

                //console.log(http.responseText);

            }

        }

    }
    http.open('POST', url.trim(), true);
   // console.log(http.statusText);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&id="+ id + "&type=ASSIGNED" + "&name="+ taskname+ "&info1="+ childname+
              "&info3="+monStick+"&info4="+tueStick+"&info5="+wedStick+"&info6="+thuStick+"&info7="+friStick
              +"&info8="+satStick+"&info9="+sunStick+"&info10="+currentdate+"&info11="+currentmonth+"&action=update");

}

function retrievedata() {

    var http = new XMLHttpRequest();
    var url = "http://openseed.vagueentertainment.com/devs/Vag-01001011/vagTKd-0625/scripts/sync.php";

    //console.log("OpenSeed.js "+childname,id);
   // console.log(url)

    http.onreadystatechange = function() {

        if (http.readyState == 4) {

            if(http.responseText == 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {

                var stuffnum = 1;
                var sitedata =http.responseText.split(">!<");

                while(sitedata.length > stuffnum) {

                    switch(sitedata[stuffnum].split("::")[1]) {
                    case "CHILDS":addchild(sitedata[stuffnum].split("::")[2],sitedata[stuffnum].split("::")[3]);break;
                    case "TASKS":addtask(sitedata[stuffnum].split("::")[2],sitedata[stuffnum].split("::")[3]);break;
                    case "ASSIGNED":assigntask(sitedata[stuffnum].split("::")[3],sitedata[stuffnum].split("::")[4],sitedata[stuffnum].split("::")[2]);break;
                    }

                    stuffnum = stuffnum + 1;
                }



              //console.log(http.responseText);

            }

        }

    }
    http.open('POST', url.trim(), true);
   // console.log(http.statusText);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&id="+ id +"&action=sync" );




}
