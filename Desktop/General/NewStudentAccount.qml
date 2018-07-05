import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.LocalStorage 2.0 as Sql

import "../theme"
import "../Educator/students.js" as Scripts

ESborder {
    id: thisWindow

    height: cColumn.height * 1.1

    onStateChanged: if (state == "inActive") {
                        firstNameBox.text = ""
                        lastNameBox.text = ""
                        ageBox.text = ""
                        bdayBox.text = ""
                        aboutStudent.text = ""
                        //schoolID.text = ""
                        contactNumber.text = ""
                        emailAddress.text = ""
                        view.currentIndex = 0
                    }

    Column {
        anchors.top: parent.top
        anchors.topMargin: 15
        id: cColumn

        width: parent.width
        spacing: parent.width * 0.02

        Text {
            anchors.left: parent.left
            anchors.leftMargin: 10
            text: qsTr("New Student")
            font.pointSize: 20
        }
        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.94
            height: 4
            color: seperatorColor
        }

        SwipeView {
            id: view
            clip: true
            currentIndex: 0
            width: parent.width * 0.94
            anchors.horizontalCenter: parent.horizontalCenter
            height: 300
            interactive: false

            Item {
                id: firstPage

                Column {
                    width: parent.width
                    spacing: 20

                    Text {
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        text: qsTr("General Information")
                        font.italic: true
                    }

                    TextField {
                        id: firstNameBox
                        width: parent.width * 0.95
                        anchors.horizontalCenter: parent.horizontalCenter
                        placeholderText: qsTr("First Name")
                        background: ESTextField {
                        }
                    }
                    TextField {
                        id: lastNameBox
                        width: parent.width * 0.95
                        anchors.horizontalCenter: parent.horizontalCenter
                        placeholderText: qsTr("Last Name")
                        background: ESTextField {
                        }
                    }
                    Item {
                        width: parent.width
                        height: ageBox.height + 10
                        TextField {
                            id: ageBox
                            width: parent.width * 0.15
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            anchors.verticalCenter: parent.verticalCenter
                            placeholderText: qsTr("Age")
                            background: ESTextField {
                            }
                        }
                        Text {
                            anchors.right: bdayBox.left
                            anchors.verticalCenter: parent.verticalCenter
                            text: qsTr("Birthday:")
                        }

                        TextField {
                            id: bdayBox
                            width: parent.width * 0.20
                            anchors.right: parent.right
                            anchors.rightMargin: 20
                            anchors.verticalCenter: parent.verticalCenter
                            placeholderText: qsTr("dd/mm/yyyy")
                            background: ESTextField {
                            }
                        }
                    }
                }
            }

            Item {
                id: secondPage

                Column {
                    width: parent.width
                    spacing: 10


                    /* Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    width: parent.width
                    text: qsTr("Micro scholarships are handled through the Steem. We use the post token of a valid account to send post to the network.")
                    wrapMode: Text.WordWrap
                    font.pointSize: 8
                }

                TextField {
                    id: steemPostToken
                    width: parent.width * 0.95
                    anchors.horizontalCenter: parent.horizontalCenter
                    placeholderText: qsTr("Steem Post Token")
                    background: ESTextField {
                    }
                }*/
                    Text {
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        text: qsTr("School:")
                        font.bold: true
                    }
                    Item {
                        width: parent.width
                        height: schoolID.height
                        TextField {
                            id: schoolID
                            width: parent.width * 0.40
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            placeholderText: qsTr("School ID")
                            background: ESTextField {
                            }
                            text: if (schoolCode.length > 2) {
                                      schoolCode
                                  }
                        }

                        Text {
                            anchors.left: schoolID.right
                            anchors.verticalCenter: schoolID.verticalCenter
                            anchors.leftMargin: 3
                            font.pointSize: 6
                            text: qsTr("(ID for the school the child is attending)")
                        }
                    }
                    Text {
                        anchors.left: parent.left
                        anchors.leftMargin: 5
                        text: qsTr("Notes:")
                        font.bold: true
                    }

                    ScrollView {
                        width: parent.width * 0.95
                        height: 180
                        contentHeight: aboutStudent.height
                        anchors.horizontalCenter: parent.horizontalCenter
                        background: ESTextField {
                        }
                        TextArea {
                            id: aboutStudent
                            width: parent.width

                            placeholderText: qsTr("Anything")
                        }
                    }
                }
            }

            Item {
                id: thirdPage

                Column {
                    width: parent.width
                    spacing: 20

                    Text {
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        text: qsTr("Optional:")
                        font.bold: true
                    }

                    Text {
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        font.italic: true
                        text: qsTr("Parent/Guardian")
                    }

                    TextField {
                        id: contactNumber
                        width: parent.width * 0.95
                        anchors.horizontalCenter: parent.horizontalCenter
                        placeholderText: qsTr("Contact Number")
                        background: ESTextField {
                        }
                    }

                    TextField {
                        id: emailAddress
                        width: parent.width * 0.95
                        anchors.horizontalCenter: parent.horizontalCenter
                        placeholderText: qsTr("Email Address")
                        background: ESTextField {
                        }
                    }
                }
            }

            Item {
                id: forthPage
                Column {
                    width: parent.width
                    spacing: 20

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        wrapMode: Text.WordWrap
                        width: parent.width * 0.94
                        text: qsTr("All setup, for security reasons the steemit account the student is connected to is setup on the computer the student uses. Please instruct the student to do so at their earliest convenience.")
                    }

                    Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width * 0.94
                        height: 1
                        color: seperatorColor
                    }
                }
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

                text: if (view.currentIndex != 0) {
                          qsTr("Back")
                      } else {
                          qsTr("Cancel")
                      }

                onClicked: {
                    if (text == "Back") {
                        view.currentIndex = view.currentIndex - 1
                    } else {
                        thisWindow.state = "inActive"
                    }
                }
            }

            Button {

                width: parent.width * 0.30
                background: ESTextField {
                }
                text: if (view.currentIndex < view.count - 1) {
                          qsTr("Next")
                      } else {
                          qsTr("Okay")
                      }

                onClicked: {

                    if (text == "Okay" && firstNameBox.text.length > 1
                            && lastNameBox.text.length > 1) {
                        Scripts.saveStudent(userid, firstNameBox.text,
                                            lastNameBox.text, ageBox.text,
                                            bdayBox.text, aboutStudent.text,
                                            schoolID.text, contactNumber.text,
                                            emailAddress.text)
                        thisWindow.state = "inActive"
                    } else {
                        view.currentIndex = view.currentIndex + 1
                    }
                }
            }
        }
    }

    PageIndicator {
        id: indicator

        count: view.count
        currentIndex: view.currentIndex

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
