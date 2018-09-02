import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.LocalStorage 2.0 as Sql

import "../theme"
import "../plugins"
import "../General"
import "../Templates"

import "../Educator/course.js" as Courses
import "../plugins/text.js" as Scrubber

ESborder {
    id: thisWindow
    clip: true

    property real lessonNumber: 0
    property string lessonTitle: "Title"
    property string lessonAbout: "About"
    property string lessonObjective: "Objective"
    property string lessonAuthor: ""
    property string lessonDate: ""
    property int lessonOrder: 0
    property int lessonDuration: 0
    property string lessonResources: ""
    property string lessonSupplies: ""
    property string lessonSequence: ""
    property string lessonGQ: ""
    property string lessonRQ: ""
    property string lessonSP: ""

    property int lessonStatus:0

    property int lessonPublished: 0

    onStateChanged: if (state == "Active") {
                        Courses.loadLesson(userID, lessonNumber)
                    } else {

                    }
    onLessonNumberChanged: {
        Courses.loadLesson(userID, lessonNumber)
    }

    Text {
        id: title
        anchors.top: parent.top
        anchors.left: backbutton.right
        anchors.margins: 20
        text: Scrubber.recoverSpecial(lessonTitle)
        font.bold: true
        font.pointSize: 15
        width: parent.width * 0.75
        wrapMode: Text.WordWrap
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
                    editthis.where = "lesson"
                    editthis.itemId = lessonNumber
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

    Button {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 20
        text: qsTr("Lesson View")
        background: ESTextField {
        }
        onClicked: {
            lessonView.lessonID = thisWindow.lessonNumber
            lessonView.state = "Active"
        }
    }

    Item {
        id: lessonInfo
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: title.bottom
        anchors.topMargin: 16
        width: parent.width * 0.95
        height: 70

        Text {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: 10
            text: qsTr("Author: ") + lessonAuthor
        }
        Text {
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.margins: 10
            text: qsTr("Date Created: ") + lessonDate
        }

        Text {
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: 10
            text: qsTr("Lesson Number: ") + lessonOrder
        }
        Text {
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: 10
            text: qsTr("Duration: ") + lessonDuration + qsTr(" minutes")
        }

        Rectangle {
            anchors.bottom: parent.bottom

            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: 3
            color: seperatorColor
        }
    }

    Flickable {
        anchors.top: lessonInfo.bottom
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        width: parent.width
        contentHeight: planColumn.height + 100
        clip: true

        Column {
            id: planColumn
            width: parent.width * 0.98
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: thisWindow.width * 0.01

            ESborder {
                width: parent.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter
                height: aboutColumn.height + 64

                Column {
                    id: aboutColumn
                    width: parent.width * 0.99
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    padding: 10
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
                        thedata: Scrubber.recoverSpecial(lessonAbout)
                        width: parent.width
                    }
                }
                Image {
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.margins: 15
                    source: "/icons/edit-text.svg"
                    width: 24
                    height: 24
                    fillMode: Image.PreserveAspectFit

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            editthis.field = "About"
                            editthis.where = "lesson"
                            editthis.itemId = lessonNumber
                            editthis.state = "Active"
                        }
                    }
                }
            }

            ESborder {
                width: parent.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter
                height: objectiveColumn.height + 64

                Column {
                    id: objectiveColumn
                    width: parent.width * 0.99
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    padding: 10
                    spacing: thisWindow.width * 0.01

                    Text {
                        anchors.left: parent.left
                        anchors.leftMargin: 10
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
                        thedata: Scrubber.recoverSpecial(lessonObjective)
                        width: parent.width
                    }
                }
                Image {
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.margins: 15
                    source: "/icons/edit-text.svg"
                    width: 24
                    height: 24
                    fillMode: Image.PreserveAspectFit

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            editthis.field = "Objective"
                            editthis.where = "lesson"
                            editthis.itemId = lessonNumber
                            editthis.state = "Active"
                        }
                    }
                }
            }

            Row {
                width: parent.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: thisWindow.width * 0.02

                ESborder {
                    width: parent.width * 0.49
                    height: suppliesColumn.height + 32

                    Column {
                        id: suppliesColumn
                        width: parent.width
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        padding: 10

                        spacing: thisWindow.width * 0.01

                        Text {
                            anchors.left: parent.left
                            anchors.margins: 10
                            text: qsTr("Supplies:")
                            font.bold: true
                        }
                        Rectangle {

                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.95
                            height: 1
                            color: seperatorColor
                        }

                        MarkDown {
                            id: supplyText
                            width: parent.width
                            thedata: Scrubber.recoverSpecial(lessonSupplies)
                        }
                    }
                    Image {
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.margins: 15
                        source: "/icons/edit-text.svg"
                        width: 24
                        height: 24
                        fillMode: Image.PreserveAspectFit

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                editthis.field = "Supplies"
                                editthis.where = "lesson"
                                editthis.itemId = lessonNumber
                                editthis.state = "Active"
                            }
                        }
                    }
                }

                ESborder {
                    width: parent.width * 0.49
                    height: resourcesColumn.height + 64

                    Column {
                        id: resourcesColumn
                        width: parent.width
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        spacing: thisWindow.width * 0.01
                        clip:true

                        Text {
                            anchors.left: parent.left
                            anchors.margins: 10
                            text: qsTr("Resources:")
                            font.bold: true
                        }
                        Rectangle {

                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.95
                            height: 1
                            color: seperatorColor
                        }

                        ResourceList {
                            id: resourceText
                            thedata:Scrubber.recoverSpecial(lessonResources)
                            width: parent.width
                            height:if(contentHeight > 400) {thisWindow.height * 0.4} else {contentHeight}
                            edit:true
                            field:"Resources"
                            where:"lesson"
                            itemId:lessonNumber
                        }
                    }
                    Image {
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.margins: 15
                        source: "/icons/edit-text.svg"
                        width: 24
                        height: 24
                        fillMode: Image.PreserveAspectFit

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                addResource.current = resourceText.thedata
                                addResource.field = "Resources"
                                addResource.where = "lesson"
                                addResource.itemId = lessonNumber
                                addResource.state = "Active"


                            }
                        }
                    }
                }
            }

            ESborder {
                width: parent.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter
                height: sequenceColumn.height + 64

                Column {
                    id: sequenceColumn
                    width: parent.width * 0.99
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    padding: 10
                    spacing: thisWindow.width * 0.01

                    Text {
                        anchors.left: parent.left
                        anchors.margins: 10
                        text: qsTr("Sequence:")
                        font.bold: true
                    }

                    Rectangle {

                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width * 0.95
                        height: 1
                        color: seperatorColor
                    }

                    MarkDown {
                        id: sequenceText
                        thedata: Scrubber.recoverSpecial(lessonSequence)
                        width: parent.width
                    }
                }
                Image {
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.margins: 15
                    source: "/icons/edit-text.svg"
                    width: 24
                    height: 24
                    fillMode: Image.PreserveAspectFit

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            editthis.field = "Sequence"
                            editthis.where = "lesson"
                            editthis.itemId = lessonNumber
                            editthis.state = "Active"
                        }
                    }
                }
            }

            ESborder {
                width: parent.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter
                height: gqColumn.height + 64

                Column {
                    id: gqColumn
                    width: parent.width * 0.99
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    padding: 10
                    spacing: thisWindow.width * 0.01

                    Text {
                        anchors.left: parent.left
                        anchors.margins: 10
                        text: qsTr("Guiding Questions:")
                        font.bold: true
                    }

                    Rectangle {

                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width * 0.95
                        height: 1
                        color: seperatorColor
                    }
                    MarkDown {
                        id: guidedQuest
                        thedata: Scrubber.recoverSpecial(guidedQuestions)
                        width: parent.width * 0.98
                    }
                }
                Image {
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.margins: 15
                    source: "/icons/edit-text.svg"
                    width: 24
                    height: 24
                    fillMode: Image.PreserveAspectFit

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            editthis.field = "gq"
                            editthis.where = "lesson"
                            editthis.itemId = lessonNumber
                            editthis.state = "Active"
                        }
                    }
                }
            }

            ESborder {
                width: parent.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter
                height: productColumn.height + 24

                Column {
                    id: productColumn
                    width: parent.width * 0.99
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    padding: 10
                    spacing: thisWindow.width * 0.01

                    Text {
                        anchors.left: parent.left
                        anchors.margins: 10
                        text: qsTr("Student Activity:")
                        font.bold: true
                    }

                    Rectangle {

                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width * 0.95
                        height: 1
                        color: seperatorColor
                    }

                    Assignment_ListView {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width * 0.96
                        height: thisWindow.height * 0.08
                        thedata: Scrubber.recoverSpecial(lessonSP)
                    }
                }
                Image {
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.margins: 15
                    source: "/icons/edit-text.svg"
                    width: 24
                    height: 24
                    fillMode: Image.PreserveAspectFit

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            assignmentPick.field = "studentProduct"
                            assignmentPick.where = "lesson"
                            assignmentPick.itemId = lessonNumber
                            assignmentPick.state = "Active"
                        }
                    }
                }
            }

            ESborder {
                width: parent.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter
                height: reviewColumn.height + 64

                Column {
                    id: reviewColumn
                    width: parent.width * 0.99
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    padding: 10
                    spacing: thisWindow.width * 0.01

                    Text {
                        anchors.left: parent.left
                        anchors.margins: 10
                        text: qsTr("Review Questions:")
                        font.bold: true
                    }

                    Rectangle {

                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width * 0.95
                        height: 1
                        color: seperatorColor
                    }

                    Repeater {
                        id: reviewList
                        width: parent.width * 0.98
                        anchors.horizontalCenter: parent.horizontalCenter
                        model: rqList

                        delegate: Rectangle {
                            color: if (index % 2) {
                                       "#FFFFFF"
                                   } else {
                                       "#F1F1F1"
                                   }
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.99
                            height: if (reviewQuestionBlock.height > reviewAnswerBlock.height) {
                                        reviewQuestionBlock.height * 1.1
                                    } else {
                                        reviewAnswerBlock.height * 1.1
                                    }
                            Row {
                                width: parent.width * 0.99
                                anchors.horizontalCenter: parent.horizontalCenter
                                height: if (reviewQuestionBlock.height > reviewAnswerBlock.height) {
                                            reviewQuestionBlock.height * 1.07
                                        } else {
                                            reviewAnswerBlock.height * 1.07
                                        }
                                spacing: thisWindow.width * 0.02

                                Column {
                                    id: reviewQuestionBlock
                                    anchors.verticalCenter: parent.verticalCenter

                                    width: thisWindow.width * 0.48
                                    spacing: thisWindow.width * 0.03

                                    Text {
                                        width: parent.width
                                        wrapMode: Text.WordWrap
                                        text: Scrubber.recoverSpecial(question)
                                    }
                                }

                                Rectangle {
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 1
                                    height: parent.height * 0.85
                                    color: seperatorColor
                                }

                                Column {
                                    id: reviewAnswerBlock
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: thisWindow.width * 0.48
                                    spacing: thisWindow.width * 0.03

                                    Text {
                                        width: parent.width * 0.90
                                        wrapMode: Text.WordWrap
                                        text: Scrubber.recoverSpecial(answer)
                                    }
                                }
                            }
                        }
                    }
                }
                Image {
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.margins: 15
                    source: "/icons/edit-text.svg"
                    width: 24
                    height: 24
                    fillMode: Image.PreserveAspectFit

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            editthis.field = "rq"
                            editthis.where = "lesson"
                            editthis.itemId = lessonNumber
                            editthis.state = "Active"
                        }
                    }
                }
            }
        }
    }

    FieldEdit {
        id: editthis
        width: parent.width
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        state: "inActive"
        onStateChanged: if (state === "inActive") {
                            Courses.loadLesson(userID, lessonNumber)
                        }
    }

    AssignmentEdit {
        id: assignmentPick
        width: parent.width
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        state: "inActive"
        onStateChanged: if (state === "inActive") {
                            Courses.loadLesson(userID, lessonNumber)
                        }
    }

    ResourceListAdd {
        id:addResource
        width:parent.width * 0.3
        //height:parent.height * 0.9
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        state: "inActive"
        onStateChanged: if (state === "inActive") {
                            Courses.loadLesson(userID, lessonNumber)
                        }

    }
}
