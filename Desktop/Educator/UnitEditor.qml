import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.LocalStorage 2.0 as Sql

import "../theme"
import "../plugins"
import "../General"

import "../Educator/course.js" as Courses
import "../plugins/text.js" as Scrubber

ESborder {
    id: thisWindow

    property real unitNumber: 0
    property string unitTitle: "Title"
    property string unitAbout: "About"
    property string unitObjective: "Objective"
    clip:true

    onStateChanged: if (state == "Active") {
                        Courses.loadUnit(userID, unitNumber)
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

        ScrollView {
            width: thisWindow.width * 0.50
            height: parent.height - topBar.height * 0.95
            contentHeight: infoColumn.height + 100
            contentWidth: width
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
                            font.bold: true
                        }

                        Rectangle {

                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.95
                            height: 1
                            color: seperatorColor
                        }

                        MarkDown {
                            id: objText
                            thedata: Scrubber.recoverSpecial(unitObjective)
                            width: parent.width * 0.98

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
                            font.bold: true
                        }
                        Rectangle {

                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.95
                            height: 1
                            color: seperatorColor
                        }

                        MarkDown {
                            id: aboutText
                            thedata: Scrubber.recoverSpecial(unitAbout)
                            width: parent.width * 0.98

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

        Item {
            width: thisWindow.width * 0.46
            height:parent.height
        Column {
            id: lessonsColumn
            width:parent.width
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

        }

            ListView {
                id: lessons
                anchors.top:lessonsColumn.bottom
                anchors.bottom:parent.bottom
                anchors.bottomMargin: parent.height * 0.05
                anchors.left:lessonsColumn.left
                width: parent.width
                spacing: thisWindow.height * 0.02
                clip: true

                ScrollIndicator.vertical: ScrollIndicator {}

                model: lessonList

                delegate: ESborder {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: thisWindow.width * 0.44
                    height: lessonColumn.height * 1.02

                    Rectangle {
                        anchors.right:parent.right
                        anchors.top:parent.top
                        anchors.margins: 10
                        width:if(parent.height * 0.5 > 32) {32} else {parent.height * 0.5}
                        height:width
                        radius: width /2
                        color:highLightColor1

                        Text {
                            anchors.centerIn: parent
                            width:parent.width
                            text:duration
                            color:"white"
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    Column {
                        id: lessonColumn
                        width: parent.width * 0.90
                        spacing: thisWindow.height * 0.01

                        anchors.centerIn: parent

                        Text {
                            text: Scrubber.recoverSpecial(name)
                            padding: 10
                            font.bold: true
                            width:parent.width
                            wrapMode: Text.WordWrap
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

                        }
                    }

                    Row {
                        id:actions
                        anchors.bottom:parent.bottom
                        anchors.right:parent.right
                        anchors.margins: 10

                        height:24
                        spacing: height / 2

                        CircleButton {
                            icon:"../icons/edit.svg"
                            height:parent.height
                            width:height

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    lessonEdit.lessonNumber = cdate
                                    lessonEdit.state = "Active"
                                }
                            }

                        }
                        CircleButton {
                            icon:"../icons/copy.svg"
                            height:parent.height
                            width:height

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    Courses.lessonCopy(unitNumber,cdate)
                                }
                            }
                        }
                        CircleButton {
                            icon:"../icons/trash.svg"
                            height:parent.height
                            width:height

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    Courses.lessonDelete(unitNumber,cdate)
                                }
                            }
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
        width:parent.width
        height: parent.height
        state: "inActive"
        onStateChanged: if (state == "inActive") {
                            Courses.loadLessons(userID, unitNumber)
                        }
    }

    LessonPlanEditor {
        id: lessonEdit
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        height: parent.height
        state: "inActive"
        onStateChanged: if (state == "inActive") {
                            Courses.loadLessons(userID, unitNumber)
                        }
    }

    FieldEdit {
        id: editthis
        width: parent.width
        height:parent.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        state: "inActive"
        onStateChanged: if (state == "inActive") {
                            Courses.loadUnit(userID, unitNumber)
                        }
    }

    CDBUnit {
        id: lessonList
        thedate: unitNumber
    }
}
