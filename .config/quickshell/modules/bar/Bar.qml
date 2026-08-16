import "components"

import qs.components.divider
import qs.components.colors

import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

Scope {
	id: root
	property string time

	Variants {
		model: [Quickshell.screens[0]]

		PanelWindow {
			id: barPanelWindow

			required property var modelData

			screen: modelData

			anchors {
				top: true
				left: true
				right: true
			}

			implicitHeight: 32

			color: Qt.alpha(Colors.palette.surface, 0.8)

			RowLayout {
				anchors.left: parent.left
				anchors.verticalCenter: parent.verticalCenter
				anchors.leftMargin: 14
				spacing: 8

				Workspaces {}
			}

			RowLayout {
				anchors.centerIn: parent
				spacing: 8

				Clock {}
			}

			RowLayout {
				anchors.right: parent.right
				anchors.verticalCenter: parent.verticalCenter
				anchors.rightMargin: 14
				spacing: 8

				MediaPlayer {
					barRoot: barPanelWindow
				}

				Divider {
					dividerColor: Colors.palette.fg
				}

				Network {}

				Divider {
					visible: UPower.displayDevice.isLaptopBattery
					dividerColor: Colors.palette.fg
				}

				Battery {
					enabled: UPower.displayDevice.isLaptopBattery
				}

				// Text {
				// 	text: "vol " + Math.round((Pipewire.defaultAudioSink?.audio?.volume ?? 0) * 100) + "%"
				// 	color: "#9ece6a"
				// }
				//
				// PwObjectTracker { objects: [Pipewire.defaultAudioSink] }
				//
			}
		}
	}
}
