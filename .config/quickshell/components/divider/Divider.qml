import QtQuick
import QtQuick.Layouts
import Quickshell

Rectangle {
	id: divider

	property color dividerColor: "#fff"
	property int dividerWidth: 1
	property real dividerHeightPct: 0.6
	property int dividerRadius: 8

	Layout.preferredWidth: dividerWidth
	Layout.preferredHeight: parent ? parent.height * dividerHeightPct : 0
	Layout.alignment: Qt.AlignVCenter

	radius: dividerRadius

	color: divider.dividerColor
}
