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
    clip:true

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


    onStateChanged: if (state == "Active") {
                        Scripts.loadLesson(userid, lessonNumber)
                    } else {

                    }


    Text {
        id: title
        anchors.top: parent.top
        anchors.left: backbutton.right
        anchors.margins: 20
        text: lessonTitle
        font.bold: true
        font.pointSize: 15
        Image {
            anchors.left:parent.right
            anchors.bottom:parent.bottom
            source:"/icons/edit-text.svg"
            width:parent.height * 0.5
            height:parent.height * 0.5
            fillMode: Image.PreserveAspectFit

            MouseArea {
                anchors.fill: parent
                onClicked: {editthis.field = "Title"
                            editthis.where = "lesson"
                            editthis.itemId = lessonNumber
                            editthis.state = "Active" }
            }
        }
    }

    CircleButton {
        id:backbutton
        anchors.top:parent.top
        anchors.left:parent.left
        anchors.margins: 20
        height:title.height
        width:title.height

        MouseArea {
            anchors.fill: parent
            onClicked: {
                thisWindow.state = "inActive"
            }
        }
    }

    Button {
        anchors.top: parent.top
        anchors.right:parent.right
        anchors.margins: 20
        text:qsTr("Student View")
        background: ESTextField{}
    }

    Rectangle {
        anchors.top: title.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.95
        height: 3
        color: seperatorColor
    }

    Item {
        id:lessonInfo
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: title.bottom
        anchors.topMargin: 24
        width: parent.width * 0.95
        height: 70

        Text {
            anchors.top:parent.top
            anchors.left: parent.left
            anchors.margins: 10
            text:qsTr("Author: ")+ lessonAuthor
        }
        Text {
            anchors.bottom:parent.bottom
            anchors.left: parent.left
            anchors.margins: 10
            text:qsTr("Date Created: ")+ lessonDate
        }

        Text {
            anchors.top:parent.top
            anchors.right: parent.right
            anchors.margins: 10
            text:qsTr("Lesson Number: ")+ lessonOrder
        }
        Text {
            anchors.bottom:parent.bottom
            anchors.right: parent.right
            anchors.margins: 10
            text:qsTr("Duration: ")+ lessonDuration + qsTr(" minutes")
        }

        Rectangle {
            anchors.bottom: parent.bottom

            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: 1
            color: seperatorColor
        }

    }

    Flickable {
        anchors.top: lessonInfo.bottom
        anchors.topMargin: 10
        anchors.bottom:parent.bottom
        anchors.bottomMargin: 10
        width:parent.width
        contentHeight:planColumn.height + 100
        clip:true

    Column {
        id:planColumn
        width: parent.width * 0.98
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: thisWindow.width * 0.01

        ESborder {
            width: parent.width * 0.98
            anchors.horizontalCenter: parent.horizontalCenter
            height: aboutColumn.height * 1.2

            Column {
                id: aboutColumn
                width: parent.width
                anchors.centerIn: parent
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
                    thedata: Scrubber.recoverSpecial(lessonAbout)
                    width: parent.width

                }
           }
            Image {
                anchors.right:parent.right
                anchors.bottom:parent.bottom
                anchors.margins: 15
                source:"/icons/edit-text.svg"
                width:24
                height:24
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    anchors.fill: parent
                    onClicked: {editthis.field = "About"
                        editthis.where = "lesson"
                        editthis.itemId = lessonNumber
                        editthis.state = "Active" }
                }
            }
        }


                ESborder {
                    width: parent.width * 0.98
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: objectiveColumn.height * 1.3

                    Column {
                        id: objectiveColumn
                        width: parent.width
                        anchors.centerIn: parent
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
                            thedata: Scrubber.recoverSpecial(lessonObjective)
                            width: parent.width

                        }
                    }
                    Image {
                        anchors.right:parent.right
                        anchors.bottom:parent.bottom
                        anchors.margins: 15
                        source:"/icons/edit-text.svg"
                        width:24
                        height:24
                        fillMode: Image.PreserveAspectFit

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {editthis.field = "Objective"
                                editthis.where = "lesson"
                                editthis.itemId = lessonNumber
                                editthis.state = "Active" }
                        }
                    }
                }



            Row {
                width: parent.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: thisWindow.width * 0.02

            ESborder {
                width: parent.width * 0.49
                height: suppliesColumn.height * 1.3

                Column {
                    id: suppliesColumn
                    width: parent.width
                    anchors.centerIn: parent
                    spacing: thisWindow.width * 0.01

                    Text {
                        anchors.left: parent.left
                        anchors.margins: 10
                        text: qsTr("Supplies:")
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
                    anchors.right:parent.right
                    anchors.bottom:parent.bottom
                    anchors.margins: 15
                    source:"/icons/edit-text.svg"
                    width:24
                    height:24
                    fillMode: Image.PreserveAspectFit

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {editthis.field = "Supplies"
                            editthis.where = "lesson"
                            editthis.itemId = lessonNumber
                            editthis.state = "Active" }
                    }
                }
            }

            ESborder {
                width: parent.width * 0.49
                height: resourcesColumn.height * 1.3

                Column {
                    id: resourcesColumn
                    width: parent.width
                    anchors.centerIn: parent
                    spacing: thisWindow.width * 0.01

                    Text {
                        anchors.left: parent.left
                        anchors.margins: 10
                        text: qsTr("Resources:")
                    }
                    Rectangle {

                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width * 0.95
                        height: 1
                        color: seperatorColor
                    }

                    MarkDown {
                        id: resourceText
                        thedata: Scrubber.recoverSpecial(lessonResources)
                        width: parent.width

                    }
               }
                Image {
                    anchors.right:parent.right
                    anchors.bottom:parent.bottom
                    anchors.margins: 15
                    source:"/icons/edit-text.svg"
                    width:24
                    height:24
                    fillMode: Image.PreserveAspectFit

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {editthis.field = "Resources"
                            editthis.where = "lesson"
                            editthis.itemId = lessonNumber
                            editthis.state = "Active" }
                    }
                }
            }

            }


            ESborder {
                width: parent.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter
                height: sequenceColumn.height * 1.3

                Column {
                    id: sequenceColumn
                    width: parent.width
                    anchors.centerIn: parent
                    spacing: thisWindow.width * 0.01

                    Text {
                        anchors.left: parent.left
                        anchors.margins: 10
                        text: qsTr("Sequence:")
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
                    anchors.right:parent.right
                    anchors.bottom:parent.bottom
                    anchors.margins: 15
                    source:"/icons/edit-text.svg"
                    width:24
                    height:24
                    fillMode: Image.PreserveAspectFit

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {editthis.field = "Sequence"
                            editthis.where = "lesson"
                            editthis.itemId = lessonNumber
                            editthis.state = "Active" }
                    }
                }
            }

            ESborder {
                width: parent.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter
                height: gqColumn.height * 1.3

                Column {
                    id: gqColumn
                    width: parent.width
                    anchors.centerIn: parent
                    spacing: thisWindow.width * 0.01

                    Text {
                        anchors.left: parent.left
                        anchors.margins: 10
                        text: qsTr("Guiding Questions:")
                    }

                    Rectangle {

                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width * 0.95
                        height: 1
                        color: seperatorColor
                    }

                    MarkDown {
                        id: gqText
                        thedata: Scrubber.recoverSpecial(lessonGQ)
                        width: parent.width

                    }
                }
                Image {
                    anchors.right:parent.right
                    anchors.bottom:parent.bottom
                    anchors.margins: 15
                    source:"/icons/edit-text.svg"
                    width:24
                    height:24
                    fillMode: Image.PreserveAspectFit

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {editthis.field = "gq"
                            editthis.where = "lesson"
                            editthis.itemId = lessonNumber
                            editthis.state = "Active" }
                    }
                }
            }

            ESborder {
                width: parent.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter
                height: productColumn.height * 1.3

                Column {
                    id: productColumn
                    width: parent.width
                    anchors.centerIn: parent
                    spacing: thisWindow.width * 0.01

                    Text {
                        anchors.left: parent.left
                        anchors.margins: 10
                        text: qsTr("Student Activity:")
                    }

                    Rectangle {

                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width * 0.95
                        height: 1
                        color: seperatorColor
                    }

                    MarkDown {
                        id: productText
                        thedata: Scrubber.recoverSpecial(lessonSP)
                        width: parent.width

                    }
                }
                Image {
                    anchors.right:parent.right
                    anchors.bottom:parent.bottom
                    anchors.margins: 15
                    source:"/icons/edit-text.svg"
                    width:24
                    height:24
                    fillMode: Image.PreserveAspectFit

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {editthis.field = "Product"
                            editthis.where = "lesson"
                            editthis.itemId = lessonNumber
                            editthis.state = "Active" }
                    }
                }
            }

            ESborder {
                width: parent.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter
                height: reviewColumn.height * 1.4

                Column {
                    id: reviewColumn
                    width: parent.width
                    anchors.centerIn: parent
                    spacing: thisWindow.width * 0.01

                    Text {
                        anchors.left: parent.left
                        anchors.margins: 10
                        text: qsTr("Review Questions:")
                    }

                    Rectangle {

                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width * 0.95
                        height: 1
                        color: seperatorColor
                    }

                    Repeater {
                        id: reviewText
                        width:parent.width * 0.98
                        anchors.horizontalCenter: parent.horizontalCenter
                        model: lessonRQ.split(";#x2c;").length

                        delegate: Item {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    width:parent.width * 0.98
                                    height:itemColumn.height * 1.03

                                    Rectangle {
                                        anchors.fill: parent
                                        color:if(index % 2) {"#FFFFFF"} else {"#F1F1F1"}
                                    }
                                        Column {
                                            id:itemColumn
                                            width:parent.width
                                            anchors.centerIn: parent
                                            spacing: thisWindow.width * 0.01

                                    Text {
                                        anchors.left:parent.left
                                        anchors.leftMargin: 10
                                       text:qsTr("Question: ")+Scrubber.recoverSpecial(lessonRQ.split(";#x2c;")[index]).split(":::")[0]
                                    }

                                    Text {
                                        anchors.left:parent.left
                                        anchors.leftMargin: 30
                                       text:qsTr("Answer: ")+Scrubber.recoverSpecial(lessonRQ.split(";#x2c;")[index]).split(":::")[1]
                                    }

                                    }
                        }

                    }
                }
                Image {
                    anchors.right:parent.right
                    anchors.bottom:parent.bottom
                    anchors.margins: 15
                    source:"/icons/edit-text.svg"
                    width:24
                    height:24
                    fillMode: Image.PreserveAspectFit

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {editthis.field = "rq"
                            editthis.where = "lesson"
                            editthis.itemId = lessonNumber
                            editthis.state = "Active" }
                    }
                }
            }

        }

        }

    FieldEdit {
        id:editthis
        width:800
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        state:"inActive"

        onStateChanged: if(state == "inActive") {Scripts.loadLesson(userid, lessonNumber)}
    }

}
