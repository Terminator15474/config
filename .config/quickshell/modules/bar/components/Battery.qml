import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower

import qs.components.colors

Item {
	id: root

	property int fontSize: 10
	property bool enabled: true

	visible: root.enabled
	implicitHeight: text.implicitHeight
	implicitWidth: text.implicitWidth

	Text {
		id: text
		text: "bat " + UPower.displayDevice.percentage * 100 + "%"
		color: Colors.palette.green
		anchors.centerIn: parent

		font.pointSize: root.fontSize
	}
}
