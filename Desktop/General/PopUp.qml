import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0


import "../theme"
import "../plugins"
import "../plugins/markdown.js" as Marks



ESborder {
    id:thisWindow
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter

    width:parent.width * 0.40
    height:cColumn.height * 1.1

    Column {
        id:cColumn
        anchors.centerIn: parent
        width:parent.width * 0.98
        spacing: 5

        Rectangle {
            width:parent.width
            height:3
            color:"transparent"
        }

        Text {
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 18
            text:qsTr("Log out?")
        }

        Rectangle {
            width:parent.width
            height:3
            color:seperatorColor
        }

        Text {

            anchors.horizontalCenter: parent.horizontalCenter

            text:qsTr("Are you sure you want to log out?")
        }

        Item {
            width:parent.width
            height:cancelButton.height + 10
            Button {
                id:cancelButton
                text:qsTr("Cancel")
                anchors.left:parent.left
                anchors.leftMargin: 10
                background: ESTextField {}
                onClicked: thisWindow.state = "inActive"

            }

            Button {
                text:qsTr("Okay")
                anchors.right:parent.right
                anchors.rightMargin: 10
                background: ESTextField {}
                onClicked: { thisWindow.state = "inActive"

                        educatorHome.state = "inActive"
                        if(lessonView.state == "inActive") {
                        studentHome.state = "inActive"
                        } else {
                            lessonView.state = "inActive"
                        }

                        slogin.state = "Active"

                }

            }
        }

    }

}
