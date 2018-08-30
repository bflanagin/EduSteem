import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import QtMultimedia 5.9
import QtWebEngine 1.7

import "../theme"
import "../plugins"
import "../plugins/markdown.js" as Marks
import "../Educator/course.js" as Scripts
import "../plugins/text.js" as Scrubber

ESborder {
    id: thisWindow
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    width: parent.width * 0.70
    height: cColumn.height + 10

    property string media: ""
    property bool edit: false
    property string fulldata: ""

    property string field: ""
    property string where: ""
    property real itemId: 0

    MouseArea {
        anchors.centerIn: parent
        width: mainView.width
        height: mainView.height
        onClicked: {
            thisWindow.state = "inActive"
            video.stop()
            webview.url = "./empty.html"
        }
    }

    Column {
        id: cColumn
        width: parent.width * 0.99
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        MarkDown {
            id: mediaView
            visible: if (media.split("![")[1] !== undefined && media.split(
                                 "![VID]")[1] === undefined) {
                         true
                     } else {
                         false
                     }
            enabled: visible
            width: parent.width
            thedata: media
        }

        Item {
            width: parent.width
            height: parent.width * 0.85
            visible: if (mediaView.visible === true || video.visible === true) {
                         false
                     } else {
                         true
                     }
            onVisibleChanged: {
                webview.url = media.split("](")[1].split(")")[0]
                console.log(webview.url)
            }
            WebEngineView {
                id: webview
                anchors.fill: parent
                anchors.margins: 10
                url: media.split("](")[1].split(")")[0]
                settings.webGLEnabled: true
                settings.pluginsEnabled: true
            }
        }

        Item {
            width: parent.width
            height: parent.width / 1.8
            visible: if (media.split("![")[1] !== undefined && media.split(
                                 "![VID]")[1] !== undefined) {
                         true
                     } else {
                         false
                     }
            Rectangle {
                anchors.fill: video
                color: "black"
            }

            Video {
                id: video
                anchors.fill: parent
                anchors.margins: 10
                source: media.split("![VID]")[1].split("(")[1].split(")")[0]

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        video.focus = true
                        video.playbackState == MediaPlayer.PlayingState ? video.pause(
                                                                              ) : video.play()
                        controls.visible = false
                    }
                    onEntered: controls.visible = true
                    onExited: controls.visible = false
                    onMouseXChanged: controls.visible = true
                    onMouseYChanged: controls.visible = true
                }

                Keys.onSpacePressed: video.playbackState
                                     == MediaPlayer.PlayingState ? video.pause(
                                                                       ) : video.play()
                Keys.onLeftPressed: video.seek(video.position - 5000)
                Keys.onRightPressed: video.seek(video.position + 5000)
            }

            Image {
                id: controls
                property bool startfade: true
                anchors.centerIn: parent
                source: if (video.playbackState !== MediaPlayer.PlayingState) {
                            "/icons/media-playback-start.svg"
                        } else {
                            "/icons/media-playback-pause.svg"
                        }
                height: parent.height * 0.3
                width: height
                smooth: true
                antialiasing: true
                visible: true
                opacity: 0.8
                Timer {
                    id: disappear
                    running: false
                    repeat: false
                    interval: 1000
                    onTriggered: parent.visible = false
                }
            }
        }
    }

    Item {
        id: optBar
        width: parent.width * 0.45
        height: 32
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        visible: edit
        anchors.margins: 10

        Row {
            height: 32
            anchors.right: parent.right
            spacing: 10

            CircleButton {
                width: parent.height
                height: width
                icon: "../icons/trash.svg"
                fillcolor: "white"
                color: "#75000000"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        var fd = fulldata.split("\n")
                        var remove = fd.indexOf(media)
                        fd.splice(remove, 1)
                        Scripts.editField(field, where, itemId,
                                          Scrubber.replaceSpecials(
                                              fd.join("\n")))
                        thisWindow.state = "inActive"
                    }
                }
            }
        }
    }
}
