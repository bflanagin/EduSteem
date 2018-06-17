import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.LocalStorage 2.0 as Sql

import "../theme"
import "../Educator/students.js" as Scripts

ESborder {
        id:thisWindow

        height:cColumn.height * 1.05

        Column {
            anchors.top:parent.top
            anchors.topMargin: 10
            id:cColumn

            width:parent.width
            spacing: parent.width * 0.02

            Text {
                anchors.left:parent.left
                anchors.leftMargin: 10
                text:qsTr("New Student")
                font.pointSize: 20

            }
            Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width:parent.width * 0.94
                        height:4
                        color:seperatorColor
                    }

            TextField {
                id:firstNameBox
                width:parent.width * 0.95
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: qsTr("First Name")
                background: ESTextField{}

            }
            TextField {
                id:lastNameBox
                width:parent.width * 0.95
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: qsTr("Last Name")
                background: ESTextField{}

            }
            TextField {
                id:ageBox
                width:parent.width * 0.15
                anchors.left:parent.left
                anchors.leftMargin: 20
                placeholderText: qsTr("Age")
                background: ESTextField{}

            }
            Text {
                anchors.left:parent.left
                anchors.leftMargin: 10
                width:parent.width
                text:qsTr("Micro scholarships are handled through the Steem. We use the post token of a valid account to send post to the network.")
                wrapMode: Text.WordWrap
                font.pointSize: 8
            }

            TextField {
                id:steemPostToken
                width:parent.width * 0.95
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: qsTr("Steem Post Token")
                background: ESTextField{}
            }

            Text {
                anchors.left:parent.left
                anchors.leftMargin: 10
                text:qsTr("School:")
                font.bold: true
            }
            TextField {
                id:schoolID
                width:parent.width * 0.95
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: qsTr("School ID")
                background: ESTextField{}
                text:if(schoolCode.length > 2) {schoolCode}

            }


            Text {
                anchors.left:parent.left
                anchors.leftMargin: 10
                text:qsTr("Optional:")
                font.bold: true
            }

            TextField {
                id:contactNumber
                width:parent.width * 0.95
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: qsTr("Contact Number")
                background: ESTextField{}
            }

            TextField {
                id:emailAddress
                width:parent.width * 0.95
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: qsTr("Email Address")
                background: ESTextField{}
            }

            Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width:parent.width * 0.94
                        height:1
                        color:seperatorColor
                    }

            Row {
                id:buttonRow
                width:parent.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: parent.width * 0.39
            Button {

                width: parent.width * 0.30
                background: ESTextField{}

                text:qsTr("Cancel")

                onClicked: {thisWindow.state = "inActive"}
            }

            Button {

                width: parent.width * 0.30
                background: ESTextField{}
                text:qsTr("Okay")

                onClicked: {
                        Scripts.saveStudent(userid,firstNameBox.text,lastNameBox.text,ageBox.text,schoolID.text,contactNumber.text,emailAddress.text,steemPostToken.text)
                    thisWindow.state = "inActive"}
            }

            }

        }



}
