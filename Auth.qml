import QtQuick 2.4
import QtQuick.Controls 1.2
import "main.js" as Scripts
import "openseed.js" as OpenSeed

import QtQuick.LocalStorage 2.0 as Sql



Rectangle {

    id:popup
    color:"white"
    border.color:"gray"
    border.width:10
    radius:8

    states: [
        State {
            name: "Show"
            PropertyChanges {
                target:popup
                visible:true
            }
        },
        State {
            name: "Hide"
            PropertyChanges {
                    target:popup
                    visible:false
            }
        }


    ]
    state:"Hide"

    Image {
        anchors.fill:parent
        source:"graphics/OpenSeed.png"
        opacity:0.08
        fillMode:Image.PreserveAspectFit
    }

    Column {
        anchors.verticalCenter: parent.verticalCenter
        width:parent.width

        spacing:13

        Text {
            text:"OpenSeed Connect"
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: parent.width * 0.07
        }

        Rectangle {
            width:parent.width * 0.90
            height:parent.height * 0.01
            color:"lightgray"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text:"Creating a sync account will allow you to use multiple devices, or to have multiple users accessing the same tasks."
            width:parent.width * 0.90
            wrapMode: Text.WordWrap
            x:parent.width * 0.05
            //font.pixelSize: parent.width * 0.05
        }

        Rectangle {
            width:parent.width * 0.90
            height:parent.height * 0.01
            color:"lightgray"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text:"Family Name"
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: parent.width * 0.03
        }

        TextField {
            anchors.horizontalCenter: parent.horizontalCenter
            id:familynametext
            width:parent.width * 0.80
            text:family
            onTextChanged: family = text

        }

        Text {
            text:"User Name"
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: parent.width * 0.03
        }

        TextField {
            anchors.horizontalCenter: parent.horizontalCenter
            id:usernametext
            width:parent.width * 0.80
            text:username
            onTextChanged: username = text

        }

        Text {
            text:"Email Address"
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: parent.width * 0.03
        }

        TextField {
            anchors.horizontalCenter: parent.horizontalCenter
            id:emailnametext
            width:parent.width * 0.80
            text:useremail
            onTextChanged: useremail = text
        }

    }

    Rectangle {
        id:okay
        anchors.right:parent.right
        anchors.bottom:parent.bottom
        anchors.margins: 20
        width:parent.width * 0.20
        height:parent.height * 0.10
        border.color:"lightgray"
        radius:8

        Text {
            id:okaytext
            text:"Okay"
            font.pixelSize: parent.height / 2
            anchors.centerIn: parent
        }
        MouseArea {
            anchors.fill:parent
            hoverEnabled: true
            onEntered: okay.color = "gray",okaytext.color = "white"
            onExited: okay.color = "white",okaytext.color = "black"
            onClicked: if(username.length > 2 && useremail.length > 2) {OpenSeed.oseed_auth(username,useremail),popup.state = "Hide"}
        }
    }

    Rectangle {
        id:cancel
        anchors.left:parent.left
        anchors.bottom:parent.bottom
        anchors.margins: 20
        width:canceltext.width
        height:parent.height * 0.10
        border.color:"lightgray"
        radius:8

        Text {
            id:canceltext
            text:"Cancel"
            font.pixelSize: parent.height / 2
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill:parent
            hoverEnabled: true
            onEntered: cancel.color = "gray",canceltext.color = "white"
            onExited: cancel.color = "white",canceltext.color = "black"
            onClicked: popup.state = "Hide"
        }
    }
}
