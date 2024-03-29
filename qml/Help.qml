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
import QtQuick.Controls 2.2
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3

Page {
    id: helpPage

    header: PageHeader {
        title: i18n.tr("Help")
        flickable: scrollView.flickableItem
    }

    ScrollView {
        id: scrollView
        anchors.fill: helpPage


        Column {
            id: column
            width: scrollView.width
            property int mSpacing: units.gu(3)
            property int mPadding: units.gu(2)

            ListItem {
                height: adrhelp.height + adrtitle.height + column.mPadding
                Label {
                    id: adrtitle
                    text: i18n.tr("There is an unknown/new bug")
                    wrapMode: Text.Wrap
                    font.italic: true
                }
                Label {
                    id: adrhelp
                    linkColor: UbuntuColors.orange
                    text: i18n.tr("Report it <a href='https://gitlab.com/ikozyris/octobrowser/-/issues'>here</a>")
                    wrapMode: Text.Wrap
                    anchors {
                        top: parent.top; topMargin: column.mSpacing
                        left: parent.left; leftMargin: units.gu(1)
                        right: parent.right; rightMargin: units.gu(1)
                    }
                    onLinkActivated: Qt.openUrlExternally(link)
                }
            }
            ListItem {
                height: hstrhelp.height + hstrtitle.height + column.mPadding
                Label {
                    id: hstrtitle
                    text: i18n.tr("History is wrong")
                    wrapMode: Text.Wrap
                    font.italic: true
                }
                Label {
                    id: hstrhelp
                    linkColor: UbuntuColors.orange
                    text: i18n.tr("A URL is added to history once the page has fully loaded,\n"
                                + "which means that if you get redirected from A to B,\n"
                                + "A will not be written to history.")
                    wrapMode: Text.Wrap
                    anchors {
                        top: parent.top; topMargin: column.mSpacing
                        left: parent.left; leftMargin: units.gu(1)
                        right: parent.right; rightMargin: units.gu(1)
                    }
                    onLinkActivated: Qt.openUrlExternally(link)
                }
            }
            ListItem {
                height: sphelp.height + sptitle.height + column.mPadding
                Label {
                    id: sptitle
                    text: i18n.tr("What settings are recommended for best security & privacy")
                    wrapMode: Text.Wrap
                    font.italic: true
                }
                Label {
                    id: sphelp
                    text: i18n.tr("Disable javascript, disable autoloadind images and block autoplay.\n" +
                                  "In addition, you can use a common user agent to limit fingerprinting.\n" +
                                  "Please note that currently this browser is not the best in terms of security or privacy.")
                    wrapMode: Text.Wrap
                    anchors {
                        top: parent.top; topMargin: column.mSpacing
                        left: parent.left; leftMargin: units.gu(1)
                        right: parent.right; rightMargin: units.gu(1)
                    }
                }
            }
        }
    }
}
