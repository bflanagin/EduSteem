import QtQuick 2.11

Rectangle {
                radius: 15
                border.width: 2
                border.color: if(parent.focus == true) {selectedHighlightColor} else {seperatorColor}
            }
