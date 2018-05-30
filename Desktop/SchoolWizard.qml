import QtQuick 2.11
import QtQuick.Controls 2.2
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

    SwipeView {
        id: view
        clip:true
        currentIndex: 0
        width:parent.width * 0.95
        height:parent.height * 0.9
        anchors.centerIn: parent
        interactive: false


        Item {
            id: firstPage

            /* Personal Info */

            Column {
                width:parent.width
                spacing: parent.width * 0.02
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text:qsTr("Personal")
                font.pointSize: 20

            }
            Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width:parent.width * 0.94
                        height:4
                        color:seperatorColor
                    }

            Row {
                width:parent.width
                height:thisWindow.height * 0.7

                Item {
                    width:thisWindow.width * 0.48
                    height:parent.height

                    Column {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width:parent.width * 0.98
                        spacing: width * 0.03

                        Text {
                            text:qsTr("General:")
                        }

                        TextField {
                            width:parent.width
                            placeholderText: qsTr("First Name")
                            background: ESTextField{}
                        }
                        TextField {
                            width:parent.width
                            placeholderText: qsTr("Last Name")
                            background: ESTextField{}
                        }
                        TextField {
                            width:parent.width
                            placeholderText: qsTr("Email Address")
                            background: ESTextField{}
                        }

                        Text {
                            text:qsTr("Optional:")
                        }

                        TextField {
                            width:parent.width
                            placeholderText: qsTr("Phone #")
                            background: ESTextField{}
                        }
                        TextField {
                            width:parent.width
                            placeholderText: qsTr("Country")
                            background: ESTextField{}
                        }
                        TextField {
                            width:parent.width
                            placeholderText: qsTr("State")
                            background: ESTextField{}
                        }

                    }

                }

                Rectangle {
                           anchors.verticalCenter: parent.verticalCenter
                            width:1
                            height:parent.height * 0.85
                            color:seperatorColor
                        }

                Item {
                    width:thisWindow.width * 0.48
                    height:parent.height


                    Text {
                        id:aboutTitle
                        anchors.left:parent.left
                        anchors.leftMargin: 10
                        text:qsTr("About:")
                    }

                    TextArea {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top:aboutTitle.bottom
                        anchors.bottom:parent.bottom
                        width:parent.width * 0.95
                        background: ESTextField{}
                    }

                }

            }

            }

        }
        Item {
            id: secondPage

            /* School Info */

            Column {
                width:parent.width
                spacing: parent.width * 0.02
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text:qsTr("Educational Organization")
                font.pointSize: 20

            }
            Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width:parent.width * 0.94
                        height:4
                        color:seperatorColor
                    }

            Row {
                width:parent.width
                height:thisWindow.height * 0.7


                Item {
                    width:thisWindow.width * 0.48
                    height:parent.height


                    Text {
                        id:aboutSchoolTitle
                        anchors.left:parent.left
                        anchors.leftMargin: 10
                        text:qsTr("About:")
                    }

                    TextArea {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top:aboutSchoolTitle.bottom
                        anchors.bottom:parent.bottom
                        width:parent.width * 0.95
                        background: ESTextField{}
                    }

                }

                Rectangle {
                           anchors.verticalCenter: parent.verticalCenter
                            width:1
                            height:parent.height * 0.85
                            color:seperatorColor
                        }

                Item {
                    width:thisWindow.width * 0.48
                    height:parent.height

                    Column {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width:parent.width * 0.95
                        spacing: width * 0.03

                        Text {
                            text:qsTr("General:")
                        }

                        TextField {
                            width:parent.width
                            placeholderText: qsTr("School Name")
                            background: ESTextField{}
                        }


                        Text {
                            text:qsTr("Optional:")
                        }

                        TextField {
                            width:parent.width
                            placeholderText: qsTr("Phone #")
                            background: ESTextField{}
                        }
                        TextField {
                            width:parent.width
                            placeholderText: qsTr("Country")
                            background: ESTextField{}
                        }
                        TextField {
                            width:parent.width
                            placeholderText: qsTr("State")
                            background: ESTextField{}
                        }

                    }

                }

            }

            }
        }
        Item {
            id: thirdPage

            /* Courses */

            Column {
                width:parent.width
                spacing: parent.width * 0.02
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text:qsTr("Courses Offered")
                font.pointSize: 20
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                width:parent.width
                wrapMode: Text.WordWrap
                font.pointSize: 10
                horizontalAlignment: Text.AlignHCenter
                text:qsTr("Here you can setup some or all of the courses your school offers. You can also setup courses within the main interface if you would like to skip this page.")

            }
            Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width:parent.width * 0.94
                        height:4
                        color:seperatorColor
                    }

            Row {
                width:parent.width
                height:parent.height * 0.7


                Item {
                    width:thisWindow.width * 0.48
                    height:parent.height

                    ListView {
                        anchors.centerIn: parent
                        width:parent.width * 0.98
                        height:parent.height * 0.90
                        spacing: width * 0.01
                        clip:true
                        model: courseList

                        delegate: Item {
                                    width:parent.width
                                    height:thisWindow.width * 0.06
                                Rectangle {
                                    anchors.centerIn: parent
                                    width:parent.width * 0.99
                                    height:parent.height * 0.99
                                    border.color: seperatorColor
                                    border.width: 1
                                    radius: 5
                                }

                                Text {
                                    anchors.left:parent.left
                                    anchors.leftMargin: 10
                                    text:name
                                }

                        }

                    }

                }

                Rectangle {
                           anchors.verticalCenter: parent.verticalCenter
                            width:1
                            height:parent.height * 0.85
                            color:seperatorColor
                        }

                Item {
                    width:thisWindow.width * 0.48
                    height:parent.height

                    Text {
                        id:aboutCourseTitle
                        anchors.left:parent.left
                        anchors.leftMargin: 10
                        text:qsTr("About:")
                    }

                    TextArea {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top:aboutCourseTitle.bottom
                        anchors.bottom:parent.bottom
                        width:parent.width * 0.95
                        background: ESTextField{}
                    }
                }

            }

            }
        }

        Item {
            id: forthPage
            /* Finish */
            Column {
                width:parent.width
                spacing: parent.width * 0.02
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text:qsTr("Setup Complete")
                font.pointSize: 20
            }
            Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width:parent.width * 0.94
                        height:4
                        color:seperatorColor
                    }

            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                width:parent.width * 0.6
                fillMode: Image.PreserveAspectFit
                source:"./img/Banner.png"
                opacity: 1
                z:-1

            }

            Text {
                 anchors.horizontalCenter: parent.horizontalCenter

                text:qsTr("You are now all set to begin using the system.")
            }

            }


        }
    }

    Button {
        id:backbutton
        anchors.left: parent.left
        anchors.bottom:parent.bottom
        anchors.margins: 20
        text:"Back"
        background: ESTextField{}
        onClicked: if(view.currentIndex> 0) {view.currentIndex = view.currentIndex -1}
    }

    Button {
        id:forwardbutton
        anchors.right: parent.right
        anchors.bottom:parent.bottom
        anchors.margins: 20
        text:if(view.currentIndex < view.count-1) {"Next"} else {"Finish"}
        background: ESTextField{}
        onClicked: if(view.currentIndex < view.count-1) {view.currentIndex = view.currentIndex + 1} else {educatorHome.state = "Active" }

    }

    PageIndicator {
        id: indicator

        count: view.count
        currentIndex: view.currentIndex

        anchors.bottom: view.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }


    ListModel {
        id:courseList

        ListElement {
           type: 1
           name: "Add Course"
        }
    }

}
