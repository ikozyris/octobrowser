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
 *
 * this file is part of Octopus Browser (octobrowser)
 */

import QtQuick 2.12
import QtQuick.Layouts 1.3
import Ubuntu.Components 1.3

ScrollView {
    id: scrollView
    Column {
        id: column
        width: scrollView.width
        property int mSpacing: units.gu(2)
        // ==== GENERAL CATEGORY ====
        ListItem {
            ListItemLayout {
                title.text: i18n.tr("Remember open tabs:")
                subtitle.text: i18n.tr("Do not close tabs on exit")
            }
            Switch {
                id: ktabs
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                    right: parent.right; rightMargin: units.gu(1)
                }
                checked: prefs.keeptabs
            }
        }
        ListItem {
            ListItemLayout {
                title.text: i18n.tr("Clear web cache on exit:")
                subtitle.text: i18n.tr("Web caches can get very large if never cleard")
            }
            Switch {
                id: clrchache
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                    right: parent.right; rightMargin: units.gu(1)
                }
                checked: prefs.clearcache
            }
        }
        ListItem {
            ListItemLayout {
                title.text: i18n.tr("Blue light filter:")
                subtitle.text: i18n.tr("Applies a yellow overlay to the app")
            }
            Switch {
                id: blfilter
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                    right: parent.right; rightMargin: units.gu(1)
                }
                checked: prefs.lightfilter
                onCheckedChanged: prefs.lightfilter = blfilter.checked
            }
        }
        ListItem {
            height: zoomlabel.height + zoomslider.height + column.mSpacing
            ListItemLayout {
                id: zoomlabel
                title.text: i18n.tr("Zoom level: %1%").arg(zoomslider.value)
                subtitle.text: i18n.tr("Scales the page according to your needs")
            }
            Slider {
                id: zoomslider
                function formatValue(v) { return Number(v.toFixed(1)).toLocaleString(Qt.locale()) }
                minimumValue: 25
                maximumValue: 500
                value: prefs.zoomlevel
                live: true
                width: parent.width
                anchors.top: zoomlabel.bottom
            }
        }
        ListItem {
            height: posselector.height + column.mSpacing
            OptionSelector {
                id: posselector
                text: i18n.tr("Address bar position: %1 (restart the app after change)").arg(posselector.selectedIndex)
                model: [
                    i18n.tr("top"),
                    i18n.tr("bottom"),
                ]
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                }
                selectedIndex: prefs.adrpos
            }
        }
	}
    Component.onDestruction: {
	    prefs.keeptabs = ktabs.checked
        prefs.clearcache = clrchache.checked
	    prefs.zoomlevel = zoomslider.value
	    prefs.adrpos = posselector.selectedIndex
    }
}
