import QtQuick 2.11

Rectangle {
                radius: 8
                border.width: 1
                border.color: if(parent.focus == true) {selectedHighlightColor} else {seperatorColor}
            }
