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
import "../"

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
                onCheckedChanged: prefs.keeptabs = ktabs.checked
            }
        }
        ListItem {
            ListItemLayout {
                title.text: i18n.tr("Clear web cache on exit:")
                subtitle.text: i18n.tr("Web caches can get very large if never cleared")
            }
            Switch {
                id: clrchache
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                    right: parent.right; rightMargin: units.gu(1)
                }
                checked: prefs.clearcache
                onCheckedChanged: prefs.clearcache = clrchache.checked
            }
        }
        // TODO: find default delegate of ActionBar to make custom Actions
        /*ListItem {
            ListItemLayout {
                title.text: i18n.tr("Add whitespace between buttons on the search header:")
                subtitle.text: i18n.tr("Some people may find buttons too close")
            }
            Switch {
                id: paddingswitch
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                    right: parent.right; rightMargin: units.gu(1)
                }
                checked: prefs.padding
                onCheckedChanged: prefs.padding = paddingswitch.checked
            }
        }*/
        ListItem {
            ListItemLayout {
                title.text: i18n.tr("Automatically suggest search:")
                subtitle.text: i18n.tr("Enable word prediction in search bar")
            }
            Switch {
                id: acswitch
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                    right: parent.right; rightMargin: units.gu(1)
                }
                checked: prefs.ac
                onCheckedChanged: prefs.ac = acswitch.checked
            }
        }
        ListItem {
            height: srcselector.height + column.mSpacing
            OptionSelector {
                id: srcselector
                text: i18n.tr("Search Engine: %1").arg(model[selectedIndex])
                model: [
                    i18n.tr("DuckDuckGo"),
                    i18n.tr("Google"),
                ]
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                }
                selectedIndex: prefs.srchEngine
                onSelectedIndexChanged: prefs.srchEngine = srcselector.selectedIndex
            }
        }
        ListItem {
            height: posselector.height + column.mSpacing
            OptionSelector {
                id: posselector
                text: i18n.tr("Address bar position: %1 \n(restart the app after change)").arg(
                               model[selectedIndex])
                model: [
                    i18n.tr("top"),
                    i18n.tr("bottom"),
                ]
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                }
                selectedIndex: prefs.adrpos
                onSelectedIndexChanged: prefs.adrpos = posselector.selectedIndex
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
                onValueChanged: prefs.zoomlevel = zoomslider.value
            }
        }
        SectionDivider {
            text: i18n.tr("Filters")
        }
        ListItem {
            enabled: dimfilter !== true
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
                onCheckedChanged: prefs.lightfilter = this.checked
            }
        }
        ListItem {
            enabled: blfilter !== true
            ListItemLayout {
                title.text: i18n.tr("Reduce brightness:")
                subtitle.text: i18n.tr("Reduces the brightness of the app")
            }
            Switch {
                id: dimfilter
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                    right: parent.right; rightMargin: units.gu(1)
                }
                checked: prefs.dim
                onCheckedChanged: prefs.dim = this.checked
            }
        }
        ListItem {
            ListItemLayout {
                title.text: i18n.tr("Night Mode:")
                subtitle.text: i18n.tr("Makes web page B&W and inverts colors")
            }
            Switch {
                id: nightfilter
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                    right: parent.right; rightMargin: units.gu(1)
                }
                checked: prefs.nightMode
                onCheckedChanged: prefs.nightMode = this.checked
            }
        }
	}
}
