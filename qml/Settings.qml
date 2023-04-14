/*
 * Copyright (C) 2023  ikozyris
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * octobrowser is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.9
import Ubuntu.Components 1.3

Page {
    id: settingPage


    property alias zoomlevel: zoomslider.value
    property alias adrpos: posselector.selectedIndex
    property alias cmuseragent: uatext.text

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
                    text: i18n.tr("Zoom level: %1%").arg(zoomlevel)
                    anchors {
                        top: parent.top; topMargin: column.mSpacing
                        left: parent.left; leftMargin: units.gu(1)
                        right: parent.right; rightMargin: units.gu(1)
                    }
                }
                Slider {
                    id: zoomslider
                    function formatValue(v) { return Number(v.toFixed(1)).toLocaleString(Qt.locale()) }
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
            ListItem {
                height: posselector.height + column.mSpacing
                OptionSelector {
                    id: posselector
                    text: i18n.tr("Address bar position: %1").arg(adrpos)
                    expanded: true
                    model: [
                        i18n.tr("top"),
                        i18n.tr("bottom"),
                    ]
                    selectedIndex: 0
                    anchors {
                        top: parent.top; topMargin: column.mSpacing
                        left: parent.left; leftMargin: units.gu(1)
                        right: parent.right; rightMargin: units.gu(1)
                    }
                }
            }
            ListItem {
                height: ualabel.height + uatext.height + 2 * column.mSpacing
                Label {
                    id: ualabel
                    text: i18n.tr("User Agent:")
                    anchors {
                        top: parent.top; topMargin: column.mSpacing
                        left: parent.left; leftMargin: units.gu(1)
                        right: parent.right; rightMargin: units.gu(1)
                    }
                }
                TextField {
                    id: uatext
                    width: parent.width
                    anchors.top: ualabel.bottom
                    anchors {
                        left: parent.left; leftMargin: units.gu(1)
                        right: parent.right; rightMargin: units.gu(1)
                    }
                }
            }
        }
    }
}
