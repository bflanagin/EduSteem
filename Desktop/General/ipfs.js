function mediaAdd(file,type) {

    //console.log("adding things " + file)
    var ipfsReference = file.toString().split(" ")


   var returned = "http://localhost:8080/ipfs/"+ipfsReference[1]

    db.transaction(function (tx) {

        var dataSTR = "INSERT INTO Media VALUES(?,?,?,?,?,?)"
        var data = [schoolCode, userCode, type,ipfsReference[2], ipfsReference[1], d.getTime(
                        )]

        var check = tx.executeSql(
                    "SELECT * from Media WHERE hash = '" + ipfsReference[1] + "'")

        if (check.rows.length !== 1) {
            tx.executeSql(dataSTR, data)
        }
    })

    return returned
}

function mediaRetrieve(hash) {

    db.readTransaction(function (tx) {

        var check = tx.executeSql("SELECT * from Media WHERE hash = ?",[hash])

        if (check.rows.length === 1) {

        }
    })

}

function grabImage(userCode,type) {

    /* checks for existence of an image based on what and who owns it, instead of a hash and returns the ipfs url */

    var returned = ""

    db.readTransaction(function (tx) {

        var check = tx.executeSql("SELECT * from Media WHERE owner = ? AND type = ? ORDER BY creationdate DESC",[userCode,type])

            if(check.rows.length !==0) {
                switch(type) {
                case "profile":returned = "http://localhost:8080/ipfs/"+check.rows.item(0).hash
                    break
                case "general":returned = "http://localhost:8080/ipfs/"+check.rows.item(0).hash
                    break

                }
            } else {
                //console.log("no image found")
            }

    })

return returned
}

