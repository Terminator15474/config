import QtQuick
import Quickshell

SvgIcon {
	id: root

	signal clicked()
	property alias cursorShape: mouseArea.cursorShape

	TapHandler {
		id: tapHandler

		gesturePolicy: TapHandler.WithinBounds
		onTapped: root.clicked()
	}

	MouseArea {
		id: mouseArea
		anchors.fill: parent
		onClicked: root.clicked()
		cursorShape: Qt.PointingHandCursor
	}
}
