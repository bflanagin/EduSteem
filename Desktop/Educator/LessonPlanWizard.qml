import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.LocalStorage 2.0 as Sql
import QtGraphicalEffects 1.0

import "../theme"
import "../plugins"

import "../Educator/course.js" as Courses
import "../plugins/text.js" as Scrubber
import "../plugins/markdown.js" as MD


ESborder {
    id: thisWindow
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter

    onStateChanged: if (state == "Active") {
                        numberIn.text = lessonList.count+ 1
                        duration.text = 15
                    } else {
                        nameBox.text = ""
                        aboutBox.text = ""
                        lessonSequence.text = ""
                        objectiveBox.text = ""
                        resourceBox.text = ""
                        otherResourcesBox.text = ""
                        numberIn.text = lessonList.count+ 1
                        duration.text = 15
                        //studentProduct.text = ""
                        view.currentIndex = 0

                    }

    states: [

        State {
            name: "Active"
            PropertyChanges {

                target: thisWindow
                opacity: 1
                anchors.verticalCenterOffset: 0
            }
        },

        State {
            name: "inActive"
            PropertyChanges {

                target: thisWindow
                opacity: 0
                anchors.verticalCenterOffset: parent.height + 500
            }
        }
    ]

    transitions: [
        Transition {
            from: "inActive"
            to: "Active"
            reversible: true

            NumberAnimation {
                target: thisWindow
                properties: "opacity,anchors.verticalCenterOffset"
                duration: 550
                easing.type: Easing.InOutElastic
            }
        }
    ]

    state: "inActive"

    SwipeView {
        id: view
        clip: true
        currentIndex: 0
        width: parent.width * 0.95
        height: parent.height * 0.9
        anchors.centerIn: parent
        interactive: false

        Item {
            id: firstPage

            /* General Info */
            Column {
                width: parent.width
                spacing: parent.width * 0.03
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("New Lesson Plan")
                    font.pointSize: 20
                }
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.94
                    height: 4
                    color: seperatorColor
                }

                Row {
                    width: parent.width
                    height: thisWindow.height * 0.7

                    Item {
                        width: thisWindow.width * 0.48
                        height: parent.height

                        Column {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.98
                            spacing: width * 0.03

                            Text {
                                text: qsTr("Course: " + Scrubber.recoverSpecial(courseName))
                            }

                            Text {
                                text: qsTr("Unit: " + Scrubber.recoverSpecial(unitTitle))
                            }

                            Rectangle {
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width * 0.95
                                height: 1
                                color: seperatorColor
                            }

                            Text {
                                text: qsTr("Title")
                                font.bold: true
                            }

                            TextField {
                                id: nameBox
                                width: parent.width
                                placeholderText: qsTr("Lesson Name")
                                background: ESTextField {
                                }
                                selectByMouse: true
                            }

                            Rectangle {
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width * 0.95
                                height: 1
                                color: seperatorColor
                            }

                            Row {
                                width:parent.width
                                height:numberIn.height + 10
                                spacing: 10

                            Text {
                                text: qsTr("Lesson Number:")
                                anchors.verticalCenter: parent.verticalCenter

                            }
                            TextField {
                                id: numberIn
                                width:parent.width * 0.1
                                anchors.verticalCenter: parent.verticalCenter
                                background: ESTextField {
                                }
                                selectByMouse: true
                            }

                            Text {
                                text: qsTr("Duration: (in minutes):")
                                anchors.verticalCenter: parent.verticalCenter

                            }
                            TextField {
                                id: duration
                                width:parent.width * 0.1
                                anchors.verticalCenter: parent.verticalCenter
                                background: ESTextField {
                                }
                                selectByMouse: true
                            }

                            }
                        }
                    }

                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        width: 1
                        height: parent.height * 0.85
                        color: seperatorColor
                    }

                    Item {
                        width: thisWindow.width * 0.48
                        height: parent.height * 0.98

                        Text {
                            id: aboutTitle
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            text: qsTr("Introduction:")
                        }
                        ScrollView {
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: aboutTitle.bottom
                            anchors.bottom: parent.bottom
                            width: parent.width * 0.95
                            background: ESTextField {
                            }
                            TextArea {
                                id: aboutBox
                                width:thisWindow.width * 0.48
                                height:thisWindow.height * 0.85
                                wrapMode: Text.WordWrap
                                padding: 10
                                selectByMouse: true
                            }
                        }
                    }
                }
            }
        }
        Item {
            id: secondPage

            Column {
                id:oColumn
                width: parent.width * 0.70
                spacing: parent.width * 0.02

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Objective")
                    font.pointSize: 20
                }
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.94
                    height: 4
                    color: seperatorColor
                }

                ScrollView {
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: thisWindow.height * 0.70
                    width: parent.width * 0.95
                    background: ESTextField {
                    }
                    TextArea {
                        id: objectiveBox
                        width:thisWindow.width * 0.95
                        height:thisWindow.height * 0.70
                        wrapMode: Text.WordWrap
                        padding: 10
                        selectByMouse: true
                    }
                }
            }

            Rectangle {
                anchors.left: oColumn.right
                anchors.right: parent.right
                anchors.top: oColumn.top
                anchors.topMargin: 20
                anchors.rightMargin: 10
                anchors.bottom: parent.bottom
                anchors.bottomMargin: parent.height * 0.1
                color: "#50F0F0F0"
                clip: true

                MarkDown {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    height: parent.height
                    width: thisWindow.width * 0.22
                    thedata: MD.guide()
                }
            }

        }
        Item {
            id: thirdPage

            Item {
                width: parent.width
                height: parent.height

                Column {
                    width: parent.width
                    spacing: parent.width * 0.02

                    Text {
                        id: title
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("Resources")
                        font.pointSize: 20
                    }

                    Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width * 0.94
                        height: 4
                        color: seperatorColor
                    }

                    Row {
                        width: parent.width
                        height: thisWindow.height * 0.7

                        Item {
                            width: thisWindow.width * 0.48
                            height: parent.height

                            Text {
                                id: aboutSchoolTitle
                                anchors.left: parent.left
                                anchors.leftMargin: 10
                                text: qsTr("Supplies:")
                            }

                            ScrollView {
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: aboutSchoolTitle.bottom
                                anchors.bottom: parent.bottom
                                width: parent.width * 0.95
                                background: ESTextField {
                                }
                                TextArea {
                                    id: resourceBox
                                    width:thisWindow.width * 0.48
                                    height:thisWindow.height * 0.70
                                    wrapMode: Text.WordWrap
                                    selectByMouse: true
                                }
                            }
                        }

                        Rectangle {
                            anchors.verticalCenter: parent.verticalCenter
                            width: 1
                            height: parent.height * 0.85
                            color: seperatorColor
                        }

                        Item {
                            width: thisWindow.width * 0.48
                            height: parent.height

                            Text {
                                id: otherResourcesTitle
                                anchors.left: parent.left
                                anchors.leftMargin: 10
                                text: qsTr("Other Resources:")
                            }

                            ScrollView {
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: otherResourcesTitle.bottom
                                anchors.bottom: parent.bottom
                                width: parent.width * 0.95
                                background: ESTextField {
                                }
                                TextArea {
                                    id: otherResourcesBox
                                    width:thisWindow.width * 0.48
                                    height:thisWindow.height * 0.70
                                    wrapMode: Text.WordWrap
                                    selectByMouse: true
                                }
                            }
                        }
                    }
                }
            }
        }

        Item {
            id: fourthPage

            Column {
                width: parent.width
                spacing: parent.width * 0.02

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Guiding Questions")
                    font.pointSize: 20
                }
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.94
                    height: 4
                    color: seperatorColor
                }
                Item {
                    width: parent.width
                    height: thisWindow.height * 0.04

                    Text {
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        width: thisWindow.width * 0.50
                        text: "Questions:"
                    }

                    Button {
                        anchors.right: parent.right
                        anchors.rightMargin: 20
                        text: qsTr("Add")
                        background: ESTextField {
                        }
                        onClicked: {
                            newQuestion.type = 0
                            newQuestion.state = "Active"
                        }
                    }
                }

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.94
                    height: 1
                    color: seperatorColor
                }

                ListView {

                    width: parent.width * 0.98
                    height: thisWindow.height * 0.40
                    spacing: thisWindow.width * 0.02
                    clip: true

                    model: gqList

                    delegate: ESborder {
                        width: thisWindow.width * 0.90
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: questionBlock.height * 1.1
                        Column {
                            id: questionBlock
                            anchors.centerIn: parent
                            width: parent.width * 0.98
                            spacing: thisWindow.width * 0.03

                            Text {
                                anchors.left: parent.left
                                anchors.leftMargin: 20
                                width: parent.width
                                wrapMode: Text.WordWrap
                                text: question
                            }
                        }
                    }
                }
            }
        }

        Item {
            id: fifthPage

            Column {
                id:lsColumn
                width: parent.width * 0.70
                spacing: parent.width * 0.02

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Lesson Sequence")
                    font.pointSize: 20
                }
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.94
                    height: 4
                    color: seperatorColor
                }
                ScrollView {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.98
                    height: thisWindow.height * 0.70
                    background: ESTextField {
                    }
                    TextArea {
                        id: lessonSequence
                        width:thisWindow.width * 0.94
                        height:thisWindow.height * 0.70
                        wrapMode: Text.WordWrap
                        selectByMouse: true
                    }
                }
            }

            Rectangle {
                anchors.left: lsColumn.right
                anchors.right: parent.right
                anchors.top: lsColumn.top
                anchors.topMargin: 20
                anchors.rightMargin: 10
                anchors.bottom: parent.bottom
                anchors.bottomMargin: parent.height * 0.1
                color: "#50F0F0F0"
                clip: true

                MarkDown {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    height: parent.height
                    width: thisWindow.width * 0.22
                    thedata: MD.guide()
                }
            }
        }

       /* Item {
            id: sixthPage

            Column {
                id:saColumn
                width: parent.width * 0.70
                spacing: parent.width * 0.02

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Student Activity")
                    font.pointSize: 20
                }
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.94
                    height: 4
                    color: seperatorColor
                }

                ScrollView {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.98
                    height: thisWindow.height * 0.70
                    background: ESTextField {
                    }
                    TextArea {
                        id: studentProduct
                        width:thisWindow.width * 0.48
                        height:thisWindow.height * 0.70
                        wrapMode: Text.WordWrap
                        selectByMouse: true
                    }
                }
            }

            Rectangle {
                anchors.left: saColumn.right
                anchors.right: parent.right
                anchors.top: saColumn.top
                anchors.topMargin: 20
                anchors.rightMargin: 10
                anchors.bottom: parent.bottom
                anchors.bottomMargin: parent.height * 0.1
                color: "#50F0F0F0"
                clip: true

                MarkDown {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    height: parent.height
                    width: thisWindow.width * 0.22
                    thedata: MD.guide()
                }
            }
        } */

        Item {
            id: seventhPage

            Column {
                width: parent.width
                spacing: parent.width * 0.02

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Review Questions")
                    font.pointSize: 20
                }
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.94
                    height: 4
                    color: seperatorColor
                }

                Item {
                    width: parent.width
                    height: thisWindow.height * 0.04
                    Text {
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        anchors.verticalCenter: parent.verticalCenter
                        text: nameBox.text + qsTr(" Questions")
                    }

                    Button {
                        anchors.right: parent.right
                        anchors.rightMargin: 20
                        text: qsTr("Add")
                        background: ESTextField {
                        }
                        onClicked: {
                            newQuestion.type = 1
                            newQuestion.state = "Active"
                        }
                    }
                }

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.94
                    height: 1
                    color: seperatorColor
                }

                Row {
                    width: parent.width
                    Text {
                        width: thisWindow.width * 0.50
                        text: "Question:"
                        padding: 20
                    }
                    Text {
                        width: thisWindow.width * 0.50
                        text: "Answer:"
                        padding: 20
                    }
                }

                ListView {

                    width: parent.width
                    height: thisWindow.height * 0.40
                    spacing: thisWindow.width * 0.02
                    clip: true
                    model: rqList

                    delegate: ESborder {
                        width: parent.width
                        height: if (reviewQuestionBlock.height > reviewAnswerBlock.height) {
                                    reviewQuestionBlock.height * 1.1
                                } else {
                                    reviewAnswerBlock.height * 1.1
                                }
                        Row {
                            width: parent.width * 0.94
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
                                    text: question
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
                                    text: answer
                                }
                            }
                        }
                    }
                }
            }
        }

        Item {
            id: eighthPage
            /* finish */
            Column {
                width: parent.width
                spacing: parent.width * 0.02

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Finish")
                    font.pointSize: 20
                }
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.94
                    height: 4
                    color: seperatorColor
                }

                Text {
                    text: qsTr("Course: " + Scrubber.recoverSpecial(courseName))
                }

                Text {
                    text: qsTr("Unit: " + Scrubber.recoverSpecial(unitTitle))
                }

                Text {
                    text: qsTr("Lesson Plan: " + nameBox.text)
                }

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.94
                    height: 1
                    color: seperatorColor
                }

                Text {

                    width: parent.width
                    wrapMode: Text.WordWrap
                    text: "You're all set to use this new lesson plan. Be sure to upload it to your Steemit account if you would like to share it with others!"
                }
            }
        }
    }

    Button {
        id: backbutton
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 20
        text: if (view.currentIndex > 0) {
                  qsTr("Back")
              } else {
                  qsTr("Cancel")
              }
        background: ESTextField {
        }
        onClicked: if (view.currentIndex > 0) {
                       view.currentIndex = view.currentIndex - 1
                   } else {
                       thisWindow.state = "inActive"
                   }
    }

    Button {
        id: forwardbutton
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 20
        text: if (view.currentIndex < view.count - 1) {
                  "Next"
              } else {
                  "Finish"
              }
        background: ESTextField {
        }
        onClicked: {
            if (view.currentIndex < view.count - 1) {
                view.currentIndex = view.currentIndex + 1
            } else {
                Courses.saveLesson(
                            userID, coursenumber, unitNumber, Scrubber.replaceSpecials(
                                nameBox.text), numberIn.text, duration.text, Scrubber.replaceSpecials(
                                aboutBox.text), Scrubber.replaceSpecials(objectiveBox.text), Scrubber.replaceSpecials(
                                resourceBox.text), Scrubber.replaceSpecials(otherResourcesBox.text), Scrubber.replaceSpecials(
                                guidedQuestions.toString()), Scrubber.replaceSpecials(lessonSequence.text),
                            Scrubber.replaceSpecials(reviewQuestions.toString()), 0)
                thisWindow.state = "inActive"
            }
        }
    }

    PageIndicator {
        id: indicator

        count: view.count
        currentIndex: view.currentIndex

        anchors.bottom: view.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

    QuestionWizard {
        id: newQuestion
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width: 1100
        state: "inActive"
    }
}
