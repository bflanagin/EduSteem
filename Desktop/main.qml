import QtQuick 2.11
import QtQuick.Window 2.11

Window {
    id:mainView
    visible: true
    width: 1366
    height: 768
    title: qsTr("EduSteem")
    color:"#FFFFFF"

    /*App setup Variables */
   property string devId: ""
    property string appId: ""
    property string version: "0.01"


    /*Theme Variables */

    property string seperatorColor:"#5c9dd5"
    property string selectedHighlightColor:"#165098"


    /* End Theme Variables */


    Component.onCompleted: login.state = "Active"

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
