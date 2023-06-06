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
            visible: genshow.checked
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
            visible: genshow.checked
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
            }
        }
        ListItem {
            visible: genshow.checked
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
            visible: genshow.checked
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
            ListItemLayout {
                id: ualabel
                title.text: i18n.tr("User Agent:")
                subtitle.text: i18n.tr("This can be used to confuse websites about your identity and/or"
                                     + " load the desktop version of a page.")
            }
            TextArea {
                id: uatext
                maximumLineCount: 3
                width: parent.width
                anchors.top: ualabel.bottom
                text: prefs.cmuseragent
            }
        }
        ListItem {
            visible: prishow.checked
            ListItemLayout {
                title.text: i18n.tr("Limit WebRTC to public IP addresses only:")
                subtitle.text: i18n.tr("If enabled, it might leak your real IP, even if a VPN is used")
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
            ListItemLayout {
                title.text: i18n.tr("Enable JavaScipt:")
                subtitle.text: i18n.tr("A major security feature, it will break many websites")
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
            ListItemLayout {
                title.text: i18n.tr("Autoload Images:")
                subtitle.text: i18n.tr("By disabling, images will not be loaded")
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
            ListItemLayout {
                title.text: i18n.tr("Autoplay videos:")
                subtitle.text: i18n.tr("Does not work all times")
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
            ListItemLayout {
                title.text: i18n.tr("Allow running insecure content:")
                subtitle.text: i18n.tr("Allows loading files over unencrypted HTTP")
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
