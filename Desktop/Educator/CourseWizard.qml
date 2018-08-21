import QtQuick 2.11
import QtQuick.Controls 2.2

import "../theme"
import "../plugins"

import "./course.js" as Scripts
import "../plugins/text.js" as Scrubber
import "../General/general.js" as General


ESborder {
    id: thisWindow
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    height: cColumn.height * 1.5 + buttonRow.height

    onStateChanged: if (state == "inActive") {
                        courseNameBox.text = " "
                        courseAboutBox.text = " "
                    } else {
                        General.load_Subjects()
                    }

    Text {
        id: title
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Course"
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
            width: parent.width * 0.50
            //height: parent.height * 0.95
            spacing: thisWindow.width * 0.04
            Text {
                anchors.left: parent.left
                anchors.leftMargin: 10
                text: qsTr("General Info:")
            }
            TextField {
                id: courseNameBox
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.95
                placeholderText: qsTr("Course Name")
                background: ESTextField {
                }
            }

            Row {
                width: parent.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: parent.width * 0.02
                Text {
                    text: "Subject"
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width * 0.49
                }

                Text {
                    text: "Primary language"
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width * 0.49
                }
            }

            Row {
                width: parent.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: parent.width * 0.02
                ComboBox {
                    id: coursesBox
                    property int value: 0
                    width: parent.width * 0.49
                    model: subjects

                    background: ESTextField {
                    }


                    delegate: ItemDelegate {
                                           Text {
                                               text: value + " - " + name
                                           }
                                           MouseArea {
                                               anchors.fill: parent
                                               onClicked: {
                                                   coursesBox.displayText = value + " - " + name
                                                   coursesBox.popup.close()
                                                   coursesBox.value = value
                                               }
                                           }
                                       }

                }

                ComboBox {
                    id: languageBox
                    width: parent.width * 0.49
                    model: languages

                    background: ESTextField {
                    }
                }
            }
        }

        Column {
            width: parent.width * 0.50
            height: cColumn.height

            Text {
                text: qsTr("About")
            }

            ScrollView {
                width: parent.width * 0.98
                height: cColumn.height * 0.98
                background: ESTextField {
                }
                TextArea {
                    id: courseAboutBox
                    width: cColumn.width * 0.50
                    height: cColumn.height * 0.98
                    wrapMode: Text.WordWrap
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

                 Scripts.saveCourse(
                            userID,
                            Scrubber.replaceSpecials(courseNameBox.text),
                            coursesBox.value, languageBox.currentText,
                            Scrubber.replaceSpecials(courseAboutBox.text), 0)
                thisWindow.state = "inActive"
            }
        }
    }

    ListModel {
        id: subjects
    }
}
