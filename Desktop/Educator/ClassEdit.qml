import QtQuick 2.11
import QtQuick.LocalStorage 2.0 as Sql
import QtQuick.Controls 2.4

import "../theme"
import "../plugins"
import "./course.js" as Scripts

import "../theme"

ESborder {
    id: thisWindow
    height: cColumn.height + 50
    property string day: "day"
    property string month: "month"

    //property string UnitObjective:"Objective"
    onStateChanged: if (state == "Active") {
                        Scripts.loadCourses(userid)
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

    Column {
        id: cColumn
        width: parent.width * 0.95
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: thisWindow.width * 0.03

        Text {
            id: title
            anchors.left: parent.left
            anchors.leftMargin: 10
            text: "Adding class"
            font.pointSize: 18
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

        ComboBox {
            id: courseBox
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
                    text: name
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
                id: evenday
                text: qsTr("Even Days")
            }

            RadioButton {
                id: oddday
                text: qsTr("Odd Days")
            }
        }

        Row {
            width: parent.width
            height: 50
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
            CheckBox {
                id: sunday
                text: qsTr("Sun")
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
                    thisWindow.state = "inActive"
                }
            }

            Button {

                width: parent.width * 0.30
                background: ESTextField {
                }
                text: qsTr("Okay")

                onClicked: {

                    console.log(courseBox.currentText.replace(/ /g, "_"),
                                courseList.get(courseBox.currentIndex).cdate,
                                monday.checked, tuesday.checked,
                                wednesday.checked, thursday.checked,
                                friday.checked, saturday.checked,
                                sunday.checked)

                    thisWindow.state = "inActive"
                }
            }
        }
    }
}
