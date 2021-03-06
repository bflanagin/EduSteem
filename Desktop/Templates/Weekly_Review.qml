import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.LocalStorage 2.0 as Sql
import QtGraphicalEffects 1.0

import "../theme"
import "../plugins"
import "../General"

import "../General/general.js" as Scripts
import "../Student/student.js" as Students

Item {
    id:thisWindow
    width:parent.height
    height:parent.height

    property string studentname: "Student"

    onVisibleChanged: if(visible === true && studentCode !== 0) {
                          studentname = Scripts.studentCred(
                                      studentCode, " ",
                                      "firstname") + " " + Scripts.studentCred(
                                      studentCode, " ", "lastname")

                            Students.loadTasks(5)
                      }

    Rectangle {
        anchors.fill: parent

    }
    Flickable {
        width:parent.width
        height:parent.height
        contentHeight: cColumn.height + 10
        clip:true

    Column {
            id:cColumn
        width:parent.width
        spacing:5
    Text {
        id:title
        anchors.left: parent.left
        anchors.margins: 10
        font.bold: true
        font.pointSize: 18
        text: studentname+"'s " + schoolName + "Weekly Recap"
        wrapMode: Text.WordWrap
        width:parent.width * 0.90
    }

    Rectangle {
        width:parent.width * 0.98
        anchors.horizontalCenter: parent.horizontalCenter
        height:3
        color:seperatorColor
    }

    Repeater {
        model:completedAssignments

        delegate: ESborder {
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width * 0.98
            height:100

        }
    }




    }

    }

    ListModel {
        id:completedAssignments
    }

}
