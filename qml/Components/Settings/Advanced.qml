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
import "../"

ScrollView {
    id: scrollView

    // avoid rewriting if nothing changed
    property bool changed: false

    Column {
        id: column
        width: scrollView.width

        property int mSpacing: units.gu(2)
        // ==== ADVANCED CATEGORY ====
        ListItem {
            height: warningLabel.height + column.mSpacing
            Label {
                id: warningLabel
                // TODO: wrapMode: Text.Wrap does not work
                text: i18n.tr("<b>WARNING</b>: these settings are experimental<br>"
                            + "If you break something and the app does not<br> start, the configuration "
                            + "file is located on: <br>/home/phablet/.local/<br>share/octobrowser.ikozyris/args.conf<br>"
                            + "Most of them require a <b>restart of the app</b> to apply")
            }
        }
        ListItem {
            height: backselector.height + column.mSpacing
            OptionSelector {
                id: backselector
                text: i18n.tr("Download backend: %1 ").arg(
                    backselector.selectedIndex === 0 ? "QtWebEngineView" : "SingleDownload")
                model: [
                    i18n.tr("QtWebEngineView"),
                    i18n.tr("SingleDownload"),
                ]
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                }
                selectedIndex: prefs.download
                onSelectedIndexChanged: prefs.download = backselector.selectedIndex
            }
        }
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
                onCheckedChanged: prefs.log = logswitch.checked
            }
        }
        SectionDivider {
            text: i18n.tr("Chrome Flags")
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
                onCheckedChanged: {
                    if (prefs.dark != darkswitch.checked)
                        changed = true
                    prefs.dark = darkswitch.checked
                }
            }
        }
        ListItem {
            ListItemLayout {
                title.text: i18n.tr("Better scrollbar:")
                subtitle.text: i18n.tr("Scrollbar with a modern feel")
            }
            Switch {
                id: scrollswitch
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                    right: parent.right; rightMargin: units.gu(1)
                }
                checked: prefs.scrollbar
                onCheckedChanged: {
                    if (prefs.scrollbar != scrollswitch.checked)
                        changed = true
                    prefs.scrollbar = scrollswitch.checked
                }
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
                onCheckedChanged: {
                    if (prefs.smoothscroll != smoothswitch.checked)
                        changed = true
                    prefs.smoothscroll = smoothswitch.checked
                }
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
                onCheckedChanged: {
                    if (prefs.lowend != lowendswitch.checked)
                        changed = true
                    prefs.lowend = lowendswitch.checked
                }
            }
        }
	}
    Component.onDestruction: function() {
        if (changed) {
            Manager.overwrite()

            if (prefs.dark)
                Manager.append(" --force-dark-mode --blink-settings=darkModeEnabled=true,"
                                + "darkModeImagePolicy=2 --darkModeInversionAlgorithm=4 ")

            if (prefs.scrollbar)
                Manager.append(" --enable-features=OverlayScrollbar ")

            // --enable-natural-scroll-default
            if (prefs.smoothscroll)
                Manager.append(" --enable-smooth-scrolling ")

            if (prefs.lowend)
                Manager.append(" --enable-low-res-tiling  --enable-low-end-device-mode ")
        }
    }
}
