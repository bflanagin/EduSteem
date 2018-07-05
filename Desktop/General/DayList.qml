import QtQuick 2.11
import QtQuick.Controls 2.2

import "../theme"
import "../plugins"

import "../Educator/course.js" as Scripts
import "../Educator/scheduler.js" as Schedule

ListModel {
    id: dayList
    property int day: 0
    property int month: 0
    property int weekday: 0
    property string school: schoolCode
    property string educator: userCode

    Component.onCompleted: Schedule.load_Day(month, day, weekday)
    onDayChanged: Schedule.load_Day(month, day, weekday)
    onMonthChanged: Schedule.load_Day(month, day, weekday)
    onSchoolChanged: Schedule.load_Day(month, day, weekday)
    onEducatorChanged: Schedule.load_Day(month, day, weekday)
}
