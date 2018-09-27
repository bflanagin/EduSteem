import QtQuick 2.11
import QtMultimedia 5.9
import QtQuick.Controls 2.2
import "../theme"
import "../plugins"
import "../General"

import "../Educator/course.js" as Courses
import "../General/network.js" as Network
import "../Student/student.js" as Students
import "../plugins/text.js" as Scrubber
import "../plugins/spellcheck.js" as Spelling

Item {
    id:thisWindow
    width: parent.width * 0.98
    height:parent.height * 0.98
    anchors.centerIn: parent

    property int wordcount: 0
    property string url: ""

    Timer {
        id:checker
        interval: 2000
        repeat: false
        running: true
        onTriggered: {
            var thestring = lessonNotes.getText(0,lessonNotes.length).replace(/<font color='red'>/g,"").replace(/<\/font>/g,"")
            lessonUpdate = Scrubber.replaceSpecials(thestring)
            lessonNotes.text = Spelling.checkspelling(thestring)
            lessonNotes.cursorPosition = lessonNotes.length
        }
    }

    ESborder {
        anchors.left:parent.left
        width:parent.width * 0.57
        anchors.top:parent.top
        anchors.bottom:parent.bottom
        anchors.bottomMargin: parent.height * 0.1

        Rectangle {
            anchors.fill: video
            color:"black"


        }

   Video {
       id:video
        anchors.fill: parent
        anchors.margins: 10
        source:url

        MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    video.focus = true
                    video.playbackState == MediaPlayer.PlayingState ? video.pause() : video.play()
                    controls.visible = false
                }
                onEntered: controls.visible = true
                onExited:  controls.visible = false
                onMouseXChanged: controls.visible = true
                onMouseYChanged: controls.visible = true
        }

            Keys.onSpacePressed: video.playbackState == MediaPlayer.PlayingState ? video.pause() : video.play()
            Keys.onLeftPressed: video.seek(video.position - 5000)
            Keys.onRightPressed: video.seek(video.position + 5000)

    }

   Image {
       id:controls
       property bool startfade: true
       anchors.centerIn: parent
       source:if(video.playbackState !== MediaPlayer.PlayingState) {"/icons/media-playback-start.svg"} else {"/icons/media-playback-pause.svg"}
       height:parent.height * 0.3
       width:height
       smooth: true
       antialiasing: true
       visible: true
       opacity: 0.8
       Timer {
           id:disappear
           running:false
           repeat: false
           interval: 1000
           onTriggered: parent.visible = false
       }

   }

    }

    ESborder {
        id:noteBlock
        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.02
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
                 textFormat: Text.RichText

                 Keys.onReleased: checker.restart()
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
