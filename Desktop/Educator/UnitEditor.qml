import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.LocalStorage 2.0 as Sql

import "../theme"
import "../plugins"
import "../General"

import "./course.js" as Scripts
import "../plugins/text.js" as Scrubber

ESborder {
    id: thisWindow

    property real unitNumber: 0
    property string unitTitle: "Title"
    property string unitAbout: "About"
    property string unitObjective: "Objective"

    onStateChanged: if (state == "Active") {
                        Scripts.loadUnit(userid, unitNumber)
                    } else {

                    }

    Text {
        id: title
        anchors.top: parent.top
        anchors.left: backbutton.right
        anchors.margins: 20
        text: Scrubber.recoverSpecial(unitTitle)
        font.bold: true
        font.pointSize: 15
        Image {
            anchors.left: parent.right
            anchors.bottom: parent.bottom
            source: "/icons/edit-text.svg"
            width: parent.height * 0.5
            height: parent.height * 0.5
            fillMode: Image.PreserveAspectFit

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    editthis.field = "Title"
                    editthis.where = "unit"
                    editthis.itemId = unitNumber
                    editthis.state = "Active"
                }
            }
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

    Row {
        anchors.top: title.bottom
        anchors.topMargin: 24
        width: parent.width
        height: parent.height - (title.height + 20)
        spacing: thisWindow.width * 0.01
        clip: true

        Flickable {
            width: thisWindow.width * 0.50
            height: parent.height * 0.95
            contentHeight: infoColumn.height + 100
            clip: true

            Column {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 20
                id: infoColumn
                width: thisWindow.width * 0.50
                spacing: thisWindow.width * 0.01

                ESborder {
                    width: parent.width * 0.95
                    height: objectiveColumn.height + 64

                    Column {
                        id: objectiveColumn
                        width: parent.width
                        anchors.top:parent.top
                        anchors.topMargin: 10
                        padding:10
                        spacing: thisWindow.width * 0.01

                        Text {
                            anchors.left: parent.left
                            anchors.margins: 10
                            text: qsTr("Objective:")
                        }

                        Rectangle {

                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.95
                            height: 1
                            color: seperatorColor
                        }

                        MarkDown {
                            id: objText
                            //padding: 10
                            thedata: Scrubber.recoverSpecial(unitObjective)
                            width: parent.width
                            // wrapMode: Text.WordWrap
                        }
                    }
                    Image {
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.margins: 10
                        source: "/icons/edit-text.svg"
                        width: 24
                        height: 24
                        fillMode: Image.PreserveAspectFit

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                editthis.field = "Objective"
                                editthis.where = "unit"
                                editthis.itemId = unitNumber
                                editthis.state = "Active"
                            }
                        }
                    }
                }

                ESborder {
                    width: parent.width * 0.95
                    height: aboutColumn.height + 50

                    Column {
                        id: aboutColumn
                        width: parent.width
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.margins: 10
                        spacing: thisWindow.width * 0.01

                        Text {
                            anchors.left: parent.left
                            anchors.margins: 10
                            text: qsTr("About:")
                        }
                        Rectangle {

                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.95
                            height: 1
                            color: seperatorColor
                        }

                        MarkDown {
                            id: aboutText

                            //padding: 10
                            thedata: Scrubber.recoverSpecial(unitAbout)
                            width: parent.width * 0.98
                            //wrapMode: Text.WordWrap
                        }
                    }
                    Image {
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.margins: 10
                        source: "/icons/edit-text.svg"
                        width: 24
                        height: 24
                        fillMode: Image.PreserveAspectFit

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                editthis.field = "About"
                                editthis.where = "unit"
                                editthis.itemId = unitNumber
                                editthis.state = "Active"
                            }
                        }
                    }
                }
            }
        }

        Column {
            id: lessonsColumn

            width: thisWindow.width * 0.46
            spacing: thisWindow.width * 0.01

            Item {
                width: parent.width
                height: lessonsTitle.height
                Text {
                    id: lessonsTitle
                    anchors.left: parent.left
                    text: qsTr("Lessons")
                    font.bold: true
                    font.pointSize: 12
                }

                Button {
                    anchors.right: parent.right
                    text: qsTr("Add")
                    background: ESTextField {
                    }

                    onClicked: {
                        newPlan.state = "Active"
                    }
                }
            }

            Rectangle {

                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.95
                height: 1
                color: seperatorColor
            }

            ListView {
                id: lessons
                height: contentHeight * 1.04
                width: parent.width * 0.98
                spacing: thisWindow.height * 0.02
                clip: true

                model: lessonList

                delegate: ESborder {
                    width: thisWindow.width * 0.45
                    height: lessonColumn.height * 1.02

                    Column {
                        id: lessonColumn
                        width: parent.width * 0.99
                        spacing: thisWindow.height * 0.01

                        anchors.centerIn: parent

                        Text {
                            text: Scrubber.recoverSpecial(name)
                            padding: 10
                        }

                        Rectangle {

                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.95
                            height: 1
                            color: seperatorColor
                        }

                        MarkDown {
                            thedata: Scrubber.recoverSpecial(about)
                            width: parent.width * 0.80
                            // wrapMode: Text.WordWrap
                            //padding: 10
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            lessonView.lessonNumber = cdate
                            lessonView.state = "Active"
                        }
                    }
                }
            }
        }
    }

    LessonPlanWizard {
        id: newPlan
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: 1000
        height: 650
        state: "inActive"
        onStateChanged: if (state == "inActive") {
                            Scripts.loadLessons(userid, unitNumber)
                        }
    }

    LessonPlanEditor {
        id: lessonView
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        height: parent.height
        state: "inActive"
    }

    FieldEdit {
        id: editthis
        width: parent.width
        height:parent.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        state: "inActive"
        onStateChanged: if (state == "inActive") {
                            Scripts.loadUnit(userid, unitNumber)
                        }
    }

    CDBUnit {
        id: lessonList
        thedate: unitNumber
    }
}
