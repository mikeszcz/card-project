import QtQuick
import QtQuick.Controls

Window {
    //Keep a border of 20px for cleanliness
    id: mainWindow
    width: 1920
    height: 1080
    visible: true
    title: "Commander"
    visibility: "FullScreen"

    property int pxborder: 10
    property bool inspecting: false
    property Image insp: null
    //A const card to refer to for card vals
    Card {
        id: test
    }

    property var zones: [
        //Command zone
        {x: mainWindow.width - test.width - pxborder, y: pxborder, text: qsTr("Command Zone")},
        //Stack
        {x: mainWindow.width - test.width - pxborder, y: pxborder + test.height + pxborder, text: qsTr("Stack")},
        //Graveyard
        {x: mainWindow.width - test.width - pxborder, y: mainWindow.height - test.height - pxborder, text: qsTr("Graveyard")},
        //Library
        {x: mainWindow.width - test.width - pxborder, y: mainWindow.height - (test.height * 2) - (pxborder * 2), text: qsTr("Library")},
        //Exile
        {x: mainWindow.width - (test.width * 2) - (pxborder * 2), y: mainWindow.height - test.height - pxborder, text: qsTr("Exile")}
    ]

    Repeater {
        id: repeater
        model: zones.length
        Rectangle {
            x: mainWindow.zones[index].x
            y: mainWindow.zones[index].y
            height: test.height
            width: test.width
            border.color: "black"
            DropArea {
                id: drop
                anchors.fill: parent
            }
            Text {
                id: rectext
                text: zones[index].text
                color: "black"
                anchors.centerIn: parent
            }
        }
    }

    Rectangle {
        id: battlefield
        x: pxborder
        y: pxborder
        height: parent.height - hand.height - (pxborder * 3)
        width: parent.width - test.width - (pxborder * 3)
        border.color: "black"
        DropArea {
            id: battledrop
            anchors.fill: parent
        }
        Text {
            id: battletext
            text: qsTr("Battlefield")
            color: "black"
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: textinfo
        border.color: "black"
        x: parent.width - width - pxborder
        y: zones[3].y - height - pxborder
        width: test.width
        height: zones[3].y - zones[1].y - test.height - (pxborder * 2)
        Text {
            id: infotext
            text: qsTr("Info Zone")
            color: "black"
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: hand
        border.color: "black"
        x: pxborder
        y: parent.height - test.height - pxborder
        height: test.height
        width: zones[4].x - (pxborder * 2)
        DropArea {
            id: handdrop
            anchors.centerIn: parent
        }
        Text {
            id: handtext
            text: qsTr("Hand")
            color: "black"
            anchors.centerIn: parent
        }
    }

    //Destroys the inspected card
    MouseArea {
        id: inspection
        z: 0
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        anchors.fill: parent
        onClicked: {
            if (mainWindow.inspecting) {
                mainWindow.insp.destroy()
                mainWindow.insp = null
                mainWindow.inspecting = false
                inspection.z = 0
            }

        }
    }

    Card {
        id: decktest
        x: zones[3].x
        y: zones[3].y
        visible: true
        source: "back.jpg"
    }

    Card {
        id: commander
        x: zones[0].x
        y: zones[0].y
        visible: true
        source: "KaradorGhostChieftain.jpg"
    }
}
