import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.LocalStorage 2.0 as Sql

import "./theme"

import "./OSAuth.js" as Auth

ESborder {
    id:thisWindow
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter

    property bool newaccount: false
     property int uniqueemail: 0
     property int uniquename: 0
     property int uniqueaccount: 0
     property string uniqueid: '0'
     property string message: " "


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
                duration: 700
                easing.type: Easing.InOutElastic
            }
        }
    ]

    state:"inActive"

    Image {
        id:banner
        anchors.top:parent.top
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter

        width:parent.width * 0.90
        fillMode: Image.PreserveAspectFit
        source:"./img/Banner.png"
        opacity: 1

    }

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:banner.bottom
        anchors.topMargin: -5
        height:parent.height * 0.94
        width:parent.width * 0.98
        spacing: thisWindow.width * 0.08

        Text {
            anchors.horizontalCenter: parent.horizontalCenter

            text:qsTr("User Login")
            color:"gray"
            font.pointSize: 12
            Image {
                anchors.centerIn: parent
                height: parent.height
                width:thisWindow.width * 0.9
                //fillMode: Image.PreserveAspectFit
                z:-1
                source: "./img/lines.png"
            }
        }

       /* Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width * 0.94
            height:10
            color:seperatorColor
        } */





        TextField {
            id:name
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width * 0.95
            placeholderText: qsTr("Name")
            onFocusChanged: Auth.checkcreds("name",text)

            background: ESTextField{}

        }
        TextField {
             id:email
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width * 0.95
            placeholderText: qsTr("Email Address")
            onFocusChanged: Auth.checkcreds("email",text)
            background: ESTextField{}

        }
        TextField {
            id:password
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width * 0.95
            placeholderText: qsTr("Passphrase")
            onFocusChanged: if(text.length > 0) {Auth.checkcreds("passphrase",name.text+":,:"+email.text+":,:"+password.text);} else {message = "Please Enter Password"}
            echoMode:TextInput.Password
            background: ESTextField{}
            onTextChanged: if(text.length > 0) {Auth.checkcreds("passphrase",name.text+":,:"+email.text+":,:"+password.text);}  else {message = "Please Enter Password" }

        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text:message
        }

        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text:qsTr("Login")
            width:parent.width * 0.50
            height:50

            background: ESTextField{}

            onClicked: {thisWindow.state = "inActive"
                        educatorHome.state = "Active"
                        }

        }
    }

    Text {
        anchors.bottom:parent.bottom
        anchors.left:parent.left
        anchors.margins: 10
        text:qsTr("Create Account")
        color:selectedHighlightColor

        MouseArea {
            anchors.fill: parent
            onClicked: {
                        newAccount.state = "Active"
                        login.state = "inActive"
                        }
        }
    }



}
