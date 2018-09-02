import QtQuick 2.11
import QtQuick.Controls 2.2
import Process 1.0

import "../theme"
import "../plugins"
import "../Educator"

import "../Educator/course.js" as Courses
import "../plugins/text.js" as Scrubber
import "../plugins/markdown.js" as MD
import "./ipfs.js" as IPFS

ESborder {
    id: thisWindow
    property string field: ""
    property string where: ""
    property real itemId: 0
    property string current: ""
    height: sourceSelector.height + 20
    clip: true

    Column {
        id: sourceSelector
        anchors.centerIn: parent
        width: parent.width
        spacing: parent.width * 0.01

        Text {
            text: qsTr("Add Media")
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 12
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.98
            height: 2
            color: seperatorColor
        }

        Grid {
            id: optionsGrid
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.98
            columns: 2

            Rectangle {
                width: parent.width / 2
                height: width
                property string fill:"black"
                ESButton {
                    anchors.centerIn: parent
                    width: parent.width / 1.8
                    height: width
                    icon: "/icons/network"
                    label: "Web Site"
                    fillcolor: parent.fill
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {parent.color = seperatorColor
                                parent.fill = "white"
                                }
                    onExited: {parent.color = "white"
                                parent.fill = "black"
                                }
                    onClicked: urlAdd.state = "Active"
                }
            }
            Rectangle {
                width: parent.width / 2
                height: width
                property string fill:"black"
                ESButton {
                    anchors.centerIn: parent
                    width: parent.width / 1.8
                    height: width
                    icon: "/icons/media-playback-start"
                    label: "Video"
                    fillcolor: parent.fill
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {parent.color = seperatorColor
                                parent.fill = "white"
                                }
                    onExited: {parent.color = "white"
                                parent.fill = "black"
                                }
                    onClicked: {
                        fileadd.type = "Video"
                        fileadd.media = "VID"
                        fileadd.visible = true
                    }
                }
            }
            Rectangle {
                width: parent.width / 2
                height: width
                property string fill:"black"
                ESButton {

                    anchors.centerIn: parent
                    width: parent.width / 1.8
                    height: width
                    icon: "/icons/photo"
                    label: "Image"
                    fillcolor: parent.fill
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {parent.color = seperatorColor
                                parent.fill = "white"
                                }
                    onExited: {parent.color = "white"
                                parent.fill = "black"
                                }
                    onClicked: {
                        fileadd.type = "Image"
                        fileadd.media = "IMG"
                        fileadd.visible = true
                    }
                }
            }

            Rectangle {

                width: parent.width / 2
                height: width
                property string fill:"black"
                ESButton {
                    anchors.centerIn: parent
                    width: parent.width / 1.8
                    height: width
                    icon: "/icons/documents"
                    label: "Document"
                    fillcolor: parent.fill
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {parent.color = seperatorColor
                                parent.fill = "white"
                                }
                    onExited: {parent.color = "white"
                                parent.fill = "black"
                                }
                    onClicked: {
                        fileadd.type = "Document"
                        fileadd.media = "DOC"
                        fileadd.visible = true
                    }
                }
            }
            Rectangle {

                width: parent.width / 2
                height: width
                property string fill:"black"
                ESButton {
                    anchors.centerIn: parent
                    width: parent.width / 1.8
                    height: width
                    icon: "/icons/Audio"
                    label: "Sound File"
                    fillcolor: parent.fill
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {parent.color = seperatorColor
                                parent.fill = "white"
                                }
                    onExited: {parent.color = "white"
                                parent.fill = "black"
                                }
                    onClicked: {
                        fileadd.type = "Audio"
                        fileadd.media = "AUDIO"
                        fileadd.visible = true
                    }
                }
            }

        }

        Button {
            width: parent.width * 0.98
            height: 30
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Cancel")
            onClicked: thisWindow.state = "inActive"
            background: ESTextField {
            }
        }
    }

    ESborder {
        id: urlAdd
        width: parent.width
        height: parent.height
        state: "inActive"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        Column {
            width: parent.width * 0.98
            spacing: parent.width * 0.06
            anchors.centerIn: parent
            clip: true

            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                source: "/icons/network.svg"
                width: parent.width * 0.6
                height: parent.width * 0.6
                antialiasing: true
                smooth: true
            }

            TextField {
                id: linkname
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: qsTr("Link Name")
                width: parent.width * 0.98
                background: ESTextField {
                }
            }

            TextField {
                id: url
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: "www.example.com"
                width: parent.width * 0.98
                background: ESTextField {
                }
            }

            Row {
                id: buttonRow
                width: parent.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: parent.width * 0.39

                Button {

                    width: parent.width * 0.30
                    background: ESTextField {
                    }

                    text: qsTr("Cancel")

                    onClicked: {
                        url.text = ""
                        linkname.text = ""
                        urlAdd.state = "inActive"
                    }
                }

                Button {

                    width: parent.width * 0.30
                    background: ESTextField {
                    }
                    text: qsTr("Okay")

                    onClicked: {
                        if (linkname.text.length >= 1 && url.text.length >= 6) {
                            current = current + "\n * [" + linkname.text + "](" + url.text + ")"
                            Courses.editField(field, where, itemId,
                                              Scrubber.replaceSpecials(current))
                            urlAdd.state = "inActive"
                            thisWindow.state = "inActive"
                        }
                    }
                }
            }
        }
    }

    Files {
        id: fileadd
        visible: false
    }

    Process {
        id: ipfs
        property string type: "general"
        property string newfile: ""
        property string media: "IMG"
        onReadyRead: {
            newfile = readAll()
            current = current + "\n * ![" + media + "](" + IPFS.mediaAdd(
                        newfile, type) + ")"
            Courses.editField(field, where, itemId,
                              Scrubber.replaceSpecials(current))
        }
    }
}
