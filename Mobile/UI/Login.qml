import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.LocalStorage 2.0 as Sql

import "../Theme"

import "../Logic/OSAuth.js" as Auth
import "../Logic/general.js" as Scripts
import "../Logic/network.js" as Network

ESborder {
    id: thisWindow
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter

    property bool newaccount: false
    property int uniqueemail: 0
    property int uniquename: 0
    property int uniqueaccount: 0
    property string uniqueid: '0'
    property string message: " "

    Image {
        id: banner
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter

        width: parent.width * 0.90
        fillMode: Image.PreserveAspectFit
        source: "/Img/Banner.png"
        opacity: 1
    }

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: banner.bottom
        anchors.topMargin: -8
        height: parent.height * 0.90
        width: parent.width * 0.98
        spacing: thisWindow.width * 0.05

        Text {
            anchors.horizontalCenter: parent.horizontalCenter

            text: qsTr("User Login")
            color: "gray"
            font.pointSize: 12
            Image {
                anchors.centerIn: parent
                height: parent.height
                width: thisWindow.width * 0.9

                z: -1
                source: "/Img/lines.png"
            }
        }

        TextField {
            id: name
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.95
            placeholderText: qsTr("Name")
            onFocusChanged: Auth.checkcreds("name", text)

            background: ESTextField {
            }
        }
        TextField {
            id: email
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.95
            placeholderText: qsTr("Email Address")
            onFocusChanged: Auth.checkcreds("email", text)
            background: ESTextField {
            }
        }
        TextField {
            id: password
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.95
            placeholderText: qsTr("Passphrase")
            onFocusChanged: if (text.length > 0) {
                                Auth.checkcreds(
                                            "passphrase",
                                            name.text + ":,:" + email.text + ":,:" + password.text)
                            } else {
                                message = "Please Enter Password"
                            }
            echoMode: TextInput.Password
            background: ESTextField {
            }
            onTextChanged: if (text.length > 0) {
                               Auth.checkcreds(
                                           "passphrase",
                                           name.text + ":,:" + email.text + ":,:" + password.text)
                           } else {
                               message = "Please Enter Password"
                           }
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: message
        }

        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Login")
            width: parent.width * 0.50
            height: 50
            enabled: if (userID != '') {
                         true
                     } else {
                         false
                     }
            background: ESTextField {
            }

            onClicked: {
                thisWindow.state = "inActive"
                if (Scripts.checklocal("user") === true) {
                        console.log("Found User")
                        Scripts.loadUser(userID)
                    if (Scripts.checklocal("school") === true) {
                        //educatorHome.state = "Active"
                    } else {
                        console.log("No School Found")
                        schoolAdd.state = "Active"
                    }
                } else {
                    Network.checkESAccount(userID)
                }

            }
        }
    }

}
