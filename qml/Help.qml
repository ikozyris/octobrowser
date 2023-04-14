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
import Lomiri.Components 1.3
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
            property int mSpacing: units.gu(2)

            ListItem {
                height: adrhelp.height + column.mSpacing
                Label {
                    id: adrhelp
                    text: i18n.tr("In the address bar, you should put a VALID URL with the following format:\n" +
								"http://www.example.com/index.html , which indicates a protocol (http)," +
								"a hostname (www.example.com), and a file name (index.html).\n" +
                                "Anything will be treated as a search query and passed to duckduckgo.\n" +
                                "A common mistake is to forget to specicify the protocol")
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
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
