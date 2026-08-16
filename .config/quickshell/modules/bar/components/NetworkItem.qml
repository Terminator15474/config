import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Networking

import qs.components.icons
import qs.components.colors

Item {
	id: root

	required property var device

	readonly property bool isWifi: device.type == DeviceType.Wifi
	readonly property bool isWired: device.type == DeviceType.Wired
	readonly property var connectedNetwork: device.networks.values.find(n => n.connected)

	implicitHeight: wrapper.implicitHeight
	implicitWidth: wrapper.implicitWidth

	function getSignalIcon(network: WifiNetwork): string {
		if(!isWifi) return "" // No signalStrength property
		if (!connectedNetwork.signalStrength <= 0.2) return "wifi_1_bar"
		if (!connectedNetwork.signalStrength <= 0.5) return "wifi_2_bar"
		if (!connectedNetwork.signalStrength <= 0.7) return "android_wifi_3_bar"
		return "android_wifi_4_bar"
	}

	function needsPassword(network: WifiNetwork): bool {
		if (network.security == WifiSecurityType.WpaPsk) return true;
		if (network.security == WifiSecurityType.Wpa2Psk) return true;
		if (network.security == WifiSecurityType.Sae) return true;
	}

	RowLayout {
		id: wrapper
		anchors.centerIn: parent
		spacing: -4

		// Wired
		SvgIcon {
			visible: isWired
			icon: "online/network-connected-monitor"
			color: Colors.palette.fg
			size: 36
		}

		// wireless
		MaterialSvgIcon {
			visible: isWifi
			iconName: {
				if (!device.connected) {
					return "android_wifi_4_bar_off"
				} else {
					return getSignalIcon(connectedNetwork) || "error"
				}
			}
			color: Colors.palette.fg
		}

		// Connection Name
		Text {
			text: connectedNetwork.name
			color: Colors.palette.fg
		}
	}

	HoverHandler {
		id: hoverHandler
		onHoveredChanged: () => {
			if(!hoverHandler.hovered && !popupHover.hovered && isWifi) {
				hideTimer.start()
			}
		}
	}

	Timer {
		id: hideTimer
		interval: 150
		repeat: false
		running: false
	}
	LazyLoader {
		id: popupLoader

		PopupWindow {
			id: wifiSelector
			visible: isWifi && hoverHandler.hovered || popupHover.hovered || hideTimer.running

			anchor.item: root
			anchor.edges: Edges.Bottom
			anchor.gravity: Edges.Bottom
			anchor.margins.top: 24

			implicitWidth: popupLayout.implicitWidth + 24
			implicitHeight: popupLayout.implicitHeight + 24

			color: "#00ffffff"

			Rectangle {
				id: contentBg
				anchors.fill: parent

				color: Colors.palette.surface
				border.color: Colors.palette.accent
				border.width: 1
				radius: 4

				HoverHandler {
					id: popupHover
				}

				ColumnLayout {
					id: popupLayout
					anchors.fill: parent
					anchors.margins: 12
					spacing: 12

					Layout.alignment: Qt.AlignHCenter

					Repeater {
						model: device.networks

						RowLayout {
							id: itemLayout

							property var modelData
							property bool needsPassword: needsPassword(modelData)
							property string iconBase: getSignalIcon(modelData) || "error"
							property bool hasIconAddons: modelData.signalStrength > 0.5

							Layout.alignment: Qt.AlignVCenter

							MaterialSvgIcon {
								iconName: iconBase + ((needsPassword && hasIconAddons) ? "_lock" : "")
								color: Colors.palette.fg
							}

							ColumnLayout {
								id: itemTextLayout

								Layout.alignment: Qt.AlignLeft

								Text {
									text: ""
									color: Colors.palette.fg
								}
							}

						}
					}
				}
			}
		}
	}
}
