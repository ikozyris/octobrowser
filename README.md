# Octopus Browser

Browse the WWW like an octopus.
Features:
- Toggle JavaScipt On/Off
- Automatically load images On/Off

Additonally you can move the top bar to the bottom for One-handed mode. 
To do that, you need to do the following to the file in ```qml/MainPage.qml```:<br>
Comment line 50, uncomment line 53<br>
Comment lines 149, 153 and Uncomment lines 150, 154 <br>


DISCLAIMER: Many things do not work, here is a TODO list sorted by priority:
- Tabs (important)
- History (important)
- Bookmarks
- Limit WebRTC to public IP addresses only WebRTC: check line 180 of file MainPage.qml (very easy but not prioritized)
- Camera and other permissions (easy but not prioritized)

In other words: The simpliest yet experamental, pure QML browser for Ubuntu Touch.

## License

Copyright (C) 2023  ikozyris

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License version 3, as published
by the Free Software Foundation.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranties of MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
