import QtQuick
import Quickshell
import qs.components.colors

Icon {
	id: root

	signal clicked()
	property color hoverColor: Colors.palette.accent
	property alias cursorShape: mouseArea.cursorShape

	property color __tmpColor

	TapHandler {
		id: tapHandler

		gesturePolicy: TapHandler.WithinBounds
		onTapped: root.clicked()
	}

	MouseArea {
		id: mouseArea
		anchors.fill: parent

		cursorShape: Qt.PointingHandCursor
		acceptedButtons: Qt.LeftButton
		hoverEnabled: true

		onClicked: root.clicked()
		onEntered: () => {
			__tmpColor = root.color
			root.color = hoverColor
		}
		onExited: () => {
			root.color = __tmpColor
		}
	}
}
