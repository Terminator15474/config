import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.components.icons
import qs.components.colors
import qs.components.states

import "."

RowLayout {
	id: root

	property int fontSize: 10

	Text {
		id: date

		text: SystemClockHelper.date
		color: Colors.palette.fg

		font.pointSize: root.fontSize
	}

	Text {
		id: spacer
		text: " - "
		color: Colors.palette.fg
	}

	Text {
		id: time

		text: SystemClockHelper.time
		color: Colors.palette.fg

		font.pointSize: root.fontSize
	}

	MouseArea {
		onClicked: {
			ShellState.forMainScreen().time = !ShellState.forMainScreen().time
		}
	}

	TapHandler {
		id: tapHandler

		gesturePolicy: TapHandler.WithinBounds
		onTapped: {
			ShellState.forMainScreen().time = !ShellState.forMainScreen().time
		}
	}

	HoverHandler {
		id: hoverHandler
		onHoveredChanged: () => {
			if(!hoverHandler.hovered && !popupHover.hovered && !ShellState.forMainScreen().time) {
				hideTimer.start()
			}
		}
	}

	Timer {
		id: hideTimer
		interval: 150
		repeat: false
		running: false
	}

	PopupWindow {
		id: popup

		anchor.item: root
		anchor.edges: Edges.Bottom
		anchor.gravity: Edges.Bottom
		anchor.margins.top: 24

		implicitWidth: popupLayout.implicitWidth + 24
		implicitHeight: popupLayout.implicitHeight + 24

		visible: ShellState.forMainScreen().time || hoverHandler.hovered || popupHover.hovered || hideTimer.running

		color: "#00ffffff"

		Rectangle {
			id: contentBg
			anchors.fill: parent

			color: Colors.palette.surface
			border.color: Colors.palette.accent
			border.width: 1
			radius: 4

			HoverHandler {
				id: popupHover
			}

			RowLayout {
				id: popupLayout
				anchors.fill: parent
				anchors.margins: 12
				spacing: 12

				Calendar { }

				Rectangle {
					Layout.fillHeight: true
					implicitWidth: 1
					color: Colors.palette.bg
				}

				Alarm { }
			}
		}
	}
}
