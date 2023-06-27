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
            height: warningLabel.height + applyButtom.height + column.mSpacing
            Label {
                id: warningLabel
                // TODO: wrapMode: Text.Wrap does not work
                text: i18n.tr("<b>WARNING</b>: these settings are experimental<br>"
                            + "If you break something and the app does not<br> start, the configuration "
                            + "file is located on: <br>/home/phablet/.local/<br>"
                            + "share/octobrowser.ikozyris/args.conf<br>"
                            + "To apply changes, press the button below<br> and restart the app.")
            }
            Button {
                id: applyButtom
                anchors.top: warningLabel.bottom
                text: i18n.tr("Apply changes")
                onClicked: {
                    prefs.log = logswitch.checked
                    prefs.download = backselector.selectedIndex
                    prefs.dark = darkswitch.checked
                    prefs.scrollbar = scrollswitch.checked
                    prefs.smoothscroll = smoothswitch.checked
                    prefs.lowend = lowendswitch.checked

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
}
