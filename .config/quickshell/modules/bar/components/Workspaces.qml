import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Hyprland

import qs.components.colors

Item {
	id: root

	property int fontSize: 10

	implicitHeight: layout.implicitHeight
	implicitWidth: layout.implicitWidth

	RowLayout {
		id: layout
		anchors.fill: parent
		spacing: 8

		Repeater {
			model: Hyprland.workspaces
			Button {
				background: Rectangle {
					color: Colors.palette.bg
					radius: 4
				}

				onClicked: modelData.activate()

				contentItem: Text {
					anchors.centerIn: parent

					text: modelData.id
					font.pointSize: root.fontSize
					color: modelData.focused ? Colors.palette.fg : Colors.palette.accent

					horizontalAlignment: Text.AlignHCenter
					verticalAlignment: Text.AlignVCenter
				}
			}
		}
	}
}
