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
                    text: i18n.tr("I entered a website in the address bar but it won't go there.")
                    wrapMode: Text.Wrap
                    font.italic: true
                }
                Text {
                    id: adrhelp
                    text: i18n.tr("In the address bar, you should put a VALID URL (not just a domain or a website) with the following format: " +
								"http://www.example.com/index.html, which indicates a protocol (http)," +
								"a hostname (www.example.com), and a file name (index.html)." +
                                "Anything will be treated as a search query and is passed to duckduckgo")
                    wrapMode: Text.Wrap
                    anchors {
                        top: parent.top; topMargin: column.mSpacing
                        left: parent.left; leftMargin: units.gu(1)
                        right: parent.right; rightMargin: units.gu(1)
                    }
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
                    text: i18n.tr("First of all, disable all switches. In addition, you can use a common user agent to limit fingerprinting." +
                                  " Please note that currently this browser is not the best in terms of security or privacy.")
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