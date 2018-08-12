function createddbs() {

    db.transaction(function (tx) {

        /* convenience databases */
        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Subjects (schoolCode TEXT,subjectNumber INT ,subjectName TEXT,subjectColor TEXT,subjectBg TEXT,creationdate MEDIUMINT)')

        /* user databases */
        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Users (id TEXT, type INT,firstname TEXT,lastname TEXT,email TEXT,phone TEXT,country TEXT,state TEXT,about MEDIUMTEXT, code TEXT,editdate MEDIUMINT)')

        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Steem (id TEXT, type INT,data1 TEXT,data2 TEXT,data3 TEXT)')

        /* school databases */
        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Schools (id TEXT, type INT,name TEXT,email TEXT,phone TEXT,country TEXT,state TEXT,about MEDIUMTEXT, code TEXT,editdate MEDIUMINT)')

        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Lessons (id TEXT, educatorID TEXT,published INT, coursenumber MEDIUMINT,unitnumber MEDIUMINT, name TEXT, lessonNum INT, duration INT, about MEDIUMTEXT, objective MEDIUMTEXT, supplies MEDIUMTEXT, resources MEDIUMTEXT, \
guidingQuestions MEDIUMTEXT, lessonSequence MEDIUMTEXT, studentProduct MEDIUMTEXT, reviewQuestions MEDIUMTEXT,creationdate MEDIUMINT,editdate MEDIUMINT)')

        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Units (id TEXT, coursenumber MEDIUMINT,unitNum INT, name TEXT, objective MEDIUMTEXT, about MEDIUMTEXT, creationdate MEDIUMINT,editdate MEDIUMINT)')

        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Courses (id TEXT, name TEXT, subject TEXT,language TEXT, about MEDIUMTEXT, creationdate MEDIUMINT,editdate MEDIUMINT)')
        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Schedule (id TEXT, month INT, day MEDIUMTEXT, schoolcode TEXT, educatorcode TEXT,creationdate MEDIUMINT,editdate MEDIUMINT)')

        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Lesson_Control(id TEXT, coursenumber MEDIUMINT, unitnumber MEDIUMINT, lessonID MEDIUMINT,status INT,educatorcode TEXT,creationdate MEDIUMINT,editdate MEDIUMINT)')

        /* Student centric databases */
        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Students (id TEXT, firstname TEXT,lastname TEXT, age INT, bday MEDIUMINT, about MEDIUMTEXT, schoolcode TEXT,phone TEXT,email TEXT,steempost TEXT,code MEDIUMINT,editdate MEDIUMINT)')
        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Student_Assignments (schoolCode TEXT, studentCode MEDIUMINT, lessonID MEDIUMINT, status INT, qaList MEDIUMTEXT, creationdate MEDIUMINT, editdate MEDIUMINT)')
        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Assignment_Notes (schoolCode TEXT, studentCode MEDIUMINT, lessonID MEDIUMINT,teacherCode TEXT,response MEDIUMINT, note MEDIUMTEXT, creationdate MEDIUMINT, editdate MEDIUMINT)')
        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Student_Daily_Review (schoolCode TEXT,studentCode MEDIUMINT,qaList MEDIUMTEXT, date MEDIUMINT )')

        /* Media databases */
        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS Media (schoolCode TEXT,owner TEXT,type TEXT,filename TEXT,hash TEXT,creationdate MEDIUMINT)')
    })
}
