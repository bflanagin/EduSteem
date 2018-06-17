import QtQuick 2.11
import QtQuick.Controls 2.2

import "../theme"
import "../plugins"

import "./course.js" as Scripts


ListModel {
    id:lessonList
    property real thedate: 0
    Component.onCompleted: Scripts.loadLessons(userid,thedate)
    onThedateChanged: Scripts.loadLessons(userid,thedate)

}
