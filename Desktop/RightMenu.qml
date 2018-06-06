import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
//import QtQuick.Extras 1.4

import "./theme"
import "./plugins"

import "./course.js" as Courses

ESborder {
    id:thisWindow

    states: [

            State {
                name:"Active"

                PropertyChanges {
                    target: thisWindow
                    anchors.rightMargin: 0
                }
        },

        State {
            name:"inActive"

            PropertyChanges {
                target: thisWindow
                anchors.rightMargin: -1 * width
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
                property: "anchors.rightMargin"
                duration: 200
                easing.type: Easing.InOutQuad
            }

        }
    ]



state: "inActive"




    Column {
        anchors.top:parent.top
        anchors.topMargin: 20
        width:parent.width * 0.98
        height:parent.width * 0.95
        spacing: thisWindow.width * 0.01

        Item {
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width * 0.6
            height:parent.width * 0.6

       Dial {
           id:mainDial
            anchors.fill: parent
           from: 0
           to: 100
           value: 50
           visible: false


        Item {
            anchors.fill: parent

            Text {
                width:parent.width * 0.8
                horizontalAlignment: Text.AlignHCenter
                anchors.centerIn: parent
                font.pixelSize: parent.width * 0.2
                text:mainDial.value+"%"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: console.log("nope")
            }
        }
       }

       ColorOverlay {
            source:mainDial
            anchors.fill: mainDial
            color:seperatorColor

       }

        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text:qsTr("Week's Progress")
        }


        ListView {
            width:thisWindow.width * 0.95
            height:contentHeight
            anchors.horizontalCenter: parent.horizontalCenter
            clip:true
            spacing: thisWindow.width * 0.02
            model: 7

            delegate: Item {
                        width:thisWindow.width
                        height:thisWindow.width * 0.13

                        Rectangle {
                            anchors.fill:parent
                            color:if(index % 2) {"#FFFFFF"} else {"#FAFAFA"}
                        }

                        Rectangle {
                            anchors.bottom: parent.bottom
                            height:parent.height * 0.3
                            width: (parent.width * 0.5) * 0.80
                            color:seperatorColor

                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left:parent.left
                                anchors.leftMargin: 5
                                text:dayDial.value
                                font.pixelSize: parent.height * 0.75

                            }
                        }

                    Text {
                        text:switch(index) {
                             case 0: qsTr("Monday");break;
                             case 1: qsTr("Tuesday");break;
                             case 2: qsTr("Wednesday");break;
                             case 3: qsTr("Thursday");break;
                             case 4: qsTr("Friday");break;
                             case 5: qsTr("Saturday");break;
                             case 6: qsTr("Sunday");break;
                             }
                            anchors.left: parent.left
                            anchors.top:parent.top
                            anchors.margins: parent.height * 0.1


                    }

                    Dial {
                        id:dayDial
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right:parent.right
                        anchors.rightMargin: parent.height * 0.5
                        width:parent.height * 0.8
                        height:parent.height * 0.8
                        from: 0
                        to: 100
                        value: 50
                        visible: false

                        handle: Rectangle {
                                    visible: false
                                    }


                     Item {
                         anchors.fill: parent

                         Text {
                             width:parent.width * 0.8
                             horizontalAlignment: Text.AlignHCenter
                             anchors.centerIn: parent
                             font.pixelSize: parent.width * 0.2
                             text:dayDial.value+"%"
                         }

                         MouseArea {
                             anchors.fill: parent
                             onClicked: console.log("nope")
                         }
                     }
                    }

                    ColorOverlay {
                         source:dayDial
                         anchors.fill: dayDial
                         color:seperatorColor
                         antialiasing: true
                    }

            }
        }

       }
}
