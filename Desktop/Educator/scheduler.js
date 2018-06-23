function load_Day(month,day,weekday) {
      //  console.log("Loading calendar: "+month+":"+day+":"+weekday)
        dayList.clear()
    db.transaction(function (tx){
        tx.executeSql('CREATE TABLE IF NOT EXISTS Schedule (id TEXT, month INT, day MEDIUMTEXT, schoolcode TEXT, educatorcode TEXT,creationdate MEDIUMINT,editdate MEDIUMINT)')
        var num = 0;
        var dataSTR = "SELECT day FROM Schedule WHERE schoolcode ='"+schoolCode+"' AND month ="+month;
        var pull = tx.executeSql(dataSTR)

        if(monthselect.value !== month) {
            monthoffset = monthoffset + 1
        }

        while(pull.rows.length > num) {

            if(pull.rows.item(num).day.split(":")[0] === day) {
                dayList.append({
                                name:pull.rows.item(num).day.split(":")[1]
                               })
                break
            } else {
                var classes = pull.rows.item(num).day.split(";")
                var dom = (weekday - monthoffset) + 1
                var week = (weekday % 7) +1
                var dow = dom - week
               // console.log(week)
                for(var classnum = 0;classnum < (classes.length-1);classnum = classnum + 1) {
                    if(monthselect.value === month) {
                      //  console.log(classes[classnum].split(":")[1].split(",")[week])
                        if(classes[classnum].split(":")[1].split(",")[week] === "true") {
                        dayList.append({
                                name:pullField("course","Name",classes[classnum].split(":")[1].split(",")[0])
                                })
                        }
                    }

                }
            }

            num = num + 1
        }

    });
}
function load_Classes() {

}

function save_schedule(month,day) {

    var d = new Date();


    db.transaction(function (tx){
         var data = [userid,month,day+";",schoolCode,userCode,d.getTime(),d.getTime()];
         var dtable = "INSERT INTO Schedule VALUES(?,?,?,?,?,?,?)"

        tx.executeSql('CREATE TABLE IF NOT EXISTS Schedule (id TEXT, month INT, day MEDIUMTEXT, schoolcode TEXT, educatorcode TEXT,creationdate MEDIUMINT,editdate MEDIUMINT)')

             var dataSTR = "SELECT * FROM Schedule WHERE schoolcode ='"+schoolCode+"'";

             var pull = tx.executeSql(dataSTR);
             if(pull.rows.length !== 1) {
                 tx.executeSql(dtable,data);
             } else {
                 var daysTasks = pull.rows.item(0).day
                    //console.log(daysTasks)
                 if(daysTasks.search(day.split(":")[1]) === -1) {
                 tx.executeSql("UPDATE Schedule SET day='"+daysTasks+day+";' , editdate ="+d.getTime()+" WHERE schoolcode ='"+schoolCode+"' AND month ="+month)
                 } else {
                     console.log("Class already added")
                 }
             }

    });
}

function pullField(where,type,id) {

    var table = ""
    var field = ""

    var returned = ""


    switch(where) {
    case "course": table = "Courses";break;
    case "unit": table = "Units";break;
    case "lesson": table = "Lessons";break;
    }

    db.transaction (function(tx) {

        var dataSTR = "SELECT * FROM "+table+" WHERE creationdate ="+id;
         var pull = tx.executeSql(dataSTR);

        if(pull.rows.length === 1) {
            switch(type) {
            case "Name": returned = pull.rows.item(0).name.replace(/_/g," ");break;
            case "About": returned = pull.rows.item(0).about;break;
            case "Objective": returned = pull.rows.item(0).objective;break;
            case "Resources": returned = pull.rows.item(0).resources;break;
            case "Supplies": returned = pull.rows.item(0).supplies;break;
            case "gq": returned = pull.rows.item(0).guidingQuestions;break;
            case "Sequence": returned = pull.rows.item(0).lessonSequence;break;
            case "rq":returned = pull.rows.item(0).reviewQuestions;break;
            case "Product":returned = pull.rows.item(0).studentProduct;break;
            }
        } else {
            switch(id) {
            case "12": returned = "Lunch";break;
            case "10": returned = "Read to Self";break;
            case "8": returned = "P.E.";break;
            }
        }

    })

    return returned

}
