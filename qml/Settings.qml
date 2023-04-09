import QtQuick 2.9
import Ubuntu.Components 1.3

Page {
    id: settingPage
    
    property alias zoomlevel: zoomslider.value

    signal applyChanges
    signal cancelChanges

    header: PageHeader {
        title: i18n.tr("Settings")
        flickable: scrollView.flickableItem

        leadingActionBar.actions: Action {
            text: i18n.tr("Cancel")
            iconName: "close"
            onTriggered: {
                settingPage.cancelChanges();
                pageStack.pop();
            }
        }

        trailingActionBar.actions: Action {
            text: i18n.tr("Apply")
            iconName: "ok"
            onTriggered: {
                settingPage.applyChanges();
                pageStack.pop();
            }
        }
    }

    ScrollView {
        id: scrollView
        anchors.fill: settingPage

        Column {
            id: column
            width: scrollView.width

            property int mSpacing: units.gu(1)

            ListItem {
                height: zoomlabel.height + zoomslider.height + column.mSpacing
                Label {
                    id: zoomlabel
                    text: i18n.tr("Zoom level: %1%").arg(zoomslider.value)
                    anchors {
                        top: parent.top; topMargin: column.mSpacing
                        left: parent.left; leftMargin: units.gu(1)
                        right: parent.right; rightMargin: units.gu(1)
                    }
                }
                Slider {
                    id: zoomslider
                    function formatValue(v) { return Number(v.toFixed(2)).toLocaleString(Qt.locale()) }
                    minimumValue: 25
                    maximumValue: 500
                    value: 100
                    live: true
                    width: parent.width
                    anchors.top: zoomlabel.bottom
                    anchors {
                        left: parent.left; leftMargin: units.gu(1)
                        right: parent.right; rightMargin: units.gu(1)
                    }
                }
            }
        }
    }
}