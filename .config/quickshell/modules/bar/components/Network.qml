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
	readonly property bool isWifi: Networking.devices.values[0].type == DeviceType.Wifi
	readonly property bool isWired: Networking.devices.values[0].type == DeviceType.Wired

	RowLayout {
		id: layout
		anchors.fill: parent
		spacing: 8

		Text {
			id: text
			text: "device 0: " + Networking.devices.values[0].type + ", Address: " + Networking.devices.values[0].address
			color: "#fff"
		}

		Text {
			id: text2
			text: "TEST_ICON:"
			color: "#fff"
		}

		SvgIcon {
			icon: "online/network-connected-monitor"
			size: 36
		}

		// No Connection
		SvgIcon {
			visible: !isConnected
			icon: "online/network-disconnected-monitor-x"
			size: 36
		}

		// Wired Connection
		SvgIcon {
			visible: isConnected && isWired
			icon: "online/network-connected-monitor"
			size: 36
		}

		SvgIcon {
			visible: isConnected && isWifi
			icon: "papirus/network-wireless-connected-symbolic"
		}
	}

}

// NetworkConnectivity lookup
// 0 -> Unknown
// 1 _> None
// 2 -> Portal
// 3 -> Limited
// 4 -> Full
