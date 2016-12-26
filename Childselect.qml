import QtQuick 2.0
import 'main.js' as Scripts

import QtQuick.LocalStorage 2.0 as Sql

Item {
     id:window_container

    states: [

        State {
            name: "Show"

            PropertyChanges {
                target:window_container
                y:parent.height * 0.14

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

    onStateChanged: if(window_container.state == "Show") {Scripts.childlist(4)}


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
        anchors.topMargin: parent.height * 0.03
        text:"Child Select"
        font.pixelSize: parent.height * 0.07
    }

    Rectangle {
        anchors.top:title.bottom
        anchors.topMargin: parent.height * 0.02
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width * 0.85
        height:parent.height * 0.005
        color:"gray"
    }


    ListView {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:title.bottom
        anchors.topMargin:parent.height * 0.03
        width:parent.width * 0.92
        height:parent.height * 0.65
        spacing:parent.height * 0.01
        clip:true

        model:ListModel {
            id:childslist
        }

        delegate:Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width * 0.98
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
                onClicked:window_container.state = "Hide",childname = name,
                            updateassignment.running = "true"


            }
        }


    }



}

