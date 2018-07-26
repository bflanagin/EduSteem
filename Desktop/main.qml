import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.4
import QtQuick.LocalStorage 2.0 as Sql

import "./General"
import "./Educator"
import "./Student"
import "./theme"
import "./plugins"

import "./General/network.js" as Network

import "./General/general.js" as Standard

Window {
    id: mainView
    visible: true
    width: 1336
    height: 800
    title: qsTr("EduSteem")
    //color: "#F0F0F0"
    color: "black"

    /*App setup Variables */
    property string devId: "Vag-01001011"
    property string appId: "vagEduST-052308"
    property string version: "0.18"

    property string userID: ""
    property var db: Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0",
                                                       "Local UserInfo", 1)

    /*Theme Variables */
    property string seperatorColor: "#5c9dd5"
    property string selectedHighlightColor: "#165098"
    property string highLightColor1: "#165098"
    property string color1: "#F0F0F0"
    property string menuColor: "#3E586F"
    property string submenu: "#6F91AE"

    /* End Theme Variables */

    /* System Wide Variables */
    property var courses: ["8 - P.E.:DarkGreen", "101 - Math:Orange", "201 - Science:Green", "301 - Humanities:LightBlue", "302 - Literature:Brown", "303 - Writing:Black", "304 - Grammar:Red", "305 - Spelling:Brown", "401 - Art", "501 - Music", "601 - Vocational:Pink", "701 - Social Sciences", "801 - Languages Studies", "901 - Projects"]

    property var languages: ["English", "Spanish"]
    property string heart: "Offline"
    property int atype: 0 /* Account Type */
    property int etype: 0 /* Educator Type */

    property string userName: ""
    property string userCode: ""
    property real studentCode: 0
    property int userEditDate: 0
    property string schoolName: ""
    property string schoolCode: ""
    property int schoolEditDate: 0
    property int numberOfStudents: -1
    property int starttime: 8
    property var d: new Date()
    property int theday: d.getDate()
    property int selected_month: d.getMonth()
    property int selected_year: d.getFullYear()
    property int selected_dow: d.getDay()
    property real timeupdate: d.getTime()

    property string steemAccount: "" /* Steem Account name */
    property string steemShareKey: "" /* Steem posting key */

    property string monthselect: switch (d.getMonth()) {
                                 case 0:
                                     "January"
                                     break
                                 case 1:
                                     "Febuary"
                                     break
                                 case 2:
                                     "March"
                                     break
                                 case 3:
                                     "April"
                                     break
                                 case 4:
                                     "May"
                                     break
                                 case 5:
                                     "June"
                                     break
                                 case 6:
                                     "July"
                                     break
                                 case 7:
                                     "August"
                                     break
                                 case 8:
                                     "September"
                                     break
                                 case 9:
                                     "October"
                                     break
                                 case 10:
                                     "November"
                                     break
                                 case 11:
                                     "December"
                                     break
                                 }

    Timer {
        running: true
        repeat: true
        interval: 1000
        onTriggered: timeupdate = timeupdate + 1000
    }

    /* End System Wide Variables */
    Component.onCompleted: {
        Standard.createddbs()

        Standard.loadschool(userID)
    }

    onNumberOfStudentsChanged: if (numberOfStudents == 0) {
                                   login.state = "Active"
                               } else {
                                   slogin.state = "Active"
                               }

    onUserIDChanged: if (userID.length > 2) {
                         Standard.loadschool(userID)
                         Standard.loaduser(userID)
                         if (schoolCode.length > 2) {
                             Network.sync("Courses", schoolCode)
                             Network.sync("Units", schoolCode)
                             Network.sync("Lessons", schoolCode)
                             Network.sync("Students", schoolCode)
                             Network.sync("Schedule", schoolCode)
                         }
                     }

    /* Timed events */
    Timer {
        id: beat
        interval: 1000
        running: true
        repeat: true
        onTriggered: Network.heartbeat()
    }

    Timer {
        id: checkforUpdates
        interval: 4000
        repeat: true
        running: true
        onTriggered: if (schoolCode.length > 2) {
                         console.log("Checking for updates")
                         Network.sync("Courses", schoolCode)
                         Network.sync("Units", schoolCode)
                         Network.sync("Lessons", schoolCode)
                         Network.sync("Students", schoolCode)
                         Network.sync("Schedule", schoolCode)
                         checkforUpdates.interval = 20000
                     }
    }

    /* End Timed Events */

    /* Items to load */
    BackgroundSwitch {
        id: bgSwitch
    }

    LoginStudent {
        id: slogin
        anchors.fill: parent
        state: "inActive"
    }

    Infoblock {
        id: info
        width: 100
        height: 200
        opacity: 0.4
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 5
    }

    Login {
        id: login
        width: 500
        height: 630
        state: "inActive"

        onStateChanged: if (state == "Active") {
                            bgSwitch.op = 0.95
                        } else {
                            bgSwitch.op = 0.2
                        }
    }

    NewAccount {
        id: newAccount
        width: 1000
        height: 650
        state: "inActive"
    }

    SchoolWizard {
        id: schoolSetup
        width: 1000
        height: 650
        state: "inActive"
    }

    EducatorUI {
        id: educatorHome
        width: parent.width
        height: parent.height
        state: "inActive"
    }

    StudentUI {
        id: studentHome
        width: parent.width
        height: parent.height
        state: "inActive"
    }

    LessonView {
        id: lessonView
        width: parent.width
        height: parent.height
        state: "inActive"
    }

    Rectangle {
        anchors.fill: parent
        color:"black"
        opacity: 0.4
        visible: if(popUp.state == "Active") {true} else {false}
    }

    PopUp {
        id:popUp
        state:"inActive"
    }

    /* End Loaded Items */
    Rectangle {
        id: mask
        width: parent.width
        height: parent.width
        radius: width / 2
        visible: false
    }
}
