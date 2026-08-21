pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
	id: root
	FileView {
		id: colorsFile
		path: Quickshell.env("HOME") + "/.config/quickshell/config.json"
		blockLoading: true
	}

	readonly property var config: JSON.parse(colorsFile.text())
}
