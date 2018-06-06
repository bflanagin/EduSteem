import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

import "./theme"
import "./plugins"

ESborder {
    id:thisWindow

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter

    states: [

            State {
                name:"Active"
                    PropertyChanges {

                        target:thisWindow
                        opacity:1
                        anchors.verticalCenterOffset: 0

                    }

                },

        State {
            name:"inActive"
                PropertyChanges {

                    target:thisWindow
                    opacity:0
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

    state:"inActive"

    Column {
        anchors.centerIn: parent
        width:parent.width * 0.98
        height:parent.height * 0.98
        spacing: thisWindow.width * 0.01

        Text {
            padding: 10
            text:qsTr("New Account")
            font.pointSize: 20

        }

        Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width:parent.width * 0.98
                    height:5
                    color:seperatorColor
                }

        Row {
            width:parent.width
            height: parent.height * 0.8

            Column {
                //anchors.verticalCenter: parent.verticalCenter
                width:parent.width * 0.48
                padding: 10
                spacing: thisWindow.width * 0.03

                MarkDown {
                    width:parent.width
                    height: thisWindow.height * 0.67
                    thedata: "### Creating an account \n
EduSteem uses OpenSeed for user authentication and the general functionality of the software. \n  **If you already have an OpenSeed account, please login with your account on the previous page.  \n
Funding for both Educators and students is handled by STEEM and the accounts for that system will need to be configured after the setup is complete.\n"
                }

                Row {
                    width:parent.width
                    height: thisWindow.height * 0.1
                    spacing: 10

                    Image {
                        id:steemIcon

                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height * 0.9
                        width: parent.height * 0.9
                        fillMode: Image.PreserveAspectFit
                        source:"./img/steem.png"
                    }






                    Image {
                        id:osIcon

                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height * 0.9
                        width: parent.height * 0.9
                        fillMode: Image.PreserveAspectFit
                        source:"./img/OpenSeed.png"
                    }

                   }



            }

            Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        width:2
                        height:parent.height * 0.98
                        color:seperatorColor
                    }

            Column {

                width:parent.width * 0.48
                padding:10
                spacing: thisWindow.width * 0.04
                Text {
                    text:"Info"
                }

                TextField {
                    width:parent.width * 0.98
                    anchors.horizontalCenter: parent.horizontalCenter
                    placeholderText:qsTr("User Name")
                    background:ESTextField{}
                }

                TextField {
                    width:parent.width * 0.98
                    anchors.horizontalCenter: parent.horizontalCenter
                    placeholderText:qsTr("Email Address")
                    background:ESTextField{}
                }
                TextField {
                    width:parent.width * 0.98
                    anchors.horizontalCenter: parent.horizontalCenter
                    placeholderText:qsTr("Passphase")
                    background:ESTextField{}
                }
                Text {
                   // width:parent.width * 0.98
                    anchors.horizontalCenter: parent.horizontalCenter
                    text:qsTr("New User")

                }

                Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width:parent.width * 0.94
                            height:4
                            color:seperatorColor
                        }

                Item {
                    width:parent.width
                    height: thisWindow.height * 0.1

                    Button {
                        anchors.left: parent.left
                        text:qsTr("Back")
                        width:parent.width * 0.20
                        background: ESTextField{}

                        onClicked: { login.state = "Active"
                                     thisWindow.state = "inActive"
                                    }
                    }

                Button {
                    anchors.right: parent.right
                    text:qsTr("Next")
                    width:parent.width * 0.20
                    background: ESTextField{}

                    onClicked: { schoolSetup.state = "Active"
                                 thisWindow.state = "inActive"
                                }
                }

                }

            }
        }
    }


}
