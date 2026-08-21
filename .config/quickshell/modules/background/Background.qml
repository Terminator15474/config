import QtQuick
import Quickshell
import Quickshell.Wayland

Variants {
	model: Quickshell.screens

	PanelWindow {
		id: win

		required property ShellScreen modelData

		screen: modelData

		WlrLayershell.layer: WlrLayer.Background

		color: "black"
		surfaceFormat.opaque: false

		anchors {
			top: true
			bottom: true
			left: true
			right: true
		}

		Loader {
			asynchronous: true
			anchors.fill: parent

			sourceComponent: Wallpaper {}
		}

	}
}
