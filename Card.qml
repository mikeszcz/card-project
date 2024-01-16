import QtQuick

Image {
    id: card
    height: 325 * 0.7
    width: 235 * 0.7
    Drag.active: draggable.drag.active
    state: "untapped"

    property DropArea curr_zone: null

    states:[
        State {
            name: "tapped"
            PropertyChanges {
                target: card
                rotation: 90
            }
        },
        State {
            name: "untapped"
            PropertyChanges {
                target: card
                rotation: 0
            }
        },
        State {
            name: "unplayed"
            PropertyChanges {
                target: card
                rotation: 0
            }
        }
    ]

    transitions: [
        Transition {
            from: "untapped"; to: "tapped";
            RotationAnimation {
                duration: 50
                direction: RotationAnimation.Clockwise
            }
        },
        Transition {
            from: "tapped"; to: "untapped";
            RotationAnimation {
                duration: 50
                direction: RotationAnimation.Counterclockwise
            }
        },
        Transition {
            from: "tapped"; to: "unplayed";
            RotationAnimation {
                duration: 50
                direction: RotationAnimation.Counterclockwise
            }
        }
    ]

    MouseArea {
        id: draggable
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        anchors.fill: parent
        onClicked: {
            //Only allows to be tapped and untapped on the battlefield
            if (battlefield.contains(card)) {

                if (mouse.button === Qt.LeftButton && card.state === "untapped") {
                    card.state = "tapped"
                }
                else if (mouse.button === Qt.LeftButton && card.state === "tapped") {
                    card.state = "untapped"
                }
            }
            if (mouse.button === Qt.RightButton && !mainWindow.inspecting) {
                inspect()
                inspection.z = 1
            }
        }

        onReleased: {
            checkDropArea(parent)
        }

        drag.target: parent
        //Try to have a way to set an original zone, ie commander starts in the command zone and there is a variable that stores

    }

    function checkDropArea(obj) {
        return
    }

    function inspect() {
        const clone = Qt.createQmlObject('
            import QtQuick
            Image {
                source: card.source
                height: card.height * 2
                width: card.width * 2
            }',
            parent,
            "inspectedCard"
        );
        clone.x = battlefield.x
        clone.y = (battlefield.height / 2) - (clone.height / 2)
        mainWindow.inspecting = true
        mainWindow.insp = clone
    }
}
