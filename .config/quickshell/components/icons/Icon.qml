import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import qs.components.colors

Item {
	id: root

	required property string icon
	property color color: Colors.palette.fg

	property real size: 24

	Layout.preferredWidth: root.size
	Layout.preferredHeight: root.size
	Image {
		id: icon
		width: root.size
		height: root.size
		source: Quickshell.shellPath(`assets/icons/${root.icon}.svg`)
		visible: false
	}

	MultiEffect {
		anchors.fill: icon
		source: icon

		colorization: 1.0
		colorizationColor: root.color
		brightness: 1.0
	}
}
