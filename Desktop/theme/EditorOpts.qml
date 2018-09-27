import QtQuick 2.11
import QtQuick.Controls 2.2
import Process 1.0

import "../theme"
import "../plugins"
import "../Educator"

Row {

    height: 18
    spacing: 5

    property bool strike: false
    property bool bold: false
    property bool italic: false

    Rectangle {
        height: parent.height
        width: 1
        color: "black"
    }

    ESButton {
        icon: "../icons/copy.svg"
        height: parent.height
        width: parent.height
        fillcolor: "gray"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                changeBox.copy()
            }
        }
    }

    ESButton {
        icon: "../icons/edit-paste.svg"
        height: parent.height
        width: parent.height
        fillcolor: "gray"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                changeBox.paste()
            }
        }
    }

    Rectangle {
        height: parent.height
        width: 1
        color: "black"
    }

    ESButton {
        icon: "../icons/insert-link.svg"
        height: parent.height
        width: parent.height
        fillcolor: "gray"

        MouseArea {
            anchors.fill: parent
            onClicked: changeBox.insert(changeBox.cursorPosition,
                                        "[example](www.example.com)")
        }
    }

    ESButton {
        icon: "../icons/insert-image.svg"
        height: parent.height
        width: parent.height
        fillcolor: "gray"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                fileadd.type = "general"
                fileadd.visible = true
            }
        }
    }

    Rectangle {
        height: parent.height
        width: 1
        color: "black"
    }

    ESButton {
        id: boldToggle

        property bool onOff: bold
        icon: "../icons/format-text-bold.svg"
        height: parent.height
        width: parent.height
        fillcolor: if (onOff === false) {
                       "gray"
                   } else {
                       "black"
                   }

        onOnOffChanged: changeBox.insert(changeBox.cursorPosition, "**")

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (parent.onOff === false) {
                    parent.onOff = true
                } else {
                    parent.onOff = false
                }
            }
        }
    }

    ESButton {

        id: italicToggle

        property bool onOff: italic
        icon: "../icons/format-text-italic.svg"
        height: parent.height
        width: parent.height
        fillcolor: if (onOff === false) {
                       "gray"
                   } else {
                       "black"
                   }

        onOnOffChanged: changeBox.insert(changeBox.cursorPosition, "_")

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (parent.onOff === false) {
                    parent.onOff = true
                } else {
                    parent.onOff = false
                }
            }
        }
    }

    ESButton {
        id: strikeToggle
        property bool onOff: strike
        icon: "../icons/format-text-strikethrough.svg"
        height: parent.height
        width: parent.height
        fillcolor: if (onOff === false) {
                       "gray"
                   } else {
                       "black"
                   }

        onOnOffChanged: changeBox.insert(changeBox.cursorPosition, "~~")

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (parent.onOff === false) {
                    parent.onOff = true
                } else {
                    parent.onOff = false
                }
            }
        }
    }

    Rectangle {
        height: parent.height
        width: 1
        color: "black"
    }
}
