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
import QtQuick.Controls 2.12
import Ubuntu.Components 1.3

import "qrc:///qml/Utils.js" as JS

Page {
	header: PageHeader {
		anchors.top: parent.top
		title: i18n.tr("Tabs")
		subtitle: i18n.tr("Current tab:" + MyTabs.tabNum)
	}

    Repeater {
        model: listModel
        delegate: SingleTab {
            x: tileX
            y: tileY
            color: tileColor
			Text {
				text: MyTabs.tabs[index]
				anchors.centerIn: parent
				width: parent.width
				wrapMode: Text.WrapAnywhere
				color: "white"
				MouseArea {
					anchors.fill: parent
					onClicked: {
						MyTabs.tabNum = index
						MyTabs.currtab = MyTabs.tabs[index]
						MyTabs.tabVisibility = true
                    	pStack.pop()
					}
				}
			}
            Label {
                text: "X"
				textSize: Label.XLarge
                anchors.right: parent.right
                color: "white"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
						// if current tab is deleted
						if (MyTabs.tabNum === index)
							MyTabs.tabNum--
						MyTabs.tabs.splice(index,1)
						listModel.remove(index)
					}
                }
            }
        }
    }
    
    ListModel {
        id: listModel
    }

	Component.onCompleted: {
		//console.info(MyTabs.tabs)
		JS.showTabs()
	}
}
