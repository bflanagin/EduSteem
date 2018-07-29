import QtQuick 2.11
import QtWebEngine 1.7
import QtQuick.Controls 2.2
import "../theme"
import "../plugins"
import "../General"

import "../Educator/course.js" as Courses
import "../General/network.js" as Network
import "../Student/student.js" as Students
import "../plugins/text.js" as Scrubber

Item {
    id:thisWindow
    width: parent.width * 0.98
    height:parent.height * 0.98
    anchors.centerIn: parent
    property string url: "none"
    property int wordcount: 100

    ESborder {
        anchors.left: parent.left
        width:parent.width * 0.55
        anchors.top:parent.top
        anchors.bottom:parent.bottom
        anchors.bottomMargin: parent.height * 0.1
    WebEngineView {
        anchors.fill: parent
        anchors.margins: 10
        url:thisWindow.url
        enabled:thisWindow.visible
        settings.webGLEnabled: true
        settings.pluginsEnabled: true
    }

    }

    ESborder {
        id:noteBlock
        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.04
        width:parent.width * 0.4
        anchors.top:parent.top
        anchors.bottom:parent.bottom
        anchors.bottomMargin: parent.height * 0.2

        Text {
            id:title
            anchors.top:parent.top
            anchors.left: parent.left
            anchors.margins: 10
            font.bold: true
            font.pointSize: 12
            text:qsTr("Notes")
        }

        Rectangle {
            anchors.top:title.bottom
            width:parent.width * 0.98
            anchors.horizontalCenter: parent.horizontalCenter
            height:3
            color:seperatorColor
        }

        ScrollView {
            id:noteScroll
            anchors.top:title.bottom
            anchors.topMargin: 10
            anchors.bottom:parent.bottom
            anchors.bottomMargin: parent.height * 0.05
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width * 0.98

            background: ESTextField {}

            TextArea {
                id:lessonNotes
                width:noteBlock.width * 0.98
                height:noteBlock.height * 0.98
                wrapMode: Text.WordWrap
                selectByMouse: true
                onTextChanged: lessonUpdate = Scrubber.replaceSpecials(text)
            }

        }

        Text {
            anchors.top:noteScroll.bottom
            anchors.margins: 5
            anchors.right:noteScroll.right
            text:"Word count: "+(lessonNotes.text.split(" ").length - 1)
            visible: if((lessonNotes.text.split(" ").length - 1) > 0) {true} else {false}
        }

    }

    Text {
        anchors.top:noteBlock.bottom
        anchors.topMargin: parent.height * 0.02
        width:noteBlock.width
        anchors.left:noteBlock.left
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
        text: "Following the instructions, fill out the required area and submit for review. You will need to have a word count greater than "+wordcount+ " to complete this assignement."
    }



}
