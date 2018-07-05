import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.LocalStorage 2.0 as Sql
import QtGraphicalEffects 1.0

import "../theme"
import "../plugins"

import "./course.js" as Scripts
import "../plugins/text.js" as Scrubber

ESborder {
    id: thisWindow
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter



    onStateChanged: if (state == "Active") {

                    } else {

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
                                text: qsTr("Course: " + courseName)
                            }

                            Text {
                                text: qsTr("Unit: " + unitTitle)
                            }

                            Rectangle {
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width * 0.95
                                height: 1
                                color: seperatorColor
                            }

                            Text {
                                text: qsTr("General")
                                font.bold: true
                            }

                            TextField {
                                id: nameBox
                                width: parent.width
                                placeholderText: qsTr("Lesson Name")
                                background: ESTextField {
                                }
                            }

                            Rectangle {
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width * 0.95
                                height: 1
                                color: seperatorColor
                            }

                            Text {
                                text: qsTr("Lesson Number:")
                            }
                            SpinBox {
                                id: numberIn
                                anchors.left: parent.left
                                anchors.leftMargin: 40
                                width: parent.width * 0.15

                                down.indicator: Item {
                                    anchors.right: parent.left
                                    anchors.rightMargin: 4
                                    width: parent.height
                                    height: parent.height
                                    Rectangle {
                                        anchors.fill: parent
                                        radius: width / 2
                                        color: seperatorColor

                                        Image {
                                            id: downI2
                                            visible: false
                                            anchors.centerIn: parent
                                            width: parent.width * 0.5
                                            source: "/icons/minus.svg"
                                            fillMode: Image.PreserveAspectFit
                                        }

                                        ColorOverlay {
                                            source: downI2
                                            color: "white"
                                            anchors.fill: downI2
                                        }
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: numberIn.value = numberIn.value - 1
                                    }
                                }

                                up.indicator: Item {
                                    anchors.left: parent.right
                                    anchors.leftMargin: 4
                                    width: parent.height
                                    height: parent.height

                                    Rectangle {

                                        anchors.fill: parent
                                        radius: width / 2
                                        color: seperatorColor

                                        Image {
                                            id: upI2
                                            visible: false
                                            anchors.centerIn: parent
                                            width: parent.width * 0.5
                                            source: "/icons/add.svg"
                                            fillMode: Image.PreserveAspectFit
                                        }

                                        ColorOverlay {
                                            source: upI2
                                            color: "white"
                                            anchors.fill: upI2
                                        }
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: numberIn.value = numberIn.value + 1
                                    }
                                }

                                from: 1
                                to: 20
                                background: ESTextField {
                                }
                            }
                            Text {
                                text: qsTr("Duration: (in minutes)")
                            }
                            SpinBox {
                                id: duration
                                anchors.left: parent.left
                                anchors.leftMargin: 40
                                width: parent.width * 0.15
                                editable: true
                                from: 1
                                to: 120
                                value: 0

                                background: ESTextField {
                                }

                                validator: IntValidator {
                                    locale: duration.locale.name
                                    bottom: Math.min(duration.from, duration.to)
                                    top: Math.max(duration.from, duration.to)
                                }

                                down.indicator: Item {
                                    anchors.right: parent.left
                                    anchors.rightMargin: 4
                                    width: parent.height * 0.98
                                    height: parent.height * 0.98
                                    Rectangle {
                                        anchors.fill: parent
                                        radius: width / 2
                                        color: seperatorColor

                                        Image {
                                            id: downI1
                                            visible: false
                                            anchors.centerIn: parent
                                            width: parent.width * 0.5
                                            source: "/icons/minus.svg"
                                            fillMode: Image.PreserveAspectFit
                                        }

                                        ColorOverlay {
                                            source: downI1
                                            color: "white"
                                            anchors.fill: downI1
                                        }
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: duration.value = duration.value - 1
                                    }
                                }

                                up.indicator: Item {

                                    anchors.left: parent.right
                                    anchors.leftMargin: 4
                                    width: parent.height * 0.98
                                    height: parent.height * 0.98
                                    Rectangle {
                                        anchors.fill: parent
                                        radius: width / 2
                                        color: seperatorColor

                                        Image {
                                            id: upI1
                                            visible: false
                                            anchors.centerIn: parent
                                            width: parent.width * 0.5
                                            source: "/icons/add.svg"
                                            fillMode: Image.PreserveAspectFit
                                        }

                                        ColorOverlay {
                                            source: upI1
                                            color: "white"
                                            anchors.fill: upI1
                                        }
                                    }
                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: duration.value = duration.value + 1
                                    }
                                }

                                contentItem: TextInput {
                                    z: 2
                                    text: duration.textFromValue(
                                              duration.value, duration.locale)
                                    font: duration.font
                                    color: "black"

                                    horizontalAlignment: Qt.AlignHCenter
                                    verticalAlignment: Qt.AlignVCenter
                                    width: duration.width
                                    readOnly: !duration.editable
                                    validator: duration.validator
                                    inputMethodHints: Qt.ImhFormattedNumbersOnly
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
                                anchors.fill: parent
                                wrapMode: Text.WordWrap
                                padding: 10
                            }
                        }
                    }
                }
            }
        }
        Item {
            id: secondPage

            Column {
                width: parent.width
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
                        anchors.fill: parent
                        wrapMode: Text.WordWrap
                        padding: 10
                    }
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
                                    anchors.fill: parent
                                    wrapMode: Text.WordWrap
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
                                    anchors.fill: parent
                                    wrapMode: Text.WordWrap
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
                width: parent.width
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
                        anchors.fill: parent
                        wrapMode: Text.WordWrap
                    }
                }
            }
        }

        Item {
            id: sixthPage

            Column {
                width: parent.width
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
                        anchors.fill: parent
                        wrapMode: Text.WordWrap
                    }
                }
            }
        }

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
                    text: qsTr("Course: " + courseName)
                }

                Text {
                    text: qsTr("Unit: " + unitTitle)
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
                Scripts.saveLesson(
                            userid, coursenumber, unitNumber, Scrubber.replaceSpecials(
                                nameBox.text), numberIn.value, duration.value, Scrubber.replaceSpecials(
                                aboutBox.text), Scrubber.replaceSpecials(objectiveBox.text), Scrubber.replaceSpecials(
                                resourceBox.text), Scrubber.replaceSpecials(otherResourcesBox.text), Scrubber.replaceSpecials(
                                guidedQuestions.toString()), Scrubber.replaceSpecials(lessonSequence.text),
                            Scrubber.replaceSpecials(studentProduct.text), Scrubber.replaceSpecials(reviewQuestions.toString()), 0)
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
