import QtQuick 2.11
import QtQuick.Controls 2.2

import "./theme"
import "./plugins"

import "./course.js" as Scripts

Item {
id:thisWindow

property real coursenumber: 0
property string courseName: "Course Name"

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
                duration: 40
                easing.type: Easing.InOutQuad
            }
        }
    ]

    state:"inActive"

    onStateChanged: if(state == "Active") {Scripts.loadCourse(userid,coursenumber)
                                            Scripts.loadUnits(userid,coursenumber)} else {}

    Text {
        id:title
        text: courseName
        anchors.top:parent.top
        anchors.left: backbutton.right
        anchors.margins: 20
        font.bold: true
        font.pointSize: 15

        Image {
            anchors.left:parent.right
            anchors.bottom:parent.bottom
            source:"./icons/edit-text.svg"
            width:parent.height * 0.5
            height:parent.height * 0.5
            fillMode: Image.PreserveAspectFit

            MouseArea {
                anchors.fill: parent
                onClicked: {editthis.field = "Title"
                            editthis.where = "course"
                            editthis.itemId = coursenumber
                            editthis.state = "Active" }
            }
        }
    }

    Rectangle {
        id:backbutton
        anchors.top:parent.top
        anchors.left:parent.left
        anchors.margins: 20
        height:title.height
        width:title.height
        radius:width /2
        color:seperatorColor
        MouseArea {
            anchors.fill: parent
            onClicked: { thisWindow.state = "inActive"
                         general.state = "Active"

                        }
        }
    }

    Button {
        anchors.verticalCenter: title.verticalCenter
        //anchors.top:parent.top
        anchors.right:parent.right
        anchors.margins: 20
        text:qsTr("Add Unit")
        background:ESTextField {}
        onClicked: {newUnit.state = "Active" }
    }


    Rectangle {
        anchors.top:title.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.95
        height: 3
        color: seperatorColor
    }

    Item {
        anchors.top:title.bottom
        anchors.topMargin: 24
        anchors.bottom:parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width * 0.98
       // contentHeight: cColumn.height * 1.02
        clip: true
        Column {
            anchors.top: parent.top
            anchors.topMargin: 10
            id: cColumn
            width: parent.width
            spacing: mainView.width * 0.01


            ListView {
                anchors.horizontalCenter: parent.horizontalCenter
                width:thisWindow.width * 0.98
                height:contentHeight * 1.1
                clip:true
                spacing: thisWindow.height * 0.02

                model:unitList

                delegate: ESborder {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width:thisWindow.width * 0.98
                            height:if(lessons.height > unitColumn.height) {lessons.height * 1.05} else {unitColumn.height* 1.05}


                            Row {
                                anchors.horizontalCenter: parent.horizontalCenter
                                width:parent.width * 0.98
                                height:if(lessons.height > unitColumn.height) {lessons.height} else {unitColumn.height}



                            Column {
                                id:unitColumn

                                width:parent.width * 0.40
                                spacing:thisWindow.height * 0.02

                                Text {
                                    padding: 10
                                    text:name
                                    font.bold: true
                                    font.pointSize: 12
                                }

                                Rectangle {

                                    anchors.horizontalCenter: parent.horizontalCenter
                                    width: parent.width * 0.95
                                    height: 2
                                    color: seperatorColor
                                }

                                Text {

                                    text: about
                                    padding: 15
                                    width:parent.width * 0.8
                                    wrapMode: Text.WordWrap
                                }

                            }

                            ListView {
                                id:lessons
                                height:contentHeight
                                width:parent.width * 0.60
                                spacing:thisWindow.height * 0.02



                                model: CDBUnit{thedate: cdate}

                                delegate: ESborder {
                                                width:thisWindow.width * 0.58
                                                height:lessonColumn.height * 1.1


                                            Column {
                                                id:lessonColumn
                                                width:parent.width * 0.99
                                                spacing:thisWindow.height * 0.01

                                                anchors.centerIn: parent

                                                Text {
                                                    text:name
                                                    padding: 10
                                                }

                                                Rectangle {

                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                    width: parent.width * 0.98
                                                    height: 1
                                                    color: seperatorColor
                                                }

                                                Text {
                                                    text:about
                                                    padding: 10
                                                    width:parent.width * 0.9
                                                    wrapMode: Text.WordWrap
                                                }
                                            }
                                }

                            }



                         }

                      MouseArea {
                          anchors.fill:parent
                          z:2
                          onClicked: {
                              editUnit.unitNumber = cdate
                              editUnit.state = "Active"

                          }
                      }




                }
            }
        }

    }

    ListModel {
        id:unitList
    }



    UnitWizard {
        id:newUnit
        anchors.horizontalCenter:thisWindow.horizontalCenter
        anchors.verticalCenter: thisWindow.verticalCenter

        width: 800
        state: "inActive"

        onStateChanged: {
                Scripts.loadUnits(userid,coursenumber)
        }
    }

    UnitEditor {
        id:editUnit
        anchors.horizontalCenter:thisWindow.horizontalCenter
        anchors.verticalCenter: thisWindow.verticalCenter
        height:parent.height
        width:parent.width
        state: "inActive"

    }

}
