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
            Label {
                text: i18n.tr("Show General category:")
                font.bold: true
            }
            CheckBox {
                id: genshow
                anchors.right: parent.right
                anchors.rightMargin: column.mSpacing
                checked: false
            }
        }
        ListItem {
            visible: genshow.checked
            Label {
                text: i18n.tr("Remember open tabs:")
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                }
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
            visible: genshow.checked
            Label {
                text: i18n.tr("Clear cache on exit:")
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                }
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
            visible: genshow.checked
            Label {
                text: i18n.tr("Blue light filter:")
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                }
            }
            Switch {
                id: blfilter
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                    right: parent.right; rightMargin: units.gu(1)
                }
                checked: prefs.lightfilter
            }
        }
        ListItem {
            visible: genshow.checked
            height: zoomlabel.height + zoomslider.height + column.mSpacing
            Label {
                id: zoomlabel
                text: i18n.tr("Zoom level: %1%").arg(zoomslider.value)
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                }
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
            visible: genshow.checked
            height: posselector.height + column.mSpacing
            OptionSelector {
                id: posselector
                text: i18n.tr("Address bar position: %1").arg(posselector.selectedIndex)
                model: [
                    i18n.tr("top"),
                    i18n.tr("bottom"),
                ]
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                }
            }
        }
        // ==== PRIVACY CATEGORY ====
        ListItem {
            Label {
                text: i18n.tr("Show Privacy category")
                font.bold: true
            }
            CheckBox {
                id: prishow
                anchors.right: parent.right
                anchors.rightMargin: column.mSpacing
                checked: false
            }
        }
        ListItem {
            visible: prishow.checked
            height: ualabel.height + uatext.height + column.mSpacing
            Label {
                id: ualabel
                text: i18n.tr("User Agent:")
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                    left: parent.left; leftMargin: units.gu(1)
                }
            }
            TextArea {
                visible: prishow.checked
                id: uatext
                maximumLineCount: 3
                width: parent.width
                anchors.top: ualabel.bottom
                text: prefs.cmuseragent
            }
        }
        ListItem {
            visible: prishow.checked
            Label {
                text: i18n.tr("Limit WebRTC to public IP addresses only:")
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                }
            }
            Switch {
                id: rtcswitch
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                    right: parent.right; rightMargin: units.gu(1)
                }
                checked: prefs.webrtc
            }
        }
        // ==== SECURITY CATEGORY ====
        ListItem {
            Label {
                text: i18n.tr("Show Security category:")
                font.bold: true
            }
            CheckBox {
                id: secshow
                anchors.right: parent.right
                anchors.rightMargin: column.mSpacing
                checked: false
            }
        }
        ListItem {
            visible: secshow.checked
            Label {
                text: i18n.tr("Enable JavaScipt:")
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                }
            }
            Switch {
                id: jsswitch
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                    right: parent.right; rightMargin: units.gu(1)
                }
                checked: prefs.js
            }
        }
        ListItem {
            visible: secshow.checked
            Label {
                text: i18n.tr("Autoload Images:")
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                }
            }
            Switch {
                id: imagswitch
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                    right: parent.right; rightMargin: units.gu(1)
                }
                checked: prefs.loadimages
            }
        }
        ListItem {
            visible: secshow.checked
            Label {
                text: i18n.tr("Autoplay videos:")
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                }
            }
            Switch {
                id: playswitch
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                    right: parent.right; rightMargin: units.gu(1)
                }
                checked: prefs.autoplay
            }
        }
        ListItem {
            visible: secshow.checked
            Label {
                id: inseclabel
                text: i18n.tr("Allow running insecure content:")
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                }
            }
            Switch {
                id: insecswitch
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                    right: parent.right; rightMargin: units.gu(1)
                }
                checked: prefs.securecontent
            }
        }
	}
	Component.onDestruction: {
	    prefs.zoomlevel = zoomslider.value
	    prefs.adrpos = posselector.selectedIndex
	    prefs.cmuseragent = uatext.text
	    prefs.js = jsswitch.checked
	    prefs.loadimages = imagswitch.checked
	    prefs.securecontent = insecswitch.checked
	    prefs.webrtc = rtcswitch.checked
	    prefs.keeptabs = ktabs.checked
	    prefs.autoplay = playswitch.checked
	    prefs.lightfilter = blfilter.checked
	    prefs.clearcache = clrchache.checked
	}
}
