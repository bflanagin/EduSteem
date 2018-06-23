import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import Qt.labs.calendar 1.0

import "../theme"
import "../Educator"
import "./general.js" as Scripts

Item {
    id: thisWindow

    property string userFirstName: ""
    property string userLastName: ""
    property string userEmail: ""
    property string userPhone: ""
    property string userCountry: ""
    property string userState: ""
    property string userid: ""
    property string userAbout: ""

    states: [

        State {
            name: "Active"
            PropertyChanges {

                target: thisWindow
                //opacity: 1
                x:leftMenu.width
            }
        },

        State {
            name: "inActive"
            PropertyChanges {

                target: thisWindow
                //opacity: 0
                x: -parent.width
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
                properties: "x"
                duration: 100
                easing.type: Easing.InOutQuad
            }
        }
    ]

    state: "inActive"

    onUseridChanged: {
        Scripts.loadprofile(userid)
    }

    Rectangle {
        anchors.fill: parent
    }

    Text {
        id: title
        anchors.top: parent.top
        anchors.left: backbutton.right
        anchors.margins: 20
        text: userFirstName + " " + userLastName
        font.bold: true
        font.pointSize: 15
        Image {
            anchors.left: parent.right
            anchors.bottom: parent.bottom
            source: "/icons/edit-text.svg"
            width: parent.height * 0.5
            height: parent.height * 0.5
            fillMode: Image.PreserveAspectFit

            /* MouseArea {
                anchors.fill: parent
                onClicked: {editthis.field = "Title"
                            editthis.where = "lesson"
                            editthis.itemId = lessonNumber
                            editthis.state = "Active" }
            } */
        }
    }

    CircleButton {
        id: backbutton
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 20
        height: title.height
        width: title.height

        MouseArea {
            anchors.fill: parent
            onClicked: {
                thisWindow.state = "inActive"
            }
        }
    }

    Rectangle {
        anchors.top: title.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.95
        height: 3
        color: seperatorColor
    }

    Flickable {
        anchors.top: title.bottom
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.96
        height: parent.height - title.y + title.height
        contentHeight: cColumn.height
        Column {
            id: cColumn
            width: parent.width
            spacing: 5


            Row {
                width:parent.width
                height:imageBlock.height
                ESborder {
                    id:imageBlock
                    width: parent.width * 0.3
                    height: parent.width * 0.3

                    Image {
                        id:profileImage
                        anchors.centerIn: parent
                        width:parent.width * 0.87
                        height:width
                        fillMode: Image.PreserveAspectCrop
                        visible: false
                        source:"../icons/frontC.png"
                    }
                    OpacityMask {
                        source:profileImage
                        anchors.fill:profileImage
                        maskSource:mask
                    }
                }

                ESborder {
                    width: parent.width * 0.7
                    height:contactColumn.height + 20

                    Column {
                        id:contactColumn
                        anchors.horizontalCenter: parent.horizontalCenter
                        width:parent.width * 0.95
                        anchors.centerIn: parent
                        spacing: 8

                        Text {
                            text:"Email: "+userEmail
                        }
                        Text {
                            text:"Phone: "+userPhone
                        }
                        Text {
                            text:userCountry+" , "+userState
                        }
                    }
                }
            }

            ESborder {
                width: parent.width
                height: about.height + aTitle.height + 40

                Text {
                    id:aTitle
                    anchors.top:parent.top
                    anchors.left:parent.left
                    anchors.margins: 10
                    text:"About"
                    font.bold: true
                    font.pointSize: 10
                }

                Rectangle {
                    anchors.top: aTitle.bottom
                    anchors.topMargin: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.95
                    height: 1
                    color: seperatorColor
                }

                Text {

                    id: about
                    anchors.top:aTitle.bottom
                    anchors.left: parent.left
                    anchors.margins: 10
                    text: userAbout
                    width: parent.width * 0.96

                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignLeft
                }

                Image {
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.margins: 10
                    source: "/icons/edit-text.svg"
                    width:24
                    height:24
                    fillMode: Image.PreserveAspectFit

                    /* MouseArea {
                        anchors.fill: parent
                        onClicked: {editthis.field = "Title"
                                    editthis.where = "lesson"
                                    editthis.itemId = lessonNumber
                                    editthis.state = "Active" }
                    } */
                }
            }




        }
    }
}
