import QtQuick
import Quickshell

Item {
	id: root

	implicitWidth: img.implicitWidth
	implicitHeight: img.implicitHeight

	Image {
		id: img
		anchors.fill: parent
		fillMode: Image.PreserveAspectCrop

		source: "file://" + Quickshell.env("HOME") + "/Pictures/wallpapers/current"
	}
}
