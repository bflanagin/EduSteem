import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

import "./theme"

ESborder {
    id:thisWindow

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter

    states: [

            State {
                name:"Active"
                    PropertyChanges {

                        target:thisWindow
                        opacity:1
                        anchors.verticalCenterOffset: 0

                    }

                },

        State {
            name:"inActive"
                PropertyChanges {

                    target:thisWindow
                    opacity:0
                    anchors.verticalCenterOffset: parent.height + 500

                }

            }

    ]

    transitions: [
        Transition {
            from: "inActive"
            to: "Active"
            reversible: true

            NumberAnimation {
                target: thisWindow
                properties: "opacity,anchors.verticalCenterOffset"
                duration: 550
                easing.type: Easing.InOutElastic
            }
        }
    ]

    state:"inActive"

    Column {
        anchors.centerIn: parent
        width:parent.width * 0.98
        height:parent.height * 0.98
        spacing: thisWindow.width * 0.01

        Text {
            padding: 10
            text:qsTr("New Account")
            font.pointSize: 20

        }

        Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width:parent.width * 0.98
                    height:5
                    color:seperatorColor
                }

        Row {
            width:parent.width
            height: parent.height * 0.8

            Column {
                //anchors.verticalCenter: parent.verticalCenter
                width:parent.width * 0.48
                padding: 10
                spacing: thisWindow.width * 0.03

                Text {
                    width:parent.width
                    height: thisWindow.height * 0.67
                    wrapMode: Text.WordWrap
                    text:"Account"

                }

                Row {
                    width:parent.width
                    height: thisWindow.height * 0.1
                    spacing: 10

                    Image {
                        id:steemIcon

                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height * 0.9
                        width: parent.height * 0.9
                        fillMode: Image.PreserveAspectFit
                        source:"./img/steem.png"
                    }






                    Image {
                        id:osIcon

                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height * 0.9
                        width: parent.height * 0.9
                        fillMode: Image.PreserveAspectFit
                        source:"./img/OpenSeed.png"
                    }

                   }



            }

            Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        width:2
                        height:parent.height * 0.98
                        color:seperatorColor
                    }

            Column {

                width:parent.width * 0.48
                padding:10
                spacing: thisWindow.width * 0.03
                Text {
                    text:"Info"
                }

                TextField {
                    width:parent.width * 0.98
                    anchors.horizontalCenter: parent.horizontalCenter
                    placeholderText:qsTr("First Name")
                    background:ESTextField{}
                }
                TextField {
                    width:parent.width * 0.98
                    anchors.horizontalCenter: parent.horizontalCenter
                    placeholderText:qsTr("Last Name")
                    background:ESTextField{}
                }
                TextField {
                    width:parent.width * 0.98
                    anchors.horizontalCenter: parent.horizontalCenter
                    placeholderText:qsTr("Email Address")
                    background:ESTextField{}
                }
                TextField {
                    width:parent.width * 0.98
                    anchors.horizontalCenter: parent.horizontalCenter
                    placeholderText:qsTr("Passphase")
                    background:ESTextField{}
                }

            }
        }
    }


}
