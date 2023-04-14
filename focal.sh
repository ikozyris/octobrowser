echo "Moving base to 20.04 this script was NEVER tested, use at our own risk.\n You have 5 seconds to Ctrl-C before any damage has been done"
sleep 5
find -name '*.qml' | xargs -I {} sed -i 's/import Ubuntu\./import Lomiri./g' {}
find -name '*.qml' | xargs -I {} sed -i 's/UbuntuAnimation/LomiriAnimation/g' {}
find -name '*.qml' | xargs -I {} sed -i 's/UbuntuNumberAnimation/LomiriNumberAnimation/g' {}
find -name '*.qml' | xargs -I {} sed -i 's/UbuntuListView/LomiriListView/g' {}
find -name '*.qml' | xargs -I {} sed -i 's/UbuntuColors/LomiriColors/g' {}
find -name '*.qml' | xargs -I {} sed -i 's/UbuntuShape/LomiriShape/g' {}

find -name '*.*' | xargs -I {} sed -i 's/16.04/20.04/g' {}