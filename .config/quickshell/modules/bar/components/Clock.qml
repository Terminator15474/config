import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
	id: root
	implicitHeight: text.implicitHeight
	implicitWidth: text.implicitWidth
	Layout.fillWidth: true

	property int fontSize: 10

	Text {
		id: text

		anchors.centerIn: parent

		text: SystemClockHelper.time
		color: "#ddc"

		font.pointSize: root.fontSize
	}
}
