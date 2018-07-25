import QtQuick 2.11
import QtMultimedia 5.9
import "../theme"
import "../plugins"
import "../General"

import "../Educator/course.js" as Courses
import "../General/network.js" as Network
import "../Student/student.js" as Students

Item {
    id:thisWindow
    width: parent.width * 0.98
    height:parent.height * 0.98
    property string url: ""
    ESborder {
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width * 0.90
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

}
