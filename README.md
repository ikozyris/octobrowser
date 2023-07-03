# Octopus Browser

Browse the WWW like an octopus.

Features:
- Toggle JavaScipt On/Off
- Automatically load images On/Off
- Move address bar
- History
- Block autoplaying videos
- Tabs
- Chrome flags: dark-mode, etc.
- _MORE_

In other words: The simpliest yet experamental Qt browser for Ubuntu Touch.

**DISCLAIMER**: Many things do not work, <br>here is a TODO list sorted by priority:
- ~~Tabs~~ almost (to some extent)
- ~~History~~ 
- Bookmarks
- ~~Camera and other permissions~~

### Known Issues
Tabs are not the the best

### Focal (20.04)
This program is developed for 16.04 base but there is an outdated focal branch.<br>
You can use the untested `focal.sh` script to fix library imports. Then try to compile with `clickable`. It might work.

## Qt Quick Compiler
to compile Ahead-Of-Time:
```
mv CMakeLists.txt CMakeLists-JIT.txt && mv CMakeLists-AOT.txt CMakeLists.txt
```
I didn't notice any improvement so it is not used by default.
Not convinced that JIT is faster than AOT (until Qt 6.3)? See [this article](https://www.qt.io/blog/the-new-qtquick-compiler-technology)
## License

Copyright (C) 2023  ikozyris

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License version 3, as published
by the Free Software Foundation.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranties of MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
