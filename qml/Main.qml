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

import QtQuick 2.12
import QtGraphicalEffects 1.12
import QtQuick.Controls 2.2
import Ubuntu.Components 1.3
import Qt.labs.settings 1.0

MainView {
//ApplicationWindow { //for engine
    id: mainView
    //objectName: 'mainView'
    applicationName: 'octobrowser.ikozyris'
    automaticOrientation: true
    anchorToKeyboard: false
    //visible: true //for engine
    width: units.gu(45)
    height: units.gu(75)

    Settings {
        id: preferences
        property int zoomlevel: 100
        property int adrpos: 0
        property string cmuseragent: "Mozilla/5.0 (Linux; Android 11) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Mobile Safari/537.36"
        property bool js: true
        property bool loadimages: true
        property bool securecontent: false
        property bool webrtc: false
        property bool keeptabs: false
        property bool autoplay: false
        property bool lightfilter: false
    }

    Settings {
        id: history
        property var urls: [""];
        property var dates: [""];
        property int count: 0;
    }

    KeyboardRectangle {
        id: keyboardRect
    }
    
    PageStack {
        id: pStack
        anchors {
            fill: undefined // unset the default to make the other anchors work
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: keyboardRect.top
        }
    }

    Component.onCompleted: {
        pStack.push(Qt.resolvedUrl("MainPage.qml"))
    }


    ColorOverlay {
        anchors.fill: pStack
        source: pStack
        color: preferences.lightfilter ? "#60600000" : "transparent"
    }

    function showSettings() {
        var prop = {
            zoomlevel: preferences.zoomlevel,
            adrpos: preferences.adrpos,
            cmuseragent: preferences.cmuseragent,
            js: preferences.js,
            loadimages: preferences.loadimages,
            securecontent: preferences.securecontent,
            webrtc: preferences.webrtc,
            keeptabs: preferences.keeptabs,
            autoplay: preferences.autoplay,
            lightfilter: preferences.lightfilter
        }

        var slot_applyChanges = function(msettings) {
            //console.log("Saving changes...")
            preferences.zoomlevel = msettings.zoomlevel;
            preferences.adrpos = msettings.adrpos;
            preferences.cmuseragent = msettings.cmuseragent;
            preferences.js = msettings.js;
            preferences.loadimages = msettings.loadimages;
            preferences.securecontent = msettings.securecontent;
            preferences.webrtc = msettings.webrtc;
            preferences.keeptabs = msettings.keeptabs;
            preferences.autoplay = msettings.autoplay;
            preferences.lightfilter = msettings.lightfilter;
        }

        var settingPage = pStack.push(Qt.resolvedUrl("Settings.qml"), prop);
        settingPage.applyChanges.connect(function() { slot_applyChanges(settingPage) });
    }
}
