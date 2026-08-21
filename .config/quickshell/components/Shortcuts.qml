import QtQuick
import Quickshell
import Quickshell.Hyprland

import "states"

Item {
	id: root

	property bool log: true

	GlobalShortcut {
		description: "Opens the Launcher"
		name: "launcher"

		onPressed: () => {
			ShellState.forMainScreen().launcher = !ShellState.forMainScreen().launcher;
		}
	}
}
