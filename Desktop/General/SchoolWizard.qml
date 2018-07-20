import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.LocalStorage 2.0 as Sql

import "../theme"
import "../plugins"

import "./OSAuth.js" as Auth
import "./schoolwizard.js" as Scripts
import "./general.js" as Standard
import "./network.js" as Network

ESborder {
    id: thisWindow
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    onStateChanged: if (state == "Active") {
                        if (Scripts.checklocal("user") === true) {

                            view.currentIndex = 1
                        } else {
                            console.log("Checking for Educator based on " + userID)
                            Network.checkOpenSeed(userID, userCode, "Educator")
                        }
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

            /* Personal Info */
            Column {
                width: parent.width
                spacing: parent.width * 0.02
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Personal")
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
                                text: qsTr("General:")
                            }

                            TextField {
                                id: firstnameBox
                                width: parent.width
                                placeholderText: qsTr("First Name")
                                background: ESTextField {
                                }
                            }
                            TextField {
                                id: lastnameBox
                                width: parent.width
                                placeholderText: qsTr("Last Name")
                                background: ESTextField {
                                }
                            }
                            TextField {
                                id: emailBox
                                width: parent.width
                                placeholderText: qsTr("Email Address")
                                background: ESTextField {
                                }
                            }

                            Switch {
                                id: isEducator
                                anchors.right: parent.right
                                text: "Educator"
                                checked: atype
                            }

                            Text {
                                text: qsTr("Optional:")
                            }

                            TextField {
                                id: phoneBox
                                width: parent.width
                                placeholderText: qsTr("Phone #")
                                background: ESTextField {
                                }
                            }
                            TextField {
                                id: countryBox
                                width: parent.width
                                placeholderText: qsTr("Country")
                                background: ESTextField {
                                }
                            }
                            TextField {
                                id: stateBox
                                width: parent.width
                                placeholderText: qsTr("State")
                                background: ESTextField {
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
                        height: parent.height

                        Text {
                            id: aboutTitle
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            text: qsTr("About:")
                        }

                        TextArea {
                            id: aboutBox
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: aboutTitle.bottom
                            anchors.bottom: parent.bottom
                            width: parent.width * 0.95
                            wrapMode: Text.WordWrap
                            padding: 10
                            background: ESTextField {
                            }
                        }
                    }
                }
            }
        }
        Item {
            id: secondPage

            Item {
                width: parent.width
                height: parent.height
                visible: if (isEducator.checked == true) {
                             true
                         } else {
                             false
                         }

                /* School Info */
                Column {
                    width: parent.width
                    spacing: parent.width * 0.02

                    Row {
                        width: parent.width
                        height: title.height
                        clip: true
                        Text {
                            id: title
                            width: parent.width * 0.80
                            text: qsTr("Educational Institution")
                            font.pointSize: 20
                        }

                        Switch {
                            id: isFreeLance
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width * 0.20
                            text: "Free Lance"
                        }
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
                                text: qsTr("About:")
                            }

                            TextArea {
                                id: schoolaboutBox
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: aboutSchoolTitle.bottom
                                anchors.bottom: parent.bottom
                                width: parent.width * 0.95
                                wrapMode: Text.WordWrap
                                background: ESTextField {
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

                            Column {
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width * 0.95
                                spacing: width * 0.03

                                Text {
                                    text: qsTr("General:")
                                }

                                TextField {
                                    id: schoolNameBox
                                    width: parent.width
                                    placeholderText: qsTr("School Name")
                                    background: ESTextField {
                                    }
                                }

                                TextField {
                                    id: schoolEmailBox
                                    width: parent.width
                                    placeholderText: qsTr(
                                                         "School Email Address")
                                    background: ESTextField {
                                    }
                                }

                                Button {
                                    anchors.right: parent.right

                                    text: qsTr("Join Existing School")
                                    background: ESTextField {
                                    }

                                    onClicked: joinSchool.state = "Active"
                                }

                                Text {
                                    text: qsTr("Optional:")
                                }

                                TextField {
                                    id: schoolphoneBox
                                    width: parent.width
                                    placeholderText: qsTr("Phone #")
                                    background: ESTextField {
                                    }
                                }
                                TextField {
                                    id: schoolcountryBox
                                    width: parent.width
                                    placeholderText: qsTr("Country")
                                    background: ESTextField {
                                    }
                                }
                                TextField {
                                    id: schoolstateBox
                                    width: parent.width
                                    placeholderText: qsTr("State")
                                    background: ESTextField {
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        Item {
            id: forthPage
            /* Finish */
            Column {
                width: parent.width
                spacing: parent.width * 0.02
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Setup Complete")
                    font.pointSize: 20
                }
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.94
                    height: 4
                    color: seperatorColor
                }

                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.6
                    fillMode: Image.PreserveAspectFit
                    source: "/img/Banner.png"
                    opacity: 1
                    z: -1
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter

                    text: qsTr("You are now all set to begin using the system.")
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
                       login.state = "Active"
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
        onClicked: if (view.currentIndex < view.count - 1) {
                       if (view.currentIndex == 0 && firstnameBox.length > 1
                               && lastnameBox.length > 1
                               && emailBox.length > 1) {
                           Auth.save_local(userID, isEducator.checked,
                                           firstnameBox.text, lastnameBox.text,
                                           emailBox.text, phoneBox.text,
                                           countryBox.text, stateBox.text,
                                           aboutBox.text,
                                           Standard.oneTime(userID, 1))
                       } else if (view.currentIndex == 1
                                  && schoolNameBox.length > 1
                                  && schoolEmailBox.length > 1
                                  || isFreeLance.checked === 1) {
                           Scripts.saveSchool(userID, isFreeLance.checked,
                                              schoolNameBox.text,
                                              schoolEmailBox.text,
                                              schoolphoneBox.text,
                                              schoolcountryBox.text,
                                              schoolstateBox.text,
                                              schoolaboutBox.text,
                                              Standard.oneTime(userID, 1))
                       }
                       view.currentIndex = view.currentIndex + 1
                   } else {
                       educatorHome.state = "Active"
                   }
    }

    PageIndicator {
        id: indicator

        count: view.count
        currentIndex: view.currentIndex

        anchors.bottom: view.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

    ListModel {
        id: courseList

        ListElement {
            type: 1
            name: "Add Course"
        }
    }

    ESborder {
        id: joinSchool
        state: "inActive"
        width: 400
        height: schoolfinder.height + 40
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Column {
            id: schoolfinder
            anchors.centerIn: parent
            width: parent.width * 0.98
            spacing: thisWindow.width * 0.03

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                font.bold: true
                font.pointSize: 12
                text: qsTr("Join existing school")
            }

            Rectangle {

                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.95
                height: 3
                color: seperatorColor
            }

            Text {
                width: parent.width * 0.85
                wrapMode: Text.WordWrap
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                text: if (schoolName.length == 0) {
                          "Searching..."
                      } else {
                          schoolName.replace(/_/g, " ")
                      }
            }

            TextField {
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                width: parent.width * 0.6
                background: ESTextField {
                }
                placeholderText: qsTr("Enter School Code")
                onTextChanged: Network.retrieveFromOpenSeed(text,
                                                            text, "School")
            }

            Row {
                id: buttonRow
                //anchors.bottomMargin: 10
                //anchors.bottom: parent.bottom
                width: parent.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: parent.width * 0.39

                Button {

                    width: parent.width * 0.30
                    background: ESTextField {
                    }

                    text: qsTr("Cancel")

                    onClicked: {
                        joinSchool.state = "inActive"
                    }
                }

                Button {

                    width: parent.width * 0.30
                    background: ESTextField {
                    }
                    text: qsTr("Okay")

                    onClicked: {

                        view.currentIndex = view.count - 1
                        joinSchool.state = "inActive"
                    }
                }
            }
        }
    }
}
