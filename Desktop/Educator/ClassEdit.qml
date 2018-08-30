import QtQuick 2.11
import QtQuick.LocalStorage 2.0 as Sql
import QtQuick.Controls 2.4

import "../theme"
import "../plugins"
import "./course.js" as Scripts
import "./scheduler.js" as Schedule

import "../theme"

ESborder {
    id: thisWindow
    height: cColumn.height + 50
    property string day: "day"
    property int month: 0
    property bool edit: false
    property int repeatMode:3
    property real classNum:0
    property string className:""

    onStateChanged: if (state == "Active") {

                        Scripts.loadCourses(userID)
                        courseList.append({
                                              name: "Lunch",
                                              cdate: 12
                                          })
                        courseList.append({
                                              name: "Read to self",
                                              cdate: 10
                                          })
                        courseList.append({
                                              name: "P.E.",
                                              cdate: 8
                                          })
                    }


    onEditChanged: if(edit == true) {
                       Schedule.load_Class(classNum,selected_month)
                   }

    Column {
        id: cColumn
        width: parent.width * 0.95
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: thisWindow.width * 0.03
        Item {
            width:parent.width
            height:title.height
        Text {
            id: title
            anchors.left: parent.left
            anchors.leftMargin: 10
            text: if(edit == false) {"Adding class"} else {"Editing "+className}
            font.pointSize: 18
        }

        Button {
            anchors.right:parent.right
            anchors.rightMargin: 10
            text:qsTr("Remove")
            background: ESTextField {}
            onClicked: { Schedule.save_schedule(
                           month, "0:" + classNum
                           + "," + sunday.checked + "," + monday.checked
                           + "," + tuesday.checked + "," + wednesday.checked
                           + "," + thursday.checked + "," + friday.checked
                           + "," + saturday.checked , 0,edit)

                thisWindow.classNum = 0
                thisWindow.edit = false
                thisWindow.state = "inActive"
            }
        }

        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.98
            height: 3
            color: seperatorColor
        }

        Text {
            text: qsTr("Adding a course here will auto poplulate the schedule based on the number of units and the lessons that they contain.")
            width: parent.width
            wrapMode: Text.WordWrap
        }
        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.98
            height: 3
            color: seperatorColor
        }
        Row {
            width: parent.width
            height: courseBox.height
            spacing: parent.width * 0.01

            Item {
                width: parent.width * 0.49
                height: 40
            ComboBox {
                id: courseBox
                visible: if(edit === true) {false} else {true}
                width: parent.width * 0.49
                height: 40
                model: courseList
                spacing: 2
                currentIndex: 0
                textRole: "name"
                background: ESTextField {
                }

                delegate: Item {
                    width: parent.width
                    height: 40
                    Text {
                        anchors.left: parent.left
                        anchors.leftMargin: 5
                        text: if(name.length < 2) {"Select Class"} else {name}
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            courseBox.popup.close()
                            courseBox.currentIndex = index
                        }
                    }
                }
            }

            ESTextField {
                anchors.fill: courseBox
                visible: edit
                Text {
                    anchors.centerIn: parent
                    text:className

                }
            }

            }

            Column {
                width:parent.width * 0.49
                height:parent.height
                spacing: height * 0.03

                Text {
                    text: "Class Options:"
                }

                Rectangle {
                    width:parent.width
                    height:2
                    color:seperatorColor
                }

                Row {
                    width:parent.width
                RadioButton {
                    id:allYearRadio
                    text:qsTr("All Year")
                    checked: true
                    onCheckedChanged: if(checked == true) {repeatMode = 3}
                }
                RadioButton {
                    id:firstSemesterRadio
                    text:qsTr("1st Semester")
                    onCheckedChanged: if(checked == true) {repeatMode = 1}
                }
                RadioButton {
                    id:secondSemesterRadio
                    text:qsTr("2nd Semester")
                    onCheckedChanged: if(checked == true) {repeatMode = 1}
                }
                }
                CheckBox {
                    id:noAssignments
                    text:qsTr("No Assignments")
                }



            }
        }

        Text {
            text: "Schedule:"
        }
        Row {
            width: parent.width
            height: 50

            RadioButton {
                id: everyday
                text: qsTr("Every Day")
            }
            RadioButton {
                id: oddday
                text: qsTr("Mon, Wed, Fri")
            }
            RadioButton {
                id: evenday
                text: qsTr("Tue, Thu")
            }
        }

        Row {
            width: parent.width
            height: 50

            CheckBox {
                id: sunday
                text: qsTr("Sun")
                width: parent.width / 7
            }

            CheckBox {
                id: monday
                text: qsTr("Mon")
                width: parent.width / 7
                checked: if (oddday.checked === true
                                 || everyday.checked === true) {
                             true
                         } else {
                             false
                         }
            }
            CheckBox {
                id: tuesday
                text: qsTr("Tue")
                width: parent.width / 7
                checked: if (evenday.checked === true
                                 || everyday.checked === true) {
                             true
                         } else {
                             false
                         }
            }
            CheckBox {
                id: wednesday
                text: qsTr("Wed")
                width: parent.width / 7
                checked: if (oddday.checked === true
                                 || everyday.checked === true) {
                             true
                         } else {
                             false
                         }
            }
            CheckBox {
                id: thursday
                text: qsTr("Thu")
                width: parent.width / 7
                checked: if (evenday.checked === true
                                 || everyday.checked === true) {
                             true
                         } else {
                             false
                         }
            }
            CheckBox {
                id: friday
                text: qsTr("Fri")
                width: parent.width / 7
                checked: if (oddday.checked == true
                                 || everyday.checked === true) {
                             true
                         } else {
                             false
                         }
            }
            CheckBox {
                id: saturday
                text: qsTr("Sat")
                width: parent.width / 7
            }
        }
        Row {
            id: buttonRow
            // anchors.bottomMargin: 10
            // anchors.bottom: parent.bottom
            width: parent.width * 0.98
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: parent.width * 0.39

            Button {

                width: parent.width * 0.30
                background: ESTextField {
                }

                text: qsTr("Cancel")

                onClicked: {
                    thisWindow.classNum = 0
                    thisWindow.state = "inActive"
                    thisWindow.edit = false
                }
            }

            Button {

                width: parent.width * 0.30
                background: ESTextField {
                }
                text: qsTr("Okay")

                onClicked: {

                    if (edit == false) {
                        Schedule.save_schedule(
                                    month, "0:" + courseList.get(courseBox.currentIndex).cdate
                                    + "," + sunday.checked + "," + monday.checked
                                    + "," + tuesday.checked + "," + wednesday.checked
                                    + "," + thursday.checked + "," + friday.checked
                                    + "," + saturday.checked , repeatMode,edit)
                    } else {

                        Schedule.save_schedule(
                                    month, "0:" + classNum
                                    + "," + sunday.checked + "," + monday.checked
                                    + "," + tuesday.checked + "," + wednesday.checked
                                    + "," + thursday.checked + "," + friday.checked
                                    + "," + saturday.checked , repeatMode,edit)

                    }


                    thisWindow.classNum = 0
                    thisWindow.edit = false
                    thisWindow.state = "inActive"
                }
            }
        }
    }
}
