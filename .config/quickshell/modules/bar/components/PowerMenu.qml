import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Networking

import qs.components.icons
import qs.components.colors
import qs.components.states

Item {
	id: root

	implicitHeight: wrapper.implicitHeight
	implicitWidth: wrapper.implicitWidth

	function powerOff() {
		Quickshell.execDetached("poweroff")
	}

	function reboot() {
		Quickshell.execDetached("reboot")
	}

	function lock() {
		ShellState.forMainScreen().locked = true
	}

	RowLayout {
		id: wrapper
		anchors.centerIn: parent
		spacing: -4

		// wireless
		MaterialIcon {
			iconName: "power_settings_new"
			color: Colors.palette.fg
			weight: "600"
			size: 20
		}
	}

	HoverHandler {
		id: hoverHandler
		onHoveredChanged: () => {
			if(!hoverHandler.hovered && !popupHover.hovered) {
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
	PopupWindow {
		id: wifiSelector
		visible: hoverHandler.hovered || popupHover.hovered || hideTimer.running

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
				anchors.margins: 10

				Rectangle {
					id: powerOffWrapper

					implicitWidth: powerOff.implicitWidth
					implicitHeight: powerOff.implicitHeight

					color: Colors.palette.surface

					RowLayout {
						id: powerOff
						anchors.fill: parent

						MaterialIcon {
							iconName: "power_settings_new"
							color: Colors.palette.fg
							weight: "600"
							size: 16
						}

						Text {
							text: "Shutdown"
							color: Colors.palette.fg
						}

					}

					TapHandler {
						id: tapHandler

						gesturePolicy: TapHandler.WithinBounds
						onTapped: root.powerOff()
					}

					MouseArea {
						id: mouseArea
						anchors.fill: parent

						cursorShape: Qt.PointingHandCursor
						acceptedButtons: Qt.LeftButton
						hoverEnabled: true

						onClicked: root.powerOff()
						onEntered: () => {
							powerOffWrapper.color = Colors.palette.bg
						}
						onExited: () => {
							powerOffWrapper.color = Colors.palette.surface
						}
					}
				}

				// Rectangle {height: 1; color: Colors.palette.bg; Layout.fillWidth: true}

				Rectangle {
					id: rebootWrapper

					implicitWidth: reboot.implicitWidth
					implicitHeight: reboot.implicitHeight

					color: Colors.palette.surface

					RowLayout {
						id: reboot
						anchors.fill: parent

						MaterialIcon {
							iconName: "restart_alt"
							color: Colors.palette.fg
							weight: "600"
							size: 16
						}

						Text {
							text: "Reboot"
							color: Colors.palette.fg
						}
					}

					TapHandler {
						id: rebootTap

						gesturePolicy: TapHandler.WithinBounds
						onTapped: root.reboot()
					}

					MouseArea {
						id: rebootMouseArea
						anchors.fill: parent

						cursorShape: Qt.PointingHandCursor
						acceptedButtons: Qt.LeftButton
						hoverEnabled: true

						onClicked: root.reboot()
						onEntered: () => {
							rebootWrapper.color = Colors.palette.bg
						}
						onExited: () => {
							rebootWrapper.color = Colors.palette.surface
						}
					}
				}

				Rectangle {
					id: lockWrapper

					implicitWidth: lock.implicitWidth
					implicitHeight: lock.implicitHeight

					color: Colors.palette.surface

					RowLayout {
						id: lock
						anchors.fill: parent

						MaterialIcon {
							iconName: "lock"
							color: Colors.palette.fg
							weight: "600"
							size: 16
						}

						Text {
							text: "Lock"
							color: Colors.palette.fg
						}

					}
					TapHandler {
						id: lockTap

						gesturePolicy: TapHandler.WithinBounds
						onTapped: root.lock()
					}

					MouseArea {
						id: lockMouseArea
						anchors.fill: parent

						cursorShape: Qt.PointingHandCursor
						acceptedButtons: Qt.LeftButton
						hoverEnabled: true

						onClicked: root.lock()
						onEntered: () => {
							lockWrapper.color = Colors.palette.bg
						}
						onExited: () => {
							lockWrapper.color = Colors.palette.surface
						}
					}
				}
			}
		}
	}

}
