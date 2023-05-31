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

Page {
    id: settingPage
/*
    property alias zoomlevel: zoomslider.value
    property alias adrpos: posselector.selectedIndex
    property alias cmuseragent: uatext.text
    property alias js: jsswitch.checked
    property alias loadimages: imagswitch.checked
    property alias webrtc: rtcswitch.checked
    property alias securecontent: insecswitch.checked
    property alias keeptabs: ktabs.checked
    property alias autoplay: playswitch.checked
    property alias lightfilter: blfilter.checked
*/
    //signal applyChanges
    //signal cancelChanges

    header: PageHeader {
        title: i18n.tr("Settings")
    }
    Loader {
        source: Qt.resolvedUrl("Components/Settings.qml")
        asynchronous: true
        anchors {
            top: settingPage.header.bottom
            leftMargin: units.gu(0.2)
            left: parent.left
            rightMargin: units.gu(0.2)
            right: parent.right
            bottom: parent.bottom
        }
    }
}
