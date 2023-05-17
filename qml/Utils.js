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

//url related
function lookslikeurl(s) {
	var regexp = /^(?:(?:(?:[a-zA-z\-]+)\:\/{1,3})?(?:[a-zA-Z0-9])(?:[a-zA-Z0-9\-\.]){1,61}(?:\.[a-zA-Z]{2,})+|\[(?:(?:(?:[a-fA-F0-9]){1,4})(?::(?:[a-fA-F0-9]){1,4}){7}|::1|::)\]|(?:(?:[0-9]{1,3})(?:\.[0-9]{1,3}){3}))(?:\:[0-9]{1,5})?$/;
	return regexp.test(s);
}

function fixurl(string) {
	if (lookslikeurl(string)) {
	    if (prefs.securecontent != true) {
			return "https://" + string;
	    } else {
			return "http://" + string;
	    }
	} else {
	    return "bad";
	}
}

function isurl(s) {
	var regexp = /(ftp|http|https|chrome):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;
	return regexp.test(s);
}

function geturl(text) {
	if (isurl(text)) {
	    return text;
	} else {
	    var result = fixurl(text)
	    if (result != "bad") {
			return result;
	    } else {
			var query = "https://duckduckgo.com/?q=" + encodeURIComponent(text);
			return query;
	    }
	}
}

function canshow(prog) {
	if (prog !== 0 && prog !== 100)  {
		return true;
	} else {
		return false;
	}
}

//history related
function delIndex(index) {
	history.dates.splice(index, 1);
	history.urls.splice(index, 1);
	//TODO: array.lenghtdoes not work
	
	history.count--;
}

// tabs
function showTabs() {
	let i = 0;
	let prevX = units.gu(2);
	let prevY = units.gu(8);
	while (MyTabs.tabs[i] != undefined) {
		let tileX = prevX;
		let tileY = prevY;
		if (i !== 0) {
			if (prevX + units.gu(20) >= parent.width) {
				tileX = units.gu(2);
				tileY = prevY + units.gu(20);
			} else {
				tileX = prevX + units.gu(14);
				tileY = prevY;
			}
		}
		// TODO: take a thumbnail of the tab somehow (maybe Ubuntu.Thumbmnailer)
		// Currently it is just a random color
		let tileColor = ["red","green", "blue"][Math.floor(Math.random() * 3)];
		listModel.append( { tileX, tileY, tileColor } );
		prevX = tileX;
		prevY = tileY;
		++i;
	}
}

function newtab() {
	MyTabs.tabs.push("");
	MyTabs.tabNum++;
	MyTabs.currtab = "";
	pageHeader.textbar = "";
	MyTabs.tabVisibility = false;
}
