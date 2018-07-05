import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.LocalStorage 2.0 as Sql
import QtGraphicalEffects 1.0

import "../theme"

import "./OSAuth.js" as Auth
import "./schoolwizard.js" as Scripts
import "./network.js" as Network
import "./general.js" as General

Item {
    id: thisWindow
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter

    property bool newaccount: false
    property int studentname: 0
    property int studentcode: 0
    property string uniqueid: '0'
    property string message: " "

    property double op: 0.8

    states: [

        State {
            name: "Active"

            PropertyChanges {
                target: thisWindow
                opacity: 1
            }      
        },

        State {
            name: "inActive"

            PropertyChanges {
                target: thisWindow
                opacity: 0
            }       
        }
    ]

    state: "inActive"

    transitions: [

        Transition {
            from: "inActive"
            to: "Active"
            reversible: true


            NumberAnimation {
                target: thisWindow
                property: "opacity"
                duration: 400
                easing.type: Easing.InOutQuad
            }


        }

    ]


    ESborder {
        id:loginBlock
        bgOpacity: op
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10

        width: if (parent.width * 0.4 > 600) {
                   600
               } else {
                   parent.width * 0.4
               }

        height: loginColumn.height + 20



      Column {
            id:loginColumn
            width:parent.width * 0.98
            anchors.centerIn: parent
            spacing:10

        Text {
            id:title
            //anchors.bottom:name.top
            anchors.left: parent.left
            anchors.leftMargin: 10
            text:qsTr("Login:")
            font.pointSize: 12
            font.bold: true
        }

        Rectangle {
            width:parent.width * 0.98
            anchors.horizontalCenter: parent.horizontalCenter
            height:3
            color:seperatorColor
        }

        Text {
            anchors.left: parent.left
            anchors.leftMargin: 10
            text:qsTr("Student:")

        }

        TextField {
            id: name
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.01
            horizontalAlignment: Text.AlignLeft
            font.pointSize: 10
            width: parent.width * 0.98
            placeholderText: qsTr("FirstName LastName")
            onTextChanged: studentname = General.studentCred(
                               text.split(" ")[0], text.split(" ")[1], "name")

            background: ESTextField {
            }
        }

        Text {
            anchors.left: parent.left
            anchors.leftMargin: 10
            text:qsTr("Password:")

        }

        TextField {
            id: password
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.01
            horizontalAlignment: Text.AlignLeft
            font.pointSize: 10
            width: parent.width * 0.98
            placeholderText: qsTr("000000")

            background: ESTextField {
            }
            onTextChanged: if (text.length > 0) {
                               studentcode = General.studentCred(text,
                                                                 "", "code")
                           } else {
                               message = "Please Enter Password"
                           }
        }

        Rectangle {
            width:parent.width * 0.98
            anchors.horizontalCenter: parent.horizontalCenter
            height:3
            color:"Transparent"
        }
    }

        Text {
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            text: message
        }

        Button {
            anchors.top: name.bottom
            anchors.topMargin: 60
            anchors.horizontalCenter: parent.horizontalCenter
            visible: if (studentcode == 1 && studentname == 1) {
                         true
                     } else {
                         false
                     }
            text: qsTr("Login")
            width: parent.width * 0.50
            height: 50
            enabled: if (studentcode == 1 && studentname == 1) {
                         true
                     } else {
                         false
                     }
            background: ESTextField {
            }

            onClicked: {
                thisWindow.state = "inActive"
                studentHome.state = "Active"
            }
        }
    }

    ESborder {
        id: timebox
        bgOpacity: 0.7
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.topMargin: 20
        anchors.top: parent.top
        width: time.width + 100
        height: time.height + date.height + 40
        Text {
            id: time
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            color: "black"
            text: new Date(timeupdate).toLocaleTimeString()
            font.pointSize: 24
        }
        Text {
            id: date
            anchors.top: time.bottom
            anchors.right: parent.right
            anchors.margins: 10
            color: "black"
            text: new Date(timeupdate).toLocaleDateString()
            font.pointSize: 12
        }
    }

    Text {
        anchors.bottom:todaysEvents.top
        anchors.bottomMargin: 20
        anchors.left:todaysEvents.left
        text:"Today:"
        font.pointSize: 18
        width:todaysEvents.width
        horizontalAlignment: Text.AlignLeft

        Rectangle {
            anchors.top:parent.bottom
            width: parent.width
            height: 3
            color:seperatorColor
        }
    }

    ListView {
        id: todaysEvents

        height: contentHeight + 20
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        width: parent.width * 0.40
        clip: true
        spacing: 20

        model: DayList {
            day: d.getDate()
            month: d.getMonth()
            weekday: d.getDay()
            educator: "login"
        }

        delegate: ESborder {
            bgOpacity: 0.8
            anchors.right: parent.right
            anchors.rightMargin: -(20 + (index * 20))
            width: todaysEvents.width
            height: classname.height + 20
            Row {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
                width: parent.width * 0.98
                spacing: 10

                Item {
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height * 0.8
                    width: height
                Image {
                    id:icon
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                    source: "/icons/calendar-today.svg"
                }
                ColorOverlay {
                    anchors.fill: icon
                    source:icon
                    color:"black"
                }
                }

                Rectangle {
                    width: 1
                    height: parent.height * 0.99
                    color: seperatorColor
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    id: classname
                    font.pointSize: 18
                    text: name

                    wrapMode: Text.WordWrap
                    maximumLineCount: 1
                    elide: Text.ElideRight
                }
            }
        }
    }

    Text {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.margins: 10
        text: qsTr("Educator Login")
        color: "white"
        MouseArea {
            anchors.fill: parent
            onClicked: {
                thisWindow.state = "inActive"
                login.state = "Active"
            }
        }
    }
}
