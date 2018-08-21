import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.LocalStorage 2.0 as Sql

import "../Theme"
import "../Logic/general.js" as Scripts
import "../Logic/network.js" as Network

ESborder {
    id: thisWindow
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter

    Column {
        id: schoolfinder
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: parent.height * -0.1
        width: parent.width * 0.98
        spacing: thisWindow.width * 0.06

        CircleButton {
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.7
            height: width
            icon: "/Icons/icons8-school.svg"
        }

        Text {
            width: parent.width * 0.85
            wrapMode: Text.WordWrap
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            text: if (schoolName.length === 0) {
                      "Searching..."
                  } else {
                      schoolName.replace(/_/g, " ")
                  }
        }

        Rectangle {

            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.95
            height: 3
            color: seperatorColor
        }

        TextField {
            id:codeField
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            width: parent.width * 0.8
            background: ESTextField {
            }
            placeholderText: qsTr("Enter School Code")
            onTextChanged: Network.retrieveFromOpenSeed(text, text, "School")
        }

        Row {
            id: buttonRow
            width: parent.width * 0.98
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: parent.width * 0.39

            Button {

                width: parent.width * 0.30
                background: ESTextField {
                }

                text: qsTr("Cancel")

                onClicked: {
                    thisWindow.state = "inActive"
                }
            }

            Button {

                width: parent.width * 0.30
                background: ESTextField {
                }
                text: qsTr("Okay")

                onClicked: {
                    Network.retrieveFromOpenSeed(codeField.text, codeField.text, "School",false)
                    thisWindow.state = "inActive"
                    Scripts.loadschool(userID)
                }
            }
        }
    }
}
