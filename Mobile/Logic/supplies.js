function load_supplies(schoolcode,supplies) {

   supList.clear()
    db.readTransaction (function(tx) {

      var num = 0
      var  pull = tx.executeSql("SELECT * FROM Lessons WHERE 1 ORDER BY creationdate ASC")

        while( pull.rows.length > num) {
            var listing
            var lessonName
            if(pull.rows.item(num) !== undefined) {
                lessonName = pull.rows.item(num).name.replace(/_/g," ")
                    if(pull.rows.item(num).supplies.length > 2) {
                listing = pull.rows.item(num).supplies

                console.log(num+":"+lessonName+"\n"+pull.rows.item(num).supplies)
                        supList.append({
                                        theLesson:lessonName,
                                        thelist:listing
                                        })
            }
        }
        num = num + 1
        }

    })


}
