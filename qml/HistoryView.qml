import Ubuntu.Components 1.3
import QtQuick 2.12

UbuntuListView {
    model: history.count // (array.lenght does not work)
    delegate: ListItem {
        //do not calculate this every time
        readonly property int curr: history.count - index
        //TODO: share this action as an optimization?
        leadingActions: ListItemActions {
            id: leading
            actions: Action {
                iconName: "delete"
                onTriggered: JS.delIndex(curr)
            }
        }
        Label {
            text: i18n.tr("On ") + history.dates[curr] + ":\n" + history.urls[curr]
            wrapMode: Text.WrapAnywhere
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
        }
        trailingActions: ListItemActions {
            actions: Action {
                iconName: "external-link"
                onTriggered: {
                    MyTabs.currtab = history.urls[curr];
					MyTabs.tabVisibility = true;
                    pStack.pop();
                }
            }
        }
    } 
}