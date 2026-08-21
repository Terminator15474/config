import "components"
import "components/time"

import qs.components.divider
import qs.components.colors
import qs.components.config

import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

Scope {
	id: root

	Variants {
		model: Quickshell.screens.filter(s => Config.config.bar.screens.includes(s.name))

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

				Time {}
			}

			RowLayout {
				anchors.right: parent.right
				anchors.verticalCenter: parent.verticalCenter
				anchors.rightMargin: 14
				spacing: 14

				MediaPlayer {
					barRoot: barPanelWindow
				}

				Network {}

				Divider {
					visible: UPower.displayDevice.isLaptopBattery
					dividerColor: Colors.palette.fg
				}

				Battery {
					enabled: UPower.displayDevice.isLaptopBattery
				}

				PowerMenu {}

				// Text {
				// 	text: "vol " + Math.round((Pipewire.defaultAudioSink?.audio?.volume ?? 0) * 100) + "%"
				// 	color: "#9ece6a"
				// }
				//
				// PwObjectTracker { objects: [Pipewire.defaultAudioSink] }

			}
		}
	}
}
