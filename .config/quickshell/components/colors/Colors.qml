pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
	id: root
	FileView {
		id: colorsFile
		path: Quickshell.env("HOME") + "/.cache/iris/colors.json"
		blockLoading: true
	}

	readonly property var palette: JSON.parse(colorsFile.text())
}
