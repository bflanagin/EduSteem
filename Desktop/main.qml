import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.LocalStorage 2.0 as Sql
import "network.js" as Network


Window {
    id:mainView
    visible: true
    width: 1366
    height: 768
    title: qsTr("EduSteem")
    color:"#FFFFFF"

    /*App setup Variables */
    property string devId: "Vag-01001011"
    property string appId: "vagEduST-052308"
    property string version: "0.01"

    property string userid:""
    property var db: Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);



    /*Theme Variables */

    property string seperatorColor:"#5c9dd5"
    property string selectedHighlightColor:"#165098"
    property string highLightColor1:"#165098"


    /* End Theme Variables */


    /* System Wide Variables */

    property var courses: ["101 - Math","201 - Science","301 - Humanities", "302 - Literature", "303 - Writing", "304 - Grammar", "401 - Art", "501 - Music","601 - Vocational", "601 - Projects"]

    property var languages: ["English","Spainish"]
    property string heart: "Offline"
    property int atype: 0 /* Account Type */
    property int etype: 0 /* Educator Type */

    /* End System Wide Variables */





    Component.onCompleted: login.state = "Active"



    /* Timed events */

    Timer {
        id:beat
        interval: 1000
        running: true
        repeat: true
        onTriggered: Network.heartbeat()
    }


    /* End Timed Events */

    /* Items to load */

    Infoblock {
        id:info
        width:100
        height: 200
        opacity: 0.4
        anchors.top:parent.top
        anchors.left:parent.left
        anchors.margins: 5
    }

    Login {
        id:login
        width:500
        height:630
        state:"inActive"
    }

    NewAccount {
        id:newAccount
        width:1000
        height: 650
        state:"inActive"
    }

    SchoolWizard {
        id:schoolSetup
        width:1000
        height: 650
        state:"inActive"
    }

    EducatorUI {
        id:educatorHome
        width:parent.width
        height:parent.height
        state:"inActive"
    }


    /* End Loaded Items */




    Image {
        anchors.bottom:parent.bottom
        anchors.right:parent.right
        anchors.margins: 8
        width:256
        fillMode: Image.PreserveAspectFit
        source:"./img/Banner.png"
        opacity: 1
        z:-1

    }

    Text {
        anchors.bottom:parent.bottom
        anchors.right:parent.right
        text:qsTr("Version: ")+version
        anchors.margins: 2
        color:"gray"
        z:-1
    }


}
