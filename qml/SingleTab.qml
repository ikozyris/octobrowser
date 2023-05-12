import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    width: 100; height: 150
    property alias color: rect.color
    Rectangle {
        id: rect
        anchors.fill: parent
        color: "green"
    }
}