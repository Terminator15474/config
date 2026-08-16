import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import Quickshell.Widgets
import Quickshell.Networking

import qs.components.icons

Item {
	id: root
	implicitHeight: layout.implicitHeight
	implicitWidth: layout.implicitWidth

	readonly property bool isConnected: Networking.connectivity !== NetworkConnectivity.None

	RowLayout {
		id: layout
		anchors.fill: parent
		spacing: 8

		// No Connection
		SvgIcon {
			visible: !isConnected
			icon: "online/network-disconnected-monitor-x"
			size: 36
		}

		// Show icons for all connections
		Repeater {
			model: Networking.devices

			NetworkItem {
				required property var modelData
				device: modelData
				Layout.alignment: Qt.AlignVCenter
			}
		}
	}

}

// NetworkConnectivity lookup
// 0 -> Unknown
// 1 _> None
// 2 -> Portal
// 3 -> Limited
// 4 -> Full
