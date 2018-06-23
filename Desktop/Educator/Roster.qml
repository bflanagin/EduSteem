import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import QtQuick.LocalStorage 2.0 as Sql

import "../plugins"
import "../theme"

import "students.js" as Scripts
import "../General/network.js" as Network

Item {

    id:thisWindow
states: [

        State {
            name:"Active"
                PropertyChanges {

                    target:thisWindow
                    opacity:1
                    x: leftMenu.width

                }

            },

    State {
        name:"inActive"
            PropertyChanges {

                target:thisWindow
                opacity:0
                x: -parent.width
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
            properties: "opacity,x"
            duration: 100
            easing.type: Easing.InOutQuad
        }
    }
]

state:"inActive"

onStateChanged: if(state == "Active") {Scripts.loadStudents(schoolCode)
                                        rightMenu.state = "Active"}


Rectangle {
    anchors.fill:parent
}

Text {
    id:title
    text: qsTr("Student Roster")
    anchors.top:parent.top
    anchors.left: backbutton.right
    anchors.margins: 20
    font.bold: true
    font.pointSize: 15
}

CircleButton {
    id:backbutton
    anchors.top:parent.top
    anchors.left:parent.left
    anchors.margins: 20
    height:title.height
    width:title.height

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
    text:qsTr("Add Student")
    background:ESTextField {}
    onClicked: {newStudent.state = "Active" }
}


Rectangle {
    anchors.top:title.bottom
    anchors.topMargin: 20
    anchors.horizontalCenter: parent.horizontalCenter
    width: parent.width * 0.95
    height: 3
    color: seperatorColor
}

ListView {
    anchors.top:title.bottom
    anchors.topMargin: 30
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom:parent.bottom
    clip:true
    width:parent.width * 0.98
    spacing: 10

    model:studentList

    delegate: Rectangle {
                color:if(index %2 ) {"#FEFEFE"} else {"#F9F9F9"}
                anchors.horizontalCenter: parent.horizontalCenter
                width:parent.width * 0.99
                height:studentName.height + 40
                Component.onCompleted:  Network.checkOpenSeed(userid, cdate, edate,
                                                              "Students")
                Text {
                    id:studentName
                    anchors.left:parent.left
                    anchors.leftMargin: 20
                    font.pointSize: 12
                    anchors.verticalCenter: parent.verticalCenter
                    text:name
                }

                Text {
                    id:show
                    anchors.right:parent.right
                    anchors.margins: 5
                    anchors.bottom:parent.bottom
                    font.pointSize: 6
                    text:qsTr("Click for detailed information")
                    visible: false
                }

                MouseArea {
                    anchors.fill: parent
                        hoverEnabled: true
                    onEntered: {rightMenu.studentID=cdate
                                    rightMenu.studentID=cdate
                                    show.visible = true
                                }
                    onExited: {
                            show.visible = false
                    }

                    onClicked: {student.studentCode =cdate
                                student.state = "Active"
                                thisWindow.state = "inActive"
                                }
                }
                Rectangle {
                    anchors.bottom:parent.bottom
                    anchors.bottomMargin: -10
                    anchors.horizontalCenter: parent.horizontalCenter
                    width:parent.width * 0.98
                    height: 1
                    color:highLightColor1
                }
    }

}

}
