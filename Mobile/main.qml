import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls.Material 2.2
import QtQuick.LocalStorage 2.0 as Sql

import "./UI"
import "./Logic/general.js" as Scripts
import "./Logic/network.js" as Network
import "./Logic/db.js" as DB
Window {
    id:mainView
    visible: true
    width:Screen.desktopAvailableWidth
    height:Screen.desktopAvailableHeight

    title: qsTr("eduSteem Mobile")

    Component.onCompleted: {
                            DB.createddbs()
                            Scripts.loadUser(userID)
                            }

    color: "#F0F0F0"

    /*App setup Variables */
    property string devId: "Vag-01001011"
    property string appId: "vagEduST-052308"
    property string version: "0.21"

    property string userID: ""
    property var db: Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0",
                                                       "Local UserInfo", 1)
    property string heart: "Offline"

    /*Theme Variables */
    property string seperatorColor: "#5c9dd5"
    property string selectedHighlightColor: "#165098"
    property string highLightColor1: "#165098"
    property string color1: "#F0F0F0"
    property string menuColor: "#3E586F"
    property string submenu: "#6F91AE"

    /* End Theme Variables */

    property string userName: ""
    property string userCode: ""
    property real userEditDate: 0

    property int atype: 0 /* Account Type */
    property int etype: 0 /* Educator Type */

    property string schoolName: ""
    property string schoolCode: ""
    property real schoolEditDate: 0
    property int numberOfStudents: -1
    property int starttime: 8

    onUserCodeChanged: if(Scripts.checklocal("school") === false ) {
                           schoolAdd.state = "Active"
                       } else {
                           Scripts.loadschool(userID)
                       }
    onSchoolCodeChanged: {
        Network.sync("Courses", schoolCode)
        Network.sync("Units", schoolCode)
        Network.sync("Lessons", schoolCode)
        Network.sync("Students", schoolCode)
        Network.sync("Schedule", schoolCode)
        Network.sync("Media",schoolCode)
        Network.sync("Student_Assignments",schoolCode)
        Network.sync("Lesson_Control",schoolCode)
        Network.sync("Assignment_Notes",schoolCode)
        overView.state = "Active"
        }


    Overview {
        id:overView
        width:parent.width
        height:parent.height
        state:"inActive"
    }

    Login {
        id:login
        width:parent.width * 0.9
        height:parent.height * 0.7
        state: "inActive"
        onStateChanged: if(state === "inActive") {
                            Scripts.loadUser(userID)
                        }
    }

    SchoolAdd {
          id:schoolAdd
          width:parent.width * 0.9
          height:parent.height * 0.7
          state:"inActive"
        }
}
