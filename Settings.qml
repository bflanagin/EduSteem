import QtQuick 2.0
import 'main.js' as Scripts
import 'openseed.js' as OpenSeed

import QtQuick.LocalStorage 2.0 as Sql

Item {
     id:window_container

    states: [

        State {
            name: "Show"

            PropertyChanges {
                target:window_container
                y:parent.height * 0.15

            }

        },

        State {
            name: "Hide"

            PropertyChanges {
                target:window_container
                y:parent.height


            }
        }

    ]

    transitions: [
        Transition {
            from: "Hide"
            to: "Show"
            reversible: true


            NumberAnimation {
                target: window_container
                property: "y"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
    ]

    state:"Hide"

    onStateChanged: if(window_container.state == "Show") {Scripts.childlist(0),Scripts.tasklist(),OpenSeed.accountlist()}


    Image {
        source:"graphics/settingsbg.png"
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width
        height:parent.height
    }


    Text {
        id:title
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:parent.top
        anchors.topMargin: parent.height * 0.02
        text:"Settings"
        font.pixelSize: parent.height * 0.07
    }

    Rectangle {
        id:exit
        anchors.right:parent.right
        anchors.top:parent.top
        anchors.margins: parent.height * 0.03
        width:parent.height * 0.04
        height:parent.height * 0.04
        radius: width /2
        color: "red"
        border.color:"darkred"
        border.width: 4

        Image {

        }

        MouseArea {
            anchors.fill: parent
            onClicked: window_container.state = "Hide"
        }
    }

    Rectangle {
        anchors.top:title.bottom
        anchors.topMargin: parent.height * 0.02
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width * 0.85
        height:parent.height * 0.005
        color:"gray"
    }


    Column {
        anchors.top:title.bottom
        anchors.topMargin:parent.height * 0.025
        //width:parent.width
        height:(parent.height - (title.y + title.height) ) * 0.96

        anchors.right:parent.right
        width:parent.width * 0.95
        spacing:parent.height * 0.03


        Item {
            width:parent.width
            height:window_container.height / 3.5
            Column {
                width:parent.width
                height:window_container.height
                spacing:window_container.height * 0.01
        Text {
            text:"Children"
            font.pixelSize: parent.height * 0.03
        }
        Rectangle {

            width:parent.width * 0.90
            height:window_container.height * 0.005
            color:"gray"
        }

        ListView {
            width:parent.width
            height:window_container.height /4
            spacing: window_container.height * 0.01
            clip:true

            model:ListModel {
                id:childslist
            }

            delegate: Rectangle {
                width:parent.width * 0.90
                height:window_container.height * 0.1
                color:Qt.rgba(0.9,0.9,0.9,0.9)
                border.color: Qt.rgba(0.1,0.1,0.1,0.9)
                radius:5

                Text {
                    anchors.centerIn: parent
                    text:name
                    font.pixelSize: parent.height * 0.6
                }

                MouseArea {
                    anchors.fill:parent
                    onClicked: if(stickerset == "1") {window_container.state = "Hide",addit.type = 0,addit.state = "Show"} else {}
                }
            }


        }


            }
        }
        Item {
            width:parent.width
            height: window_container.height / 3.5
            Column {
                width: parent.width
                height: window_container.height
                spacing:window_container.height * 0.01
        Text {
            text:"Tasks"
            font.pixelSize:  window_container.height * 0.03
        }
        Rectangle {

            width:parent.width * 0.90
            height:parent.height * 0.005
            color:"gray"
        }

        ListView {
            width:parent.width
            height:parent.height /4
            spacing: parent.height * 0.01
            clip:true

            model:ListModel {
                id:taskslist
            }

            delegate: Rectangle {
                width:parent.width * 0.90
                height: window_container.height * 0.1
                color:Qt.rgba(0.9,0.9,0.9,0.9)
                border.color: Qt.rgba(0.1,0.1,0.1,0.9)
                radius:5

                Text {
                    anchors.centerIn: parent
                    text:if(taskname == "1") {"Add New"} else {taskname}
                    font.pixelSize: parent.height * 0.6
                }

                MouseArea {
                    anchors.fill:parent
                    onClicked: if(taskname == "1") {window_container.state = "Hide",addit.type = 1,addit.state = "Show"} else {currenttask = taskname,scheduleit.state = "Show"}
                }
            }


        }


            }

        }

        Item {
            width: parent.width
            height: window_container.height / 3
            Column {
                width: parent.width
                height: window_container.height
                spacing:parent.height * 0.01
        Text {
            text:"Sync Accounts"
            font.pixelSize:  window_container.height * 0.03
        }
        Rectangle {

            width: parent.width * 0.90
            height: window_container.height * 0.005
            color:"gray"
        }

        ListView {
            width:parent.width
            height:parent.height /5.7
            spacing: parent.height * 0.01
            clip:true

            model:ListModel {
                id:accesslist
            }


            delegate: Rectangle {
                width:parent.width * 0.57
                height: window_container.height * 0.1
                color:Qt.rgba(0.9,0.9,0.9,0.9)
                border.color: Qt.rgba(0.1,0.1,0.1,0.9)
                radius:5

                Text {
                    anchors.centerIn: parent
                    text:if(accountname == "1") {"Add New"} else {accountname}
                    font.pixelSize: parent.height * 0.6
                }

                MouseArea {
                    anchors.fill:parent
                    onClicked: if(accountname == "1") {window_container.state = "Hide",openseed_connect.state = "Show"} else {window_container.state = "Hide",
                                                                                                                              id = familyid, Scripts.retrievedata()
                                                                                                                                    }
                }
            }


        }



            }


        }


    }






}

