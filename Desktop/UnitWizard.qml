import QtQuick 2.11
import QtQuick.Controls 2.2

import "./theme"
import "./plugins"

import "./course.js" as Scripts

ESborder {
    id: thisWindow

    height: cColumn.height * 1.5 + buttonRow.height

    Text {
        id: title
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Unit"
        font.pointSize: 18
    }

    Rectangle {
        anchors.top: title.bottom
        width: parent.width * 0.99
        anchors.horizontalCenter: parent.horizontalCenter
        height: 3
        color: seperatorColor
    }

    Row {
        anchors.centerIn: parent
        anchors.top: title.bottom
        width: parent.width
        height: cColumn.height
        Column {
            id: cColumn

            width: parent.width * 0.50

            spacing: thisWindow.width * 0.02
            Text {
                anchors.left: parent.left
                anchors.leftMargin: 10
                text: qsTr("General Info:")
            }
            TextField {
                id: unitNameBox
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.95
                placeholderText: qsTr("Unit Name")
                background: ESTextField {
                }
            }

            Text {
                anchors.left: parent.left
                anchors.leftMargin: 10
                text: qsTr("Primary Objective:")
            }
            TextArea {
                id: unitObjectiveBox
                anchors.left: parent.left
                anchors.leftMargin: 10
                padding:10
                width: parent.width * 0.96
                wrapMode: Text.WordWrap
                height: 210
                background: ESTextField {
                }
            }
        }

        Column {
            width: parent.width * 0.50
            height: cColumn.height

            Text {
                text: qsTr("About")
            }
            TextArea {
                id: unitAboutBox
                width: parent.width * 0.98
                height: cColumn.height * 0.94
                wrapMode: Text.WordWrap
                background: ESTextField {
                }
            }
        }
    }

    Row {
        id: buttonRow
        anchors.bottomMargin: 10
        anchors.bottom: parent.bottom
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
                Scripts.saveUnit(userid,coursenumber,unitNameBox.text,
                                 unitObjectiveBox.text, unitAboutBox.text, 0)

                thisWindow.state = "inActive"
            }
        }
    }
}
