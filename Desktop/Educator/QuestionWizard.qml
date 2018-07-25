import QtQuick 2.11
import QtQuick.Controls 2.2

import "../theme"
import "../plugins"

import "./course.js" as Scripts

import "../plugins/text.js" as Scrubber

ESborder {
    id: thisWindow
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    height: cColumn.height * 1.5 + buttonRow.height

    property int type: 0

    onStateChanged: if(state == "inActive") {questionBox.text = ""
                                                questionAnswerBox.text = ""}

    Text {
        id: title

        anchors.horizontalCenter: parent.horizontalCenter
        text: "Question"
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
            //anchors.centerIn: parent
            width: if (type == 1) {
                       parent.width * 0.50
                   } else {
                       parent.width
                   }
            //height: parent.height * 0.95
            spacing: thisWindow.width * 0.01
            Text {
                visible: if (type == 1) {
                             true
                         } else {
                             false
                         }
                anchors.left: parent.left
                anchors.leftMargin: 20
                text: qsTr("Question")
            }
            ScrollView {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.95
                height: 200
                background: ESTextField {
                }
                TextArea {
                    id: questionBox
                    width:parent.width
                    wrapMode: Text.WordWrap
                    placeholderText: qsTr("What is happening?")
                    selectByMouse: true

                }
            }
        }

        Column {
            visible: if (type == 1) {
                         true
                     } else {
                         false
                     }
            width: parent.width * 0.50
            height: cColumn.height
            spacing: thisWindow.width * 0.01
            Text {
                anchors.left: parent.left
                anchors.leftMargin: 10
                text: qsTr("Answer")
            }
            ScrollView {
                width: parent.width * 0.98
                height: 200
                background: ESTextField {
                }
                TextArea {
                    id: questionAnswerBox
                    width:parent.width
                    wrapMode: Text.WordWrap
                    placeholderText: qsTr("You're adding a question.")
                    selectByMouse: true
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
                if (type == 0) {

                    guidedQuestions.push(
                                Scrubber.replaceSpecials(
                                    questionBox.text) + ":::" + Scrubber.replaceSpecials(
                                    questionAnswerBox.text))
                    // Scripts.loadQuestions(type)
                } else {

                    reviewQuestions.push(
                                Scrubber.replaceSpecials(
                                    questionBox.text) + ":::" + Scrubber.replaceSpecials(
                                    questionAnswerBox.text))
                    // Scripts.loadQuestions(type)
                }

                thisWindow.state = "inActive"
            }
        }
    }
}
