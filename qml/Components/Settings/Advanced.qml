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

import Manager 0.1

ScrollView {
    id: scrollView
	Label {
		text: i18n.tr("WARNING: these settings are experimental and may not work at all!\n"
                     + "If you brak something and the app does not start, the configuration"
                     + "file is located on /home/phablet/.local/share/octobrowser.ikozyris/args.conf")
        wrapMode: Text.Wrap
	}
    Column {
        id: column
        width: scrollView.width
        property int mSpacing: units.gu(2)
        // ==== ADVANCED CATEGORY ====
        ListItem {
            ListItemLayout {
                title.text: i18n.tr("Disable JavaScript logging:")
                subtitle.text: i18n.tr("There is no reason to log JS console messages")
            }
            Switch {
                id: logswitch
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                    right: parent.right; rightMargin: units.gu(1)
                }
                checked: prefs.log
            }
        }
        ListItem {
            ListItemLayout {
                title.text: i18n.tr("Dark Mode:")
                subtitle.text: i18n.tr("Not for the app itself, but for the WebView")
            }
            Switch {
                id: darkswitch
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                    right: parent.right; rightMargin: units.gu(1)
                }
                checked: prefs.dark
            }
        }
        ListItem {
            ListItemLayout {
                title.text: i18n.tr("Better scrollbar:")
                subtitle.text: i18n.tr("More modern feel")
            }
            Switch {
                id: scrollswitch
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                    right: parent.right; rightMargin: units.gu(1)
                }
                checked: prefs.scrollbar
            }
        }
        ListItem {
            ListItemLayout {
                title.text: i18n.tr("Smooth scrolling:")
                //subtitle.text: i18n.tr("")
            }
            Switch {
                id: smoothswitch
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                    right: parent.right; rightMargin: units.gu(1)
                }
                checked: prefs.smoothscroll
            }
        }
        ListItem {
            ListItemLayout {
                title.text: i18n.tr("Low end device mode:")
                subtitle.text: i18n.tr("Less load but worse images and content")
            }
            Switch {
                id: lowendswitch
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                    right: parent.right; rightMargin: units.gu(1)
                }
                checked: prefs.lowend
            }
        }
	}
    Component.onCompleted: {
        Manager.overwrite()
    }
    Component.onDestruction: {
        prefs.log = logswitch.checked
	    prefs.dark = darkswitch.checked
	    prefs.scrollbar = scrollswitch.checked
        prefs.smoothscroll = smoothswitch.checked
	    prefs.lowend = lowendswitch.checked

        if (prefs.dark)
            Manager.append(" --force-dark-mode --blink-settings=darkModeEnabled=true --darkModeInversionAlgorithm=4")
        console.log("wrote")

        if (prefs.scrollbar)
            Manager.append(" --enable-features=OverlayScrollbar --enable-smooth-scrolling")
        console.log("wrote")

        // --enable-natural-scroll-default
        if (prefs.smoothscroll)
            Manager.append(" --enable-smooth-scrolling ")
        console.log("wrote")

        if (prefs.lowend)
            Manager.append(" --enable-low-res-tiling  --enable-low-end-device-mode")
        console.log("wrote")
    }
}
