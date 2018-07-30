import QtQuick 2.11
import QtQuick.Controls 2.2
import Process 1.0

import "../theme"
import "../plugins"
import "../Educator"

import "../Educator/course.js" as Scripts
import "../plugins/text.js" as Scrubber
import "../plugins/markdown.js" as MD
import "./ipfs.js" as IPFS

ESborder {
    id: thisWindow
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    height: cColumn.height + 50 + buttonRow.height

    property string field: ""
    property string where: ""
    property real itemId: 0
    property string existing: ""
    property string newfile: ""

    onStateChanged: if (state == "Active") {
                        existing = Scripts.pullField(field, where, itemId)
                    }

    onFieldChanged: switch (field) {
                    case "rq":
                        Scripts.loadQuestions(1)
                        break
                    case "gq":
                        Scripts.loadQuestions(0)
                        break    
                    default:
                        break
                    }

    Column {
        id: cColumn
        width: parent.width * 0.75
        anchors.left: parent.left
        anchors.leftMargin: 10
        spacing: 10
        padding:10

        Item {
            width: parent.width
            height: title.height

            Text {
                id: title
                anchors.horizontalCenter: parent.horizontalCenter
                text: switch (field) {
                      case "gq":
                          "Guiding Questions"
                          break
                      case "rq":
                          "Review Questions"
                          break
                      case "studentProduct":
                          "Student Activity"
                          break
                      default:
                          field
                          break
                      }

                font.pointSize: 18
            }

            Button {
                visible: switch (field) {
                         case "rq":
                             true
                             break
                         default:
                             false
                             break
                         }
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.bottom: parent.bottom
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

            width: parent.width * 0.99
            anchors.horizontalCenter: parent.horizontalCenter
            height: 3
            color: seperatorColor
        }
        ScrollView {
            id: view
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.98
            clip: true
            height: switch (field) {
                    case "Title": if(contentHeight > 10) {
                        contentHeight + 10
                        } else {
                            40
                        }

                        break
                    default:
                        thisWindow.height * 0.75
                        break
                    }
            background: ESTextField {
            }

            TextArea {
                id: changeBox

                visible: switch (thisWindow.field) {
                         case "rq":
                             false
                             break
                         default:
                             true
                             break
                         }
                anchors.fill: parent
                horizontalAlignment: Text.AlignLeft
                wrapMode: Text.WordWrap
                selectByMouse: true
                text: Scrubber.recoverSpecial(existing)
                padding: 5

            }

            ListView {
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.98
                height: contentHeight
                spacing: 10
                clip: true

                model: switch (thisWindow.field) {
                       case "rq":
                           rqList
                           break
                       }

                delegate: Rectangle {
                    color: if (index % 2) {
                               "#FFFFFF"
                           } else {
                               "#F1F1F1"
                           }
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.99
                    height: if (reviewQuestionBlock.height > reviewAnswerBlock.height) {
                                reviewQuestionBlock.height * 1.1
                            } else {
                                reviewAnswerBlock.height * 1.1
                            }
                    Row {
                        width: parent.width * 0.99
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
                                text: Scrubber.recoverSpecial(question)
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
                                text: Scrubber.recoverSpecial(answer)
                            }
                        }
                    }
                }
            }
        }

        Rectangle {
            anchors.left: parent.left
            anchors.leftMargin: 20
            width: parent.width
            height: 20
            color: "#45FAFAFA"

            Button {
                text: qsTr("Add Image")
                onClicked: {
                    fileadd.type = "general"
                    fileadd.visible = true
                }
                background: ESTextField {
                }
            }
        }
    }

    Rectangle {
        anchors.left: cColumn.right
        anchors.right: parent.right
        anchors.top: cColumn.top
        anchors.topMargin: 20
        anchors.rightMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.1
        color: "#50F0F0F0"
        clip: true

        MarkDown {
            id: mdlist
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            height: parent.height
            width: thisWindow.width * 0.22
            thedata: MD.guide()
        }
    }

    Row {
        id: buttonRow
        anchors.bottomMargin: 10
        anchors.bottom: parent.bottom
        width: parent.width * 0.98
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: parent.width * 0.39

        Button {

            width: parent.width * 0.30
            background: ESTextField {
            }

            text: qsTr("Cancel")

            onClicked: {
                thisWindow.state = "inActive"
            }
        }

        Button {

            width: parent.width * 0.30
            background: ESTextField {
            }
            text: qsTr("Okay")

            onClicked: {

                switch (field) {
                case "Title":
                    Scripts.editField(field, where, itemId,
                                      changeBox.text.replace(/ /g, "_").trim())
                    break
                case "rq":
                    Scripts.editField(field, where, itemId,
                                      reviewQuestions.toString())
                    break
                default:
                    Scripts.editField(field, where, itemId,
                                      Scrubber.replaceSpecials(changeBox.text))
                    break
                }

                thisWindow.state = "inActive"
            }
        }
    }

    QuestionWizard {
        id: newQuestion
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.90
        state: "inActive"
        onStateChanged: if (state == "inActive") {
                            switch (field) {
                            case "rq":
                                Scripts.loadQuestions(1)
                                break
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
        onReadyRead: {
            newfile = readAll()
            changeBox.text = changeBox.text+"\n ![IMG]("+IPFS.mediaAdd(newfile,type)+")"
        }
    }

}
