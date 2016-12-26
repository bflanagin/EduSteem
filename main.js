
function familylist(type) {

    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);

    var testStr = "SELECT  *  FROM ACCOUNTS WHERE 1";


    db.transaction(function(tx) {

        tx.executeSql('CREATE TABLE IF NOT EXISTS ACCOUNTS (name TEXT,id TEXT,family TEXT)');

         var pull =  tx.executeSql(testStr);
        var num = 0;

        if(type == 1) {

            while (pull.rows.length > num) {

                    familieslist.append ({
                                         name:pull.rows.item(num).family,
                                         theaccount:pull.rows.item(num).id

                                          });


                num = num + 1;
            }

        } else if(type == 0) {



            if(pull.rows.length == 1) {
                 currentfamily = pull.rows.item(0).family;
                id = pull.rows.item(0).id;
                childlist(3);

            } else if(pull.rows.length == 0) {
                        childlist(3);
            } else {
                thefamilies.state = "Show";
            }

        }
    });

}


function childlist(type) {


        var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);

       if(type != 3) {
        childslist.clear();
        }
         var testStr = "SELECT  *  FROM CHILDS WHERE os_account='"+id+"'";


        db.transaction(function(tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS CHILDS (name TEXT,birthday TEXT,stickerset TEXT,os_account TEXT)');

             var pull =  tx.executeSql(testStr);
            var num = 0;

                while (pull.rows.length > num) {



                    if (type == 0) {
                    childslist.append ({

                                           name:pull.rows.item(num).name,
                                           birthday:pull.rows.item(num).birthday,
                                           stickerset:pull.rows.item(num).stickerset

                                       });
                    } else if(type == 1) {

                        childslist.append ({

                                               text:pull.rows.item(num).name

                                           });

                    } else if(type == 4) {

                        childslist.append ({

                                               name:pull.rows.item(num).name,
                                               birthday:pull.rows.item(num).birthday,
                                               stickerset:pull.rows.item(num).stickerset

                                           });
                    }

                    num = num + 1;
                }

                if(type == 0) {

                childslist.append ({

                                       name:"Add New",
                                       birthday:"06/24/16",
                                       stickerset:"1"

                                   });

                } else if(type == 1) {
                    childslist.append ({

                                           text:"All"

                                       });
                }


                if(type == 3) {

                    if(pull.rows.length > 1) {
                        thechildren.state = "Show";
                    } else if(pull.rows.length == 1){
                        childname = pull.rows.item(0).name;
                        updateassignment.running = "true";
                    } else {

                        thesettings.state = "Show";
                    }
                }

        });


}

function tasklist() {

    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);

    taskslist.clear();

     var testStr = "SELECT  *  FROM TASKS WHERE 1";


    db.transaction(function(tx) {

        tx.executeSql('CREATE TABLE IF NOT EXISTS TASKS (name TEXT,discription TEXT,os_account TEXT)');

         var pull =  tx.executeSql(testStr);
        var num = 0;

            while (pull.rows.length > num) {


                taskslist.append ({

                                       taskname:pull.rows.item(num).name,
                                       discription:pull.rows.item(num).discription,


                                   });

                num = num + 1;
            }

            taskslist.append ({

                                   taskname:"1",
                                   discription:"Add a New Task",


                               });

    });


}

function addchild(name,bday) {


        var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);

        var testStr = "SELECT  *  FROM CHILDS WHERE name='"+name+"'";


        var data = [name.replace(/\'/g,"&#x27;").trim(),bday,"stickers1",id];

        var libStr = "INSERT INTO CHILDS VALUES(?,?,?,?)";

        db.transaction(function(tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS CHILDS (name TEXT,birthday TEXT,stickerset TEXT,os_account TEXT)');

             var pull =  tx.executeSql(testStr);

            if(pull.rows.length == 0) {

                if(name.length >= 1) {

                    tx.executeSql(libStr,data);

                }

            }



        });

}

function addtask(name,discription) {


        var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);

        var testStr = "SELECT  *  FROM TASKS WHERE name='"+name+"'";


        var data = [name.replace(/\'/g,"&#x27;").trim(),discription.replace(/\'/g,"&#x27;").trim(),id];

        var libStr = "INSERT INTO TASKS VALUES(?,?,?)";

        db.transaction(function(tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS TASKS (name TEXT,discription TEXT,os_account)');

             var pull =  tx.executeSql(testStr);

            if(pull.rows.length == 0) {

                if(name.length >= 1) {

                    tx.executeSql(libStr,data);

                }

            }



        });

}


function assigntask(child,dwm,task) {


        var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);



        var d = new Date();

        var taskdate;
    var dotw;
    if(d.getDay() == 0) {
        dotw = 7;
    } else {
        dotw = d.getDay();
    }


        if(d.getDate()-dotw >= 0) {
        taskdate = d.getDate()-dotw;
        } else {
            switch(d.getMonth()) {
            case 0: taskdate = 31+d.getDate() -dotw;break;
            case 1: if(d.getFullYear() % 4 !=0) {taskdate = 28+d.getDate() -dotw;} else {taskdate = 29+d.getDate() -dotw;}break;
            case 2: taskdate = 31+d.getDate() -dotw;break;
            case 3: taskdate = 30+d.getDate() -dotw;break;
            case 4: taskdate = 31+d.getDate() -dotw;break;
            case 5: taskdate = 30+d.getDate() -dotw;break;
            case 6: taskdate = 31+d.getDate() -dotw;break;
            case 7: taskdate = 31+d.getDate() -dotw;break;
            case 8: taskdate = 30+d.getDate() -dotw;break;
            case 9: taskdate = 31+d.getDate() -dotw;break;
            case 10: taskdate = 30+d.getDate() -dotw;break;
            case 11: taskdate = 31+d.getDate() -dotw;break;

            }
        }

        var testStr = "SELECT  *  FROM ASSIGNED WHERE task='"+task+"' AND children='"+child+"' AND month='"+d.getMonth()+"'";

        var updateStr = "UPDATE ASSIGNED SET children ='"+child.replace(/\'/g,"&#x27;").trim()+"', dwm='"+dwm+"' WHERE task = '"+task+"' AND children='"+child+"'";

        var data = [task,child.replace(/\'/g,"&#x27;").trim(),dwm,
"graphics/blank.png","graphics/blank.png","graphics/blank.png","graphics/blank.png","graphics/blank.png","graphics/blank.png","graphics/blank.png",
        taskdate,d.getMonth(),id];

        var libStr = "INSERT INTO ASSIGNED VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)";



        db.transaction(function(tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS ASSIGNED (task TEXT,children TEXT,dwm INT,Mon TEXT,Tue TEXT,Wed TEXT,Thu TEXT,Fri TEXT,Sat TEXT,Sun TEXT,date INT,month INT,os_account TEXT)');

             var pull =  tx.executeSql(testStr);

            if(pull.rows.length == 0) {

                    //console.log("Adding "+child,task);

                    tx.executeSql(libStr,data);



            } else {

               // console.log("Updating "+child,task);

                tx.executeSql(updateStr);

            }



        });

}

function assignments() {

    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);

    assginedlist.clear();

    // console.log("loading Assignments");


    var d = new Date();

    var allStr = "SELECT  *  FROM ASSIGNED WHERE children='All' AND os_account='"+id+"'";

    db.transaction(function(tx) {

        tx.executeSql('CREATE TABLE IF NOT EXISTS ASSIGNED (task TEXT,children TEXT,dwm INT,Mon TEXT,Tue TEXT,Wed TEXT,Thu TEXT,Fri TEXT,Sat TEXT,Sun TEXT,date INT,month INT)');

         var pull =  tx.executeSql(allStr);
        var num = 0;

            while (pull.rows.length > num) {

                assigntask(childname,pull.rows.item(num).dwm,pull.rows.item(num).task);
                sendassignment(pull.rows.item(num).task,childname,pull.rows.item(num).dwm,id)

            num = num + 1;
        }


});



    if (d.getDay() == 1) {
        var newStr = "SELECT  *  FROM ASSIGNED WHERE os_account='"+id+"'";
    db.transaction(function(tx) {

        tx.executeSql('CREATE TABLE IF NOT EXISTS ASSIGNED (task TEXT,children TEXT,dwm INT,Mon TEXT,Tue TEXT,Wed TEXT,Thu TEXT,Fri TEXT,Sat TEXT,Sun TEXT,date INT,month INT)');

         var pull =  tx.executeSql(newStr);
        var num = 0;

            while (pull.rows.length > num) {

                assigntask(childname,pull.rows.item(num).dwm,pull.rows.item(num).task);

            num = num + 1;
        }


});

}


    var taskdate;
    var dotw;
    if(d.getDay() == 0) {
        dotw = 7;
    } else {
        dotw = d.getDay();
    }

    if(d.getDate()-dotw >= 0) {
    taskdate = d.getDate()-dotw;
    } else {
        switch(d.getMonth()) {
        case 0: taskdate = 31 + d.getDate()-dotw;break;
        case 1: if(d.getFullYear() % 4 !=0) {taskdate = 28+d.getDate() -dotw;} else {taskdate = 29+d.getDate() -dotw;}break;
        case 2: taskdate = 31+d.getDate() -dotw;break;
        case 3: taskdate = 30+d.getDate() -dotw;break;
        case 4: taskdate = 31+d.getDate() -dotw;break;
        case 5: taskdate = 30+d.getDate() -dotw;break;
        case 6: taskdate = 31+d.getDate() -dotw;break;
        case 7: taskdate = 31+d.getDate() -dotw;break;
        case 8: taskdate = 30+d.getDate() -dotw;break;
        case 9: taskdate = 31+d.getDate() -dotw;break;
        case 10: taskdate = 30+d.getDate() -dotw;break;
        case 11: taskdate = 31+d.getDate() -dotw;break;

        }
    }

    currentdate = taskdate;
    currentmonth = d.getMonth();

     var testStr = "SELECT  *  FROM ASSIGNED WHERE children='"+childname+"' AND date='"+taskdate+"'";


    db.transaction(function(tx) {

        tx.executeSql('CREATE TABLE IF NOT EXISTS ASSIGNED (task TEXT,children TEXT,dwm INT,Mon TEXT,Tue TEXT,Wed TEXT,Thu TEXT,Fri TEXT,Sat TEXT,Sun TEXT,date INT,month INT)');

         var pull =  tx.executeSql(testStr);
        var num = 0;

            while (pull.rows.length > num) {


               assginedlist.append ({

                                        thetaskname:pull.rows.item(num).task,
                                        themonStick:pull.rows.item(num).Mon,
                                        thetueStick:pull.rows.item(num).Tue,
                                        thewedStick:pull.rows.item(num).Wed,
                                        thethuStick:pull.rows.item(num).Thu,
                                        thefriStick:pull.rows.item(num).Fri,
                                        thesatStick:pull.rows.item(num).Sat,
                                        thesunStick:pull.rows.item(num).Sun

                                   });

                num = num + 1;
            }
    });




}

function stickerChange (child,taskname) {


    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);

    var testStr = "SELECT  *  FROM ASSIGNED WHERE task='"+taskname+"' AND children='"+child+"'";

    var d = new Date();

    var updateStr = "UPDATE ASSIGNED SET Mon='"+monStick+"',Tue='"+tueStick+"',Wed='"+wedStick+"',Thu='"+thuStick+"', \
        Fri='"+friStick+"',Sat='"+satStick+"',Sun='"+sunStick+"' WHERE task = '"+taskname+"' AND children='"+child+"'";



    db.transaction(function(tx) {

        tx.executeSql('CREATE TABLE IF NOT EXISTS ASSIGNED (task TEXT,children TEXT,dwm INT,Mon TEXT,Tue TEXT,Wed TEXT,Thu TEXT,Fri TEXT,Sat TEXT,Sun TEXT,date INT,month INT)');

         var pull =  tx.executeSql(testStr);

        if(pull.rows.length == 0) {

        } else {

            tx.executeSql(updateStr);

        }



    });

}

//breaking my own rule about seperating network and local fuctions, but this makes my life easier.

function retrievedata() {

    var http = new XMLHttpRequest();
    var url = "http://openseed.vagueentertainment.com/devs/Vag-01001011/vagTKd-0625/scripts/sync.php";

   // console.log( "Main.js " +childname,id);
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

function sendassignment(taskname,childname,dwm,account) {

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

    var d = new Date();
    var taskdate;
    var dotw;
        if(d.getDay() == 0) {
             dotw = 7;
            } else {
                 dotw = d.getDay();
            }


    if(d.getDate()-dotw >= 0) {
    taskdate = d.getDate()-dotw;
    } else {
        switch(d.getMonth()) {
        case 0: taskdate = 31+d.getDate() -dotw;break;
        case 1: if(d.getFullYear() % 4 !=0) {taskdate = 28+d.getDate() -dotw;} else {taskdate = 29+d.getDate() -dotw;}break;
        case 2: taskdate = 31+d.getDate() -dotw;break;
        case 3: taskdate = 30+d.getDate() -dotw;break;
        case 4: taskdate = 31+d.getDate() -dotw;break;
        case 5: taskdate = 30+d.getDate() -dotw;break;
        case 6: taskdate = 31+d.getDate() -dotw;break;
        case 7: taskdate = 31+d.getDate() -dotw;break;
        case 8: taskdate = 30+d.getDate() -dotw;break;
        case 9: taskdate = 31+d.getDate() -dotw;break;
        case 10: taskdate = 30+d.getDate() -dotw;break;
        case 11: taskdate = 31+d.getDate() -dotw;break;

        }
    }
        currentdate = taskdate;
        currentmonth = d.getMonth();

    //d.getDate(),d.getMonth(),id];
    http.open('POST', url.trim(), true);
   // console.log(http.statusText);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&id="+ account + "&type=ASSIGNED" + "&name="+ taskname+ "&info1="+ childname +
              "&info2="+dwm+"&info3=graphics/blank.png"+"&info4=graphics/blank.png"+"&info5=graphics/blank.png"+"&info6=graphics/blank.png"
              +"&info7=graphics/blank.png"+"&info8=graphics/blank.png"+"&info9=graphics/blank.png"+"&info10="+taskdate+"&info11="+d.getMonth()+"&action=sending" );

}


function updatedata() {

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

                var stuffnum = 1;
                var sitedata =http.responseText.split(">!<");

                while(sitedata.length > stuffnum) {

                    if(sitedata[stuffnum].split("::")[1] == "ASSIGNED") {
                        if(sitedata[stuffnum].split("::")[3] == childname) {
                           // console.log(sitedata[stuffnum].split("::"));



                            var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);

                            var testStr = "SELECT  *  FROM ASSIGNED WHERE task='"+sitedata[stuffnum].split("::")[2]+"' AND children='"+childname+"'";

                            var d = new Date();

                            var updateStr = "UPDATE ASSIGNED SET Mon='"+sitedata[stuffnum].split("::")[5]+"',Tue='"+sitedata[stuffnum].split("::")[6]+
                                "',Wed='"+sitedata[stuffnum].split("::")[7]+"',Thu='"+sitedata[stuffnum].split("::")[8]+
                                "',Fri='"+sitedata[stuffnum].split("::")[9]+"',Sat='"+sitedata[stuffnum].split("::")[10]+
                                "',Sun='"+sitedata[stuffnum].split("::")[11]+"' WHERE task = '"+sitedata[stuffnum].split("::")[2]+"' AND children='"+childname+"' AND date='"+currentdate+"' AND month='"+currentmonth+"'";

                            db.transaction(function(tx) {

                                tx.executeSql('CREATE TABLE IF NOT EXISTS ASSIGNED (task TEXT,children TEXT,dwm INT,Mon TEXT,Tue TEXT,Wed TEXT,Thu TEXT,Fri TEXT,Sat TEXT,Sun TEXT,date INT,month INT)');

                                 var pull =  tx.executeSql(testStr);

                                if(pull.rows.length != 0) {

                                    tx.executeSql(updateStr);
                                }

                            });

                        }
                    }

                    stuffnum = stuffnum + 1;
                }

            assignments();
            }

        }

    }
    http.open('POST', url.trim(), true);
   // console.log(http.statusText);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&id="+ id +"&action=sync" );




}



