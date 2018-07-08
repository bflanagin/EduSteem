import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import Qt.labs.calendar 1.0

import "../theme"
import "../Educator"
import "./general.js" as Scripts
import "../plugins"

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
                x: 0
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
                rightMenu.state = "inActive"
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
        contentHeight: cColumn.height + 200
        clip: true

        Column {
            id: cColumn
            width: parent.width
            spacing: 5

            Row {
                width: parent.width
                height: imageBlock.height
                ESborder {
                    id: imageBlock
                    width: if(parent.width * 0.3 >= 300) {300} else {parent.width * 0.3}
                    height: width

                    Image {
                        id: profileImage
                        anchors.centerIn: parent
                        width: parent.width * 0.87
                        height: width
                        fillMode: Image.PreserveAspectCrop
                        visible: false
                        source: "../icons/frontC.png"
                    }
                    OpacityMask {
                        source: profileImage
                        anchors.fill: profileImage
                        maskSource: mask
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: files.visible = true
                    }
                }

                ESborder {
                    width: parent.width - imageBlock.width
                    height: contactColumn.height + 20

                    Column {
                        id: contactColumn
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width * 0.95
                        anchors.centerIn: parent
                        spacing: 8

                        Text {
                            text: "Email: " + userEmail
                        }
                        Text {
                            text: "Phone: " + userPhone
                        }
                        Text {
                            text: userCountry + " , " + userState
                        }
                    }
                }
            }

            ESborder {
                width: parent.width
                height: aboutColumn.height + 20

                Column {
                    id:aboutColumn
                    anchors.top:parent.top
                    anchors.topMargin: 10
                    width:parent.width * 0.98
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing:3

                Text {
                    id: aTitle
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    text: "About"
                    font.bold: true
                    font.pointSize: 10
                }

                Rectangle {

                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.95
                    height: 1
                    color: seperatorColor
                }

                Text {

                    id: about

                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    text: userAbout
                    width: parent.width * 0.99
                    anchors.horizontalCenter: parent.horizontalCenter

                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignLeft
                }

                Image {
                    anchors.right: parent.right
                    anchors.leftMargin: 10
                    source: "/icons/edit-text.svg"
                    width: 24
                    height: 24
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

            ESborder {
                width: parent.width
                height: steemColumn.height + 40

                Column {
                    id: steemColumn
                    anchors.centerIn: parent
                    width: parent.width * 0.96
                    spacing: 10

                    Item {
                        width: parent.width
                        height: asTitle.height

                        Text {
                            id: asTitle

                            text: "Steem Settings"
                            font.bold: true
                            font.pointSize: 10
                        }

                        Image {
                            source: "../img/steem.png"
                            height: asTitle.height * 1.1
                            width: asTitle.height * 1.1
                            anchors.right: parent.right
                            anchors.rightMargin: 10
                        }
                    }

                    Rectangle {

                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width * 0.95
                        height: 1
                        color: seperatorColor
                    }

                    Text {
                        text: "Account"
                        font.bold: true
                        font.pointSize: 8
                    }

                    TextField {
                        id: steemId
                        width: parent.width * 0.96
                        anchors.horizontalCenter: parent.horizontalCenter
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignLeft
                        background: ESTextField {
                        }
                        text: if (steemAccount.length != 0) {
                                  steemAccount
                              } else {
                                  ""
                              }
                    }
                    Text {
                        text: "Share Token (Private)"
                        font.bold: true
                        font.pointSize: 8
                    }
                    TextField {
                        id: steemShareToken
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width * 0.96
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignLeft
                        background: ESTextField {
                        }
                        echoMode: TextInput.Password
                        text: if (steemShareKey.length != 0) {
                                  steemShareKey
                              } else {
                                  ""
                              }
                    }

                    Button {
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        background: ESTextField {
                        }
                        text: qsTr("Save")
                        onClicked: {
                            Scripts.saveSteem(userid, 0, steemId.text,
                                              steemShareToken.text, "")
                        }
                    }
                }
            }
        }
    }

    Files {
        id:files
    }
}
