import QtQuick 2.4
import QtQuick.Window 2.2
import 'main.js' as Scripts
import 'openseed.js' as OpenSeed


import QtQuick.LocalStorage 2.0 as Sql

Window {
    visible: true

    width:Screen.height /2
    height:Screen.height


    property int currentsticker:1
    property string stickerbook:"stickers1"
    property string childname:"None"

    property string currenttask:""

    property string osaccount:"0"

    property string username: ""
    property string useremail: ""
    property string family: "Default"
    property string currentfamily: ""
    property string id:""
    property string devId:"Vag-01001011"
    property string appId:"vagTKd-0625"

    property string currentdate:""
    property string currentmonth:""




    Chores {
        id:chores
        anchors.fill: parent
    }



    Settings {
        id:thesettings
        anchors.horizontalCenter:parent.horizontalCenter
        width: parent.width * 0.9
        height: parent.height * 0.7
        state:"Hide"
    }

    Adder {
        id:addit
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width * 0.9
        height: parent.height * 0.4
        state:"Hide"
    }

    Scheduler {
        id:scheduleit
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width * 0.9
        height: parent.height * 0.4
        state:"Hide"
    }

    Stickerbook {

        id:thestickerbook
        anchors.horizontalCenter:parent.horizontalCenter
        width: parent.width * 0.9
        height: parent.height * 0.7
        state:"Hide"

    }

    Auth {
        id:openseed_connect
        anchors.horizontalCenter:parent.horizontalCenter
        anchors.verticalCenter:parent.verticalCenter
        width: parent.width * 0.9
        height: parent.height * 0.5
        state:"Hide"
    }

}

