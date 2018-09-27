import QtQuick 2.11
import QtQuick.Controls 2.2
import Process 1.0

import "../theme"
import "../plugins"
import "../General"
import "../General/ipfs.js" as IPFS
import "../plugins/text.js" as Scrubber
import "../plugins/spellcheck.js" as Spelling

Item {
    id: thisWindow
    width: parent.width * 0.98
    height: parent.height * 0.98

    Timer {
        id: checker
        interval: 2000
        repeat: false
        running: true
        onTriggered: {
            var thestring = lessonNotes.getText(0, lessonNotes.length)
            lessonUpdate = Scrubber.replaceSpecials(thestring)
            lessonNotes.text = Spelling.checkspelling(thestring)
            lessonNotes.cursorPosition = lessonNotes.length
        }
    }

    ESborder {
        id: noteBlock
        anchors.left: parent.left
        width: parent.width * 0.98
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.01

        Text {
            id: title
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: 10
            font.bold: true
            font.pointSize: 12
            text: qsTr("Post")
        }

        EditorOpts {
            id: editorOpts
            anchors.right: noteScroll.right
            anchors.verticalCenter: title.verticalCenter
        }

        Rectangle {
            anchors.top: editorOpts.bottom
            anchors.topMargin: 3
            width: noteScroll.width
            anchors.left: noteScroll.left
            height: 2
            color: seperatorColor
        }

        Text {
            id: preview
            anchors.top: parent.top
            anchors.left: noteMD.left
            anchors.margins: 10
            font.bold: true
            font.pointSize: 12
            text: qsTr("Preview")
        }

        Rectangle {
            anchors.top: editorOpts.bottom
            anchors.topMargin: 3
            width: noteMD.width
            anchors.right: noteMD.right
            height: 2
            color: seperatorColor
        }

        ScrollView {
            id: noteScroll
            anchors.top: title.bottom
            anchors.topMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height * 0.05
            anchors.leftMargin: 10
            anchors.left: parent.left
            width: parent.width * 0.50

            background: ESTextField {
            }

            TextArea {
                id: changeBox
                width: noteBlock.width * 0.50
                height: noteBlock.height * 0.50
                wrapMode: Text.WordWrap
                selectByMouse: true
                property bool controlDown: false

                Keys.onPressed: if (event.key === Qt.Key_Control) {
                                    controlDown = true
                                }
                Keys.onReleased: {
                    if (controlDown === true) {
                        switch (event.key) {
                        case Qt.Key_B:
                            if (editorOpts.bold === true) {
                                editorOpts.bold = false
                            } else {
                                editorOpts.bold = true
                            }
                            break
                        case Qt.Key_I:
                            if (editorOpts.italic === true) {
                                editorOpts.italic = false
                            } else {
                                editorOpts.italic = true
                            }
                            break
                        case Qt.Key_T:
                            if (editorOpts.strike === true) {
                                editorOpts.strike = false
                            } else {
                                editorOpts.strike = true
                            }
                            break
                        }
                        controlDown = false
                    }

                    // checker.restart()
                }
            }
        }

        ScrollView {
            id: noteMD
            anchors.top: title.bottom
            anchors.topMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height * 0.05
            anchors.left: noteScroll.right
            anchors.leftMargin: 3
            anchors.right: parent.right
            anchors.rightMargin: 10
            clip:true
            contentHeight:formatedView.height + 40

            background: ESTextField {
            }

            MarkDown {
                id:formatedView
                width: noteBlock.width * 0.48
                //height: noteBlock.height * 0.50
                thedata: changeBox.text
            }
        }

        Text {
            anchors.top: noteScroll.bottom
            anchors.margins: 5
            anchors.left: noteScroll.left
            text: "Word count: " + (changeBox.text.split(" ").length - 1)
            visible: if ((changeBox.text.split(" ").length - 1) > 0) {
                         true
                     } else {
                         false
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
            changeBox.text = changeBox.text + "\n ![" + media + "](" + IPFS.mediaAdd(
                        newfile, type) + ")"
        }
    }
}
