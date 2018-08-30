import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import Qt.labs.calendar 1.0
import "./scheduler.js" as Schedule

import "../theme"
import "../plugins"
import "../General"
import "../General/network.js" as Network

Item {
    id: thisWindow
    states: [

        State {
            name: "Active"
            PropertyChanges {

                target: thisWindow
                opacity: 1
                x: 0
            }
        },

        State {
            name: "inActive"
            PropertyChanges {

                target: thisWindow
                opacity: 0
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

    state: "inActive"

   // property var d: new Date()
    property int monthoffset: 0

    onStateChanged: if (state === "Active") {
                        monthoffset = 0
                        selected_month = d.getMonth()
                        Network.checkOpenSeed(userID, cdate, edate,"Schedule")
                    }



    Rectangle {
        anchors.fill: parent
    }

    Text {
        id: title
        text: qsTr("Schedule")
        anchors.top: parent.top
        anchors.left: backbutton.right
        anchors.margins: 20
        font.bold: true
        font.pointSize: 15
    }

    CircleButton {
        id: backbutton
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 20
        height: title.height
        width: title.height

        MouseArea {
            anchors.fill: parent
            onClicked: {
                thisWindow.state = "inActive"
                general.state = "Active"
            }
        }
    }

    SpinBox {
        id: monthselect1
        from: 0
        to: 11
        value: d.getMonth()

        anchors.verticalCenter: title.verticalCenter

        anchors.right: parent.right
        width: 200
        anchors.rightMargin: 20
        onValueChanged: {
            selected_month = value
            monthoffset = 0
        }

        contentItem: Label {
            text: switch (parent.value) {
                  case 0:
                      "January"
                      break
                  case 1:
                      "Febuary"
                      break
                  case 2:
                      "March"
                      break
                  case 3:
                      "April"
                      break
                  case 4:
                      "May"
                      break
                  case 5:
                      "June"
                      break
                  case 6:
                      "July"
                      break
                  case 7:
                      "August"
                      break
                  case 8:
                      "September"
                      break
                  case 9:
                      "October"
                      break
                  case 10:
                      "November"
                      break
                  case 11:
                      "December"
                      break
                  }

            width: parent.width
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: "black"
            font.pointSize: 10
        }

        down.indicator: Rectangle {
            width: parent.height / 2
            height: parent.height / 2
            radius: width / 2
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            color: seperatorColor

            Image {
                id: d1
                source: "/icons/minus.svg"
                anchors.centerIn: parent
                fillMode: Image.PreserveAspectFit
                width: parent.width * 0.65
            }

            ColorOverlay {
                source: d1
                color: "white"
                anchors.fill: d1
            }
        }

        up.indicator: Rectangle {
            width: parent.height / 2
            height: parent.height / 2
            radius: width / 2
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            color: seperatorColor

            Image {
                id: u1
                source: "/icons/add.svg"
                anchors.centerIn: parent
                fillMode: Image.PreserveAspectFit
                width: parent.width * 0.65
            }

            ColorOverlay {
                source: u1
                color: "white"
                anchors.fill: u1
            }
        }
    }

    Rectangle {
        anchors.top: monthselect1.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.95
        height: 3
        color: seperatorColor
    }

    ScrollView {
        id: dayselect
        width: if (parent.height < 2000) {
                   parent.width * 0.98
               } else {
                   parent.width * 0.98
               }
        height: if (parent.height * 0.99 < 2000) {
                    parent.height * 0.99
                } else {
                    2000
                }

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: monthselect1.bottom
        anchors.topMargin: 40
        clip: true

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        contentHeight: grid.height + dow.height
        contentWidth: grid.width + 20

        DayOfWeekRow {
            id: dow
            locale: grid.locale
            width: grid.width
            anchors.top: parent.top
            delegate: Text {

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                text: model.shortName
                color: "black"
                font.pointSize: 8
            }
        }

        Rectangle {
            width: grid.width * 1.01
            height: grid.height * 1.01
            anchors.centerIn: grid
            color: "#E5F9F9F9"
        }
        MonthGrid {
            id: grid
            anchors.top: dow.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            width: thisWindow.width * 0.95
            month: monthselect1.value

            title: month

            locale: Qt.locale("en_US")

            delegate: Rectangle {
                width: 200
                height: width + 40

                color: "white"
                property int calNum: index

                opacity: model.month === monthselect1.value ? 1 : 0.1
                clip: true
                Column {
                    width: parent.width
                    spacing: parent.width * 0.01
                    Text {
                        id: dayText
                        text: model.day
                        color: model.day === theday ? seperatorColor : "black"
                        font.pointSize: 8
                        font.bold: true
                        anchors.right: parent.right
                    }

                    Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: 1
                        width: parent.width
                        color: seperatorColor
                    }

                    Repeater {

                        model: DayList {
                            day: model.day
                            month: model.month
                            weekday: calNum
                        }
                        Item {
                            width: parent.width
                            height: classname.height + 5
                            Text {
                                id: classname
                                anchors.verticalCenter: parent.verticalCenter
                                text: name

                                width: parent.width
                                wrapMode: Text.WordWrap
                                maximumLineCount: 1
                                elide: Text.ElideRight
                            }
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        theday = model.day
                        selected_dow = (calNum % 7)
                    }
                }
            }
        }
    }


}
