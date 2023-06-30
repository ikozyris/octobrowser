import QtQuick 2.12
import Ubuntu.Components 1.3

Rectangle {
	Label {
        id: placeholdertext
        width: parent.width
        horizontalAlignment: Text.AlignHCenter
        text: i18n.tr("Welcome to <i>Octopus Browser</i>, <br> a fast & customizable browser.")
        fontSize: "large"
        wrapMode: Text.Wrap
        color: "white"
        anchors.centerIn: parent
    }
    UbuntuShape {
        width: units.gu(12); height: units.gu(12)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: placeholdertext.top
        radius: "medium"
        image: Image {
            source: Qt.resolvedUrl("/assets/logo.svg")
        }
    }
	color: Theme.name === "Ubuntu.Components.Themes.SuruDark" ? UbuntuColors.inkstone : UbuntuColors.graphite
}